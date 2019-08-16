<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<script type="text/javascript">
$(function(){
 var parentid='${param.parentid}';
	$("#dictionary_edit_form").form({
		method:'post',
		url : "${ctx }/system/dictionary/save.do",
		onSubmit : function() {
				return $(this).form('validate');
		},
		success : function(msg) {
				var json = JSON.parse(msg);
				if (json.statusCode == 200) {
				       if(parentid==''){
				          //更新本行
				         var row = $("#treegrid").treegrid("getSelected");
					     var index = $("#treegrid").treegrid("getRowIndex",row);
					     row.name = $("#name").val();
					     row.descn = $("#descn").val();
					     $("#treegrid").treegrid("update",{id:row.id});
				       }else{
				         $('#treegrid').treegrid("reload",parentid);
				       }
				       
				       $("#dictionary_edit_box").dialog("close");
				    
				} 
				rightBottom(json.message);
		}
	});
	

});
 
</script>

<form id="dictionary_edit_form" >
	<table class="table">
		<tr>
			<td align="right">名&nbsp;&nbsp;称：</td>
			<td>
				<input type="text" name="name" id="name" size="20" class="easyui-validatebox" value="${bean.name}"
					data-options="required:true" />
				<input type="hidden" name="id" id="id" value="${bean.id}"/>
				<c:if test="${empty bean.id }">
				  <input type="hidden" name="parentid" id="parentid" value="${param.parentid}"/>
				</c:if>
				<c:if test="${not empty bean.id }">
				  <input type="hidden" name="parentid" id="parentid" value="${bean.parentid}"/>
				</c:if>
			<span style="color:blue">&nbsp;*</span></td>
		</tr>
		<tr>
			<td align="right">备&nbsp;&nbsp;注：</td>
			<td>
				<textarea rows="4" cols="20" name="descn" id="descn">${bean.descn}</textarea>
			</td>
		</tr>
	</table>
	<%@ include file="/commons/forminclude.jsp"%>
</form>
