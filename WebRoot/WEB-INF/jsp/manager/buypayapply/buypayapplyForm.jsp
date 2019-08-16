<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<script type="text/javascript">
$(function(){
	$("#buypayapply_edit_form").form({
		method:'post',
		url : "${ctx }/manager/buypayapply/save.do",
		onSubmit : function() {
				return $(this).form('validate');
		},
		success : function(msg) {
				var json = JSON.parse(msg);
				if (json.statusCode == 200) {
				       
				       $("#buypayapply_edit_box").dialog("close");
				       $("#buypayapply_list_box").datagrid("reload");
				    
				} 
				rightBottom(json.message);
		}
	});
	

});
 
</script>

<form id="buypayapply_edit_form" >
	<table class="table">
		<tr>
			<td align="right" width="100px">付款申请单号：</td>
			<td>
				<input name="number" id="number" size="20" class="easyui-validatebox" data-options="required:true" value="${bean.number}"/>
				<input type="hidden" name="id" id="id" value="${bean.id}"/>
			</td>
			<td align="right" width="100px">坯布流转单号：</td>
			<td>
				<input name="changeplacenumber" id="changeplacenumber" size="20"   value="${bean.changeplacenumber}" class="easyui-validatebox" validtype="remote['${ctx }/manager/changeplace/checkReplace.do','changeplacenumber']" invalidMessage="坯布流转不存在"/>
			</td>
			
		</tr>
		<tr>
		     <td align="right">付款方式：</td>
			<td>
				<select name="type" id="type" >
				 <option value=""></option>
				 <option value="0" <c:if test="${bean.type==0}">selected="selected"</c:if>>现金</option>
				 <option value="1" <c:if test="${bean.type==1}">selected="selected"</c:if>>现金转账支票</option>
				 <option value="2" <c:if test="${bean.type==2}">selected="selected"</c:if>>银行转账支票</option>
				 <option value="3" <c:if test="${bean.type==3}">selected="selected"</c:if>>电子银行转账</option>
				 <option value="4" <c:if test="${bean.type==4}">selected="selected"</c:if>>协议转账</option>
				 <option value="5" <c:if test="${bean.type==5}">selected="selected"</c:if> >其他</option>
				</select>
			</td>
		    <td align="right">收款单位：</td>
			<td>
				<input name="unit" id="unit" size="20"  value="${bean.unit}"  />
			</td>
			
		</tr>
		<tr>
		<td align="right">金额：</td>
			<td>
				<input type="text" name="money" id="money" size="20" class="easyui-validatebox" value="${bean.money}"  />
			</td>
		    <td align="right">事由：</td>
			<td>
				<input name="reason" id="reason" size="20" class="easyui-validatebox" value="${bean.reason}"  />
			</td>
		</tr>
		<tr>
		 <td align="right">申请人：</td>
			<td>
				<input name="applyman" id="applyman" size="20"  value="${bean.applyman}"  />
			</td>
			<td align="right">核准人：</td>
			<td>
				<input type="text" name="approveman" id="approveman" size="20"  value="${bean.approveman}"  />
			</td>
		</tr>
	</table>
	<%@ include file="/commons/forminclude.jsp"%>
</form>
