<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<script type="text/javascript">
$(function(){
    var id='${bean.id}';
  
	$("#menuManage_edit_form").form({
		method:'post',
		url : "${ctx}/system/resource/save.do",
		onSubmit : function() {
				return $(this).form('validate');
		},
		success : function(msg) {
				var json = JSON.parse(msg);
				if (json.statusCode == 200) {
				 	$("#menuManage_edit_box").dialog("close");
				 	$("#menuset_tree").tree("reload");
				}
				rightBottom(json.message);
		}
	});
	 
 	});
</script>

<form id="menuManage_edit_form" >
			<table border="0" align="center" class="table" width="100%">
				<tr>
					<td align="left" width="60"  nowrap="nowrap">名称：</td>
					<td align="left">
					    <input type="hidden" id="id" name="id" value="${bean.id }">
					    <input type="hidden" id="roleid" name="roleid" value="${param.roleid }">
					    <c:if test="${empty bean.id }">
					     <input type="hidden" id="pid" name="pid" value="${param.pid }">
					    </c:if>
					    <c:if test="${not empty bean.id }">
					     <input type="hidden" id="pid" name="pid" value="${bean.pid }">
					    </c:if>
						<input style="width: 400px;" class="easyui-validatebox" id="name" name="name" data-options="required:true" value="${bean.name }"/>
					</td>
				</tr>
				<tr>
					<td align="left" width="60"  nowrap="nowrap">URL：</td>
					<td align="left">
						<input style="width: 400px;" class="easyui-validatebox" id="resstring"  name="resstring"  value="${bean.resstring }"/>
					</td>
				</tr>
				<tr>
					<td align="left" width="60"  nowrap="nowrap">行号：</td>
					<td align="left">
						<input style="width: 100px;" class="easyui-numberbox" required="true" value="${bean.ordernum }"  data-options="precision:0,min:0,max:999999" id="ordernum" name="ordernum" data-options="required:true" />
					</td>
				</tr>
			</table>
	   <%@ include file="/commons/forminclude.jsp"%>
</form>