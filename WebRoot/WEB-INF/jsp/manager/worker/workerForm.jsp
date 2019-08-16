<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<script type="text/javascript">
$(function(){
	$("#worker_edit_form").form({
		method:'post',
		url : "${ctx }/manager/worker/save.do",
		onSubmit : function() {
				return $(this).form('validate');
		},
		success : function(msg) {
				var json = JSON.parse(msg);
				if (json.statusCode == 200) {
				       
				       $("#worker_edit_box").dialog("close");
				       $("#worker_list_box").datagrid("reload");
				    
				} 
				rightBottom(json.message);
		}
	});
	

});
 
</script>

<form id="worker_edit_form" >
	<table class="table">
		<tr>
			<td align="right" width="80px">姓&nbsp;&nbsp;名：</td>
			<td>
				<input name="name" id="name" size="20" class="easyui-validatebox" value="${bean.name}" data-options="required:true" />
				<input type="hidden" name="id" id="id" value="${bean.id}"/>
				<span style="color:blue">&nbsp;*</span>
			</td>
			
		</tr>
		<tr>
			<td align="right">性&nbsp;&nbsp;别：</td>
			<td>
				<select  name="sex" id="sex" >
				 <option value="1">女</option>
				 <option value="0" <c:if test="${bean.sex==0}">selected="selected"</c:if> >男</option>
				</select>
			</td>
		</tr>
		<tr>
			<td align="right">年&nbsp;&nbsp;龄：</td>
			<td>
				<input  name="age" id="age" value="${bean.age}"/>
			</td>
		</tr>
		<tr>
			<td align="right">工&nbsp;&nbsp;号：</td>
			<td>
				<input  name="gh" id="gh" value="${bean.gh}"/>
			</td>
		</tr>
		<tr>
			<td align="right">电&nbsp;&nbsp;话：</td>
			<td>
				<input  name="tel" id="tel" value="${bean.tel}"/>
			</td>
		</tr>
	</table>
	<%@ include file="/commons/forminclude.jsp"%>
</form>
