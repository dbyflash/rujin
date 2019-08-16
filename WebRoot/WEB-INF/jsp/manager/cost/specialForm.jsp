<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<script type="text/javascript">
$(function(){
	$("#cost_edit_form").form({
		method:'post',
		url : "${ctx }/manager/cost/saveSpecial.do",
		onSubmit : function() {
				return $(this).form('validate');
		},
		success : function(msg) {
				var json = JSON.parse(msg);
				if (json.statusCode == 200) {
				       
				       $("#cost_edit_box").dialog("close");
				       $("#cost_list_box").datagrid("reload");
				    
				} 
				rightBottom(json.message);
		}
	});
	

});
 
</script>

<form id="cost_edit_form" >
	<table class="table">
		<tr>
			<td align="right" width="100px" >费用名称：</td>
			<td colspan="3">
				<input name="name" id="name" size="20" class="easyui-validatebox" data-options="required:true" value="${bean.name}"/>
				<input type="hidden" name="id" id="id" value="${bean.id}"/>
			</td>
			
			
		</tr>
		
		<tr>
		<td align="right">金额：</td>
			<td colspan="3">
				<input type="text" name="money" id="money" size="20" class="easyui-validatebox" value="${bean.money}"  />
			</td>
		    
		</tr>
		<tr>
		 <td align="right">日期：</td>
			<td colspan="3">
				<input name="dt" id="dt" size="20" class="easyui-my97" style=" height: 17px;" readonly="readonly" editable="false" data-options="skin:'twoer',dateFmt:'yyyy-MM-dd'" value="${bean.dt}"  />
			</td>
		</tr>
	</table>
	<%@ include file="/commons/forminclude.jsp"%>
</form>
