<?php
class startapi {
	private $db;

	public function __construct() {
		$this->db = $this->conn();
	}
	
	/**
	 * startapi::conn()
	 * 连接数据库
	 * @return
	 */
	private function conn() {
		$config = require_once 'conn.php';
		@ $db = new mysqli($config['host'], $config['user'], $config['passwd'], $config['dbname'], $config['port']);
		if ($db->connect_error) {
			exit('can\'t conn db:' . $db->connect_error);
		}
		$db->set_charset("utf8");	
		return $db;		
	}
	
	/**
	 * startapi::db_select()
	 * 数据库查询
	 * @param mixed $sql
	 * @return
	 */
	public function db_select($sql = '', $list = false) {
		$result = $this->db->query($sql);
		$rows = array();
		while($row = $result->fetch_assoc()) {
			$rows[] = $row;
		}
		return $list ? $rows : (count($rows) ? $rows[0] : array());
	}
	
	/**
	 * startapi::type_lists()
	 * 接口分类列表
	 * @return
	 */
	public function type_lists() {
		return $this->db_select("SELECT * FROM `type` WHERE deleted = 0 ORDER BY sort DESC, id ASC", true);
	}
	
	/**
	 * startapi::type_add()
	 * 分类新增
	 * @param array $post
	 * @return
	 */
	public function type_add($post = array()) {
		$this->db->query("INSERT INTO `type` (`title`, `desc`) VALUES ('$post[title]', '$post[desc]')");
		return $this->db->insert_id;
	}
	
	/**
	 * startapi::type_update()
	 * 分类更新
	 * @param integer $id
	 * @param array $post
	 * @return
	 */
	public function type_update($id = 0, $post = array()) {
		return $this->db->query("UPDATE `type` SET `title` = '$post[title]', `desc` = '$post[desc]' WHERE id = $id");
	}
	
	/**
	 * startapi::type_info()
	 * 分类信息
	 * @param integer $id
	 * @return
	 */
	public function type_info($id = 0) {
		return $this->db_select("SELECT * FROM `type` WHERE id = $id");
	}
	
	/**
	 * startapi::type_del()
	 * 分类删除
	 * @param integer $id
	 * @return
	 */
	public function type_del($id = 0) {
		return $this->db->query("UPDATE `type` SET deleted = 1 WHERE id = $id");
	}
	
	/**
	 * startapi::type_sort()
	 * 分类排序
	 * @param mixed $new_sort
	 * @return void
	 */
	public function type_sort($new_sort = array()) {
		$when = '';
		foreach ($new_sort as $k => $v) {
			$when .= ' WHEN ' . $k . ' THEN ' . $v;
		}
		return $this->db->query("UPDATE `type` SET `sort` = CASE `id` " . $when . ' END WHERE `id` IN (' . implode(',', array_keys($new_sort)) . ')');
	}
	
	/**
	 * startapi::api_lists()
	 * 接口列表
	 * @param integer $type_id
	 * @return
	 */
	public function api_lists($type_id = 0) {
		return $this->db_select("SELECT * FROM `api` WHERE deleted = 0" . ($type_id ? " AND type_id = $type_id" : '') . " ORDER BY sort DESC, id ASC", true);
	}
	
	/**
	 * startapi::api_init()
	 * 接口参数处理
	 * @param mixed $post
	 * @return void
	 */
	public function api_init($post = array()) {
		$post['is_authed'] = isset($post['is_authed']) ? 1 : 0;
		if (isset($post['request_param'])) {
			foreach ($post['request_param'] as $k => $v) {
				$post['request_param'][$k]['is_required'] = isset($v['is_required']) ? 1 : 0;
			}			
		} else {
			$post['request_param'] = array();
		}
		
		if (isset($post['result_param'])) {
			foreach ($post['result_param'] as $k => $v) {
				$post['result_param'][$k]['is_required'] = isset($v['is_required']) ? 1 : 0;
			}
		} else {
			$post['result_param'] = array();
		}
		$post['request_param'] = json_encode(array_values($post['request_param']), JSON_UNESCAPED_UNICODE);
		$post['result_param'] = json_encode(array_values($post['result_param']), JSON_UNESCAPED_UNICODE);

		return $post;
	}
	
	/**
	 * startapi::api_add()
	 * 新增接口
	 * @param mixed $post
	 * @return
	 */
	public function api_add($post = array()) {
		$post = $this->api_init($post);
		return $this->db->query("INSERT INTO `api` (`type_id`, `title`, `uri`, `method_type`, `desc`, `request_param`, `result_param`, `request_code`, `result_code`, `is_authed`) 
		VALUES ('$post[type_id]', '$post[title]', '$post[uri]', '$post[method_type]', '$post[desc]', '$post[request_param]', '$post[result_param]', '$post[request_code]', '$post[result_code]', '$post[is_authed]')");
	}
	
	/**
	 * startapi::api_update()
	 * 更新接口
	 * @param integer $id
	 * @param mixed $post
	 * @return
	 */
	public function api_update($id = 0, $post = array()) {
		$post = $this->api_init($post);
		return $this->db->query("UPDATE `api` SET `title` = '$post[title]', `uri` = '$post[uri]', `method_type` = '$post[method_type]', `desc` = '$post[desc]', `request_param` = '$post[request_param]',
		 `result_param` = '$post[result_param]', `request_code` = '$post[request_code]', `result_code` = '$post[result_code]', `is_authed` = '$post[is_authed]' WHERE `id` = $id");
	}
	
	/**
	 * startapi::api_sort()
	 * 接口排序
	 * @param mixed $new_sort
	 * @return
	 */
	public function api_sort($new_sort = array()) {
		$when = '';
		foreach ($new_sort as $k => $v) {
			$when .= ' WHEN ' . $k . ' THEN ' . $v;
		}
		return $this->db->query("UPDATE `api` SET `sort` = CASE `id` " . $when . ' END WHERE `id` IN (' . implode(',', array_keys($new_sort)) . ')');
	}
	
	/**
	 * startapi::api_info()
	 * 接口信息
	 * @param integer $id
	 * @return
	 */
	public function api_info($id = 0) {
		return $this->db_select("SELECT * FROM `api` WHERE id = $id");
	}	
	
	/**
	 * startapi::api_del()
	 * 接口删除
	 * @param integer $id
	 * @return
	 */
	public function api_del($id = 0) {
		return $this->db->query("UPDATE `api` SET deleted = 1 WHERE id = $id");
	}	
	
}