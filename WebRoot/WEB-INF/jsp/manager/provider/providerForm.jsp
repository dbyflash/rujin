<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<script type="text/javascript">
$(function(){
	$("#provider_edit_form").form({
		method:'post',
		url : "${ctx }/manager/provider/save.do",
		onSubmit : function() {
				return $(this).form('validate');
		},
		success : function(msg) {
				var json = JSON.parse(msg);
				if (json.statusCode == 200) {
				       
				       $("#provider_edit_box").dialog("close");
				       $("#provider_list_box").datagrid("reload");
				    
				} 
				rightBottom(json.message);
		}
	});
	

});
 
</script>

<form id="provider_edit_form" >
	<table class="table">
		<tr>
			<td align="right" width="100px">供应商名称：</td>
			<td>
				<input name="name" id="name" size="20" class="easyui-validatebox" data-options="required:true" value="${bean.name}"/>
				<input type="hidden" name="id" id="id" value="${bean.id}"/>
			</td>
			
		</tr>
		<tr>
		     <td align="right">地址：</td>
			<td>
				<input type="text" name="addr" id="addr" size="20" class="easyui-validatebox" value="${bean.addr}"  />
			</td>
			
		</tr>
		<tr>
		<td align="right">电话：</td>
			<td>
				<input type="text" name="tel" id="tel" size="20" class="easyui-validatebox" value="${bean.tel}"  />
			</td>
		</tr>
		<tr>
		 <td align="right">备注：</td>
			<td>
				<textarea name="mark" id="mark" rows="5" >${bean.mark}</textarea>
			</td>
		</tr>
	</table>
	<%@ include file="/commons/forminclude.jsp"%>
</form>
