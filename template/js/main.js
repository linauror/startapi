$(function() {
	var param_line = '<tr>' +
					'<td><input type="text" name="request_param[param_index][field]" required="true" /></td>' +
					'<td><select name="request_param[param_index][data_type]"><option value="string">string</option><option value="int">int</option><option value="array">array</option><option value="json">json</option></select></td>' +
					'<td><input type="checkbox" name="request_param[param_index][is_required]" value="1" /></td>' +
					'<td><input type="text" name="request_param[param_index][default]" /></td>' +
					'<td><input type="text" name="request_param[param_index][desc]" /></td>' +
					'<td class="action"><a href="javascript:;" class="del_param" title="删除参数">删除</a> | <a href="javascript:;" class="insert_param" title="插入参数">插入</a></td>' +
				'</tr>';
	$('.confirm_del').click(function() {
		if (! confirm('确认删除吗？')) {
			return false;
		}
	})
	$('.add_param').click(function() {
		request_param_index++;
		param_line = param_line.replace(/request_param/g, $(this).parents('.param_block').attr('id'));
		$(this).prev('table').find('tbody').append(param_line.replace(/param_index/g, request_param_index));
	})
	$('.del_param').live('click', function() {
		if (confirm('确定删除吗？')) {
			$(this).parents('tr').remove();
		}
	})
	$('.insert_param').live('click', function() {
		request_param_index++;
		param_line = param_line.replace(/request_param/g, $(this).parents('.param_block').attr('id'));
		$(this).parents('tr').after(param_line.replace(/param_index/g, request_param_index));		
	})
})
function list_sort(post_url) {
	var new_sort = new Object();
	var sort_max = $('.dd-item').length;
	if (! sort_max) {
		return false;
	}
	$('.dd-item').each(function() {
		new_sort[$(this).attr('data-id')] = sort_max;
		sort_max--;
	})
	$.post(post_url, {'sort' : JSON.stringify(new_sort)}, function() {
		$('#msg_tip').html('<p>排序保存成功</p>');
	});		
}