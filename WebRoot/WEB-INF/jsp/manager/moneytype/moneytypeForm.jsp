<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<script type="text/javascript">
$(function(){
	$("#moneytype_edit_form").form({
		method:'post',
		url : "${ctx }/manager/moneytype/save.do",
		onSubmit : function() {
				return $(this).form('validate');
		},
		success : function(msg) {
				var json = JSON.parse(msg);
				if (json.statusCode == 200) {
				       
				       $("#moneytype_edit_box").dialog("close");
				       $("#moneytype_list_box").datagrid("reload");
				    
				} 
				rightBottom(json.message);
		}
	});
	

});
 
</script>

<form id="moneytype_edit_form" >
	<table class="table">
		<tr>
			<td align="right" width="100px">外币代码：</td>
			<td>
				<input name="code" id="code" size="20" class="easyui-validatebox"  value="${bean.code}"/>
				<input type="hidden" name="id" id="id" value="${bean.id}"/>
			</td>
			
		</tr>
		<tr>
		     <td align="right">外币名称：</td>
			<td>
				<input type="text" name="name" id="name" size="20" class="easyui-validatebox" data-options="required:true" value="${bean.name}"  />
			</td>
			
		</tr>
	</table>
	<%@ include file="/commons/forminclude.jsp"%>
</form>
