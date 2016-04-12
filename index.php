<?php
header("Content-type: text/html; charset=utf-8");
new index();

class index {
    public function __construct() {
        require_once 'startapi.php';
        $this->startapi = new startapi();
        $this->html_array = array();
        $this->data_type = array('string', 'int', 'array', 'json');
        define('BASEPATH', dirname(__FILE__) . '\\');
        define('CONTROLLER', isset($_SERVER['PATH_INFO']) ? substr($_SERVER['PATH_INFO'], 1) : 'index');
        define('DOMAIN', $_SERVER['REQUEST_SCHEME'] . '://' . $_SERVER['HTTP_HOST'] . dirname($_SERVER['SCRIPT_NAME']) . '/');
        define('TEMPLATE_PATH', 'template');
        define('TEMPLATE_URL', DOMAIN . '/' . TEMPLATE_PATH . '/');
        $this->config = require_once BASEPATH . 'config.php';
        if (method_exists($this, CONTROLLER)) {
            call_user_func(array('index', CONTROLLER));
        } else {
            $this->show_404();
        }
    }

    /**
     * index::index()
     * 首页
     * @return void
     */
    public function index() {
        $type_lists = $this->startapi->type_lists();
        $html['type_lists'] = $type_lists;
        $html['header_title'] = '首页';
        $this->view('index', $html);
    }
	
    /**
     * index::type_del()
     * 接口分类删除
     * @return void
     */
    public function type_del() {
        $id = $_GET['id'];
        $del = $this->startapi->type_del($id);
        $this->show_tip('删除成功', 'success');
    }

    /**
     * index::type_add()
     * 分类新增
     * @return void
     */
    public function type_add() {
        if (isset($_POST['title'])) {
            $add = $this->startapi->type_add($_POST);
            $this->show_tip('分类新增成功', 'success', $this->site_url('index'));
        }

        $html['header_title'] = '分类新增';
        $this->view('type_add', $html);
    }

    /**
     * index::type_update()
     * 分类更新
     * @return void
     */
    public function type_update() {
        $id = $_GET['id'];
        if (isset($_POST['id'])) {
            $update = $this->startapi->type_update($_POST['id'], $_POST);
            $this->show_tip('分类更新成功', 'success', $this->site_url('index'));
        }
        $html['data'] = $this->startapi->type_info($id);
        $html['header_title'] = '分类更新';
        $this->view('type_update', $html);
    }
    
    /**
     * index::type_sort()
     * 分类排序
     * @return void
     */
    public function type_sort() {
    	$result = $this->startapi->type_sort(json_decode($_POST['sort'], true));
    }

    /**
     * index::api_lists()
     * 接口列表
     * @return void
     */
    public function api_lists() {
        $html['type_info'] = $this->startapi->type_info($_GET['type_id']);
        $html['api_lists'] = $this->startapi->api_lists($_GET['type_id']);
        $html['header_title'] = '接口列表';
        $this->view('api_lists', $html);
    }

    /**
     * index::api_del()
     * 接口删除
     * @return void
     */
    public function api_del() {
        $del = $this->startapi->api_del($_GET['id']);
        $this->show_tip('删除成功', 'success');
    }

    /**
     * index::api_add()
     * 接口新增
     * @return void
     */
    public function api_add() {
        if (isset($_POST['title'])) {
            $add = $this->startapi->api_add($_POST);
            $this->show_tip('接口新增成功', 'success', $this->site_url('api_lists') . '?type_id=' . $_POST['type_id']);
        }
		$html['type_info'] = $this->startapi->type_info($_GET['type_id']);
        $html['header_title'] = '接口新增';
        $this->view('api_add', $html);
    }
	
    /**
     * index::api_update()
     * 接口更新
     * @return void
     */
    public function api_update() {
        $id = $_GET['id'];
        if (isset($_POST['title'])) {
            $add = $this->startapi->api_update($_POST['id'], $_POST);
            $this->show_tip('接口更新成功', 'success', $this->site_url('api_lists') . '?type_id=' . $_POST['type_id']);
        }
        $data = $this->startapi->api_info($id);
        $data['request_param'] = json_decode($data['request_param'], true);
        $data['result_param'] = json_decode($data['result_param'], true);
        
        $html['data'] = $data;
        $html['header_title'] = '接口更新';
        $this->view('api_update', $html);
    }	
	
    /**
     * index::api_sort()
     * 接口排序
     * @return void
     */
    public function api_sort() {
    	$result = $this->startapi->api_sort(json_decode($_POST['sort'], true));
    }
	
	/**
	 * index::set()
	 * 设置
	 * @return void
	 */
	public function set() {
		if (isset($_POST['title'])) {
			$config_str = '';
			foreach ($_POST as $k => $v) {
				$v = addslashes($v);
				$config_str .= "	'$k' => '$v',\r\n";
			}
			$config_content = "<?php\r\nreturn array(\r\n" . $config_str . ");";
			file_put_contents(BASEPATH . 'config.php', $config_content);
			$this->show_tip('设置更新成功', 'success', $this->site_url('index'));
		}
		
        $html['header_title'] = '设置';
        $this->view('set', $html);			
	}
	
	/**
	 * index::publish()
	 * 发布
	 * @return void
	 */
	public function publish() {
		$type_lists = $this->startapi->type_lists();
		
		$_api_lists = $this->startapi->api_lists();
		$api_lists = array();
		foreach ($_api_lists as $line) {
			$api_lists[$line['type_id']][] = $line;
		}
		$array = array('type_lists' => $type_lists, 'api_lists' => $api_lists);
		
		ob_start();
		$this->view('publish', $array);
		$_html = ob_get_contents();
		ob_end_clean();
		file_put_contents(BASEPATH . 'api.html', $_html);
		
		
        $html['header_title'] = '接口发布';
        $this->view('publish_success', $html);		
	}
	
    /**
     * index::site_url()
     * 生成url
     * @param string $uri
     * @return
     */
    private function site_url($uri = '') {
        return DOMAIN . 'index.php/' . $uri;
    }

    /**
     * index::view()
     * 加载模板
     * @param string $file_name
     * @return void
     */
    private function view($file_name = '', $array = array()) {
        if ($array) {
            $this->html_array += $array;
        }
        if ($this->html_array) {
            extract($this->html_array);
        }
        require_once BASEPATH . TEMPLATE_PATH . '/' . $file_name . '.html';
    }

    /**
     * index::show_404()
     * 404
     * @return void
     */
    private function show_404() {
        $this->view('404', array('header_title' => '404 page not found'));
        exit;
    }

    /**
     * index::show_tip()
     * 提示信息
     * @param string $msg
     * @param string $type
     * @param string $go
     * @return void
     */
    private function show_tip($msg = '', $type = 'success', $go = '') {
        setcookie('startapi_msg_tip', '<p class="' . $type . '">' . $msg . '</p>', time() + 5, '/');
        if ($go == '') {
            $go = $_SERVER['HTTP_REFERER'];
        }
        $this->redirect($go);
    }

    /**
     * index::redirect()
     * 跳转
     * @param string $url
     * @return void
     */
    private function redirect($url = '') {
        header('Location:' . $url);
    }
}
