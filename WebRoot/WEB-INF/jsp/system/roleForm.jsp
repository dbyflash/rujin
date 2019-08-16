<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<script type="text/javascript">
$(function(){
    var id='${bean.id}';
  
	$("#role_edit_form").form({
		method:'post',
		url : "${ctx}/system/role/save.do",
		onSubmit : function() {
				return $(this).form('validate');
		},
		success : function(msg) {
				var json = JSON.parse(msg);
				if (json.statusCode == 200) {
				       $("#role_list_box").datagrid("reload");
				       $("#role_edit_box").dialog("close");
				 
				} 
				rightBottom(json.message);
		}
	});
	 
 	});
</script>

<form id="role_edit_form" >
	<table class="table">
		<tr>
			<td align="right">名&nbsp;&nbsp;称：</td>
			<td>
				<input type="text" name="name" id="name" size="25" class="easyui-validatebox" value="${bean.name}"
					data-options="required:true" />
				<input type="hidden" name="id" value="${bean.id}"/>
			 </td>
		</tr>
		<tr>
			<td align="right">备&nbsp;&nbsp;注</td>
			<td>
				<textarea rows="4" cols="20" name="descn" id="descn">${bean.descn}</textarea>
			</td>
		</tr>
	</table>
	   <%@ include file="/commons/forminclude.jsp"%>
</form>