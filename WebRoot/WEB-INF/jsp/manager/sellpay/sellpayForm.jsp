<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<script type="text/javascript">
$(function(){



	$("#sellpay_edit_form").form({
		method:'post',
		url : "${ctx }/manager/sellpay/save.do",
		onSubmit : function() {
				return $(this).form('validate');
		},
		success : function(msg) {
				var json = JSON.parse(msg);
				if (json.statusCode == 200) {
				       
				       $("#sellpay_edit_box").dialog("close");
				       $("#sellpay_list_box").datagrid("reload");
				    
				} 
				rightBottom(json.message);
		}
	});
	
});

  function selectMoneytype(id,name){
 	$("<div id='selectMoneytype' style='padding: 0px'></div>").show().dialog({
			width:500,
			height:400,
			modal:true,
			href:'${ctx }/manager/sellpay/selectMoneytype.do',
			title:'选择外币',
			buttons: [{
					text:'确定',
					iconCls:'icon-ok',
					handler:function(){
						savesearch_moneytype(id,name);//保存
						$("#selectMoneytype").dialog("destroy");
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$("#selectMoneytype").dialog("destroy");
					}
				}],
		    onClose : function() {
               $(this).dialog('destroy');
            } 
				
		});
 	}
</script>

<form id="sellpay_edit_form" >
	<table class="table">
		<tr>
			<td align="right" width="100px">付款单位：</td>
			<td>
				<input name="unitname" id="unitname" size="20" class="easyui-validatebox" data-options="required:true" value="${bean.unitname}"/>
				<input type="hidden" name="id" id="id" value="${bean.id}"/>
			</td>
			<td align="right" width="100px">结算方式：</td>
			<td>
				<select name="paytype" id="paytype" >
				 <option value=""></option>
				 <option value="0" <c:if test="${bean.paytype==0}">selected="selected"</c:if>>现金</option>
				 <option value="1" <c:if test="${bean.paytype==1}">selected="selected"</c:if>>现金转账支票</option>
				 <option value="2" <c:if test="${bean.paytype==2}">selected="selected"</c:if>>银行转账支票</option>
				 <option value="3" <c:if test="${bean.paytype==3}">selected="selected"</c:if>>电子银行转账</option>
				 <option value="4" <c:if test="${bean.paytype==4}">selected="selected"</c:if>>协议转账</option>
				 <option value="5" <c:if test="${bean.paytype==5}">selected="selected"</c:if> >其他</option>
				</select>
			</td>
			
		</tr>
		<tr>
		     <td align="right">单据号码：</td>
			<td>
				<input type="text" name="number" id="number" size="20" class="easyui-validatebox" value="${bean.number}"  />
			</td>
		    <td align="right">销售合同编号：</td>
			<td>
				<input name="cnumber" id="cnumber" size="20" class="easyui-validatebox" data-options="required:true" value="${bean.cnumber}" validtype="remote['${ctx }/manager/sellcontract/checkContract.do','cnumber']" invalidMessage="合同不存在" />
			</td>
			
		</tr>
		<tr>
		<td align="right">外币种类：</td>
			<td>
				<input name="moneytypename" id="moneytypename" onclick="selectMoneytype('moneytypeid','moneytypename')"   value="${bean.moneytypename}" class="easyui-validatebox" readonly="readonly" />
				<input type="hidden" name="moneytypeid" id="moneytypeid" size="20" class="easyui-validatebox" value="${bean.moneytypeid}"  />
			</td>
		    <td align="right">外币金额：</td>
			<td>
				<input name="foreignmoney" id="foreignmoney" size="20" class="easyui-validatebox" value="${bean.foreignmoney}"  />
			</td>
		</tr>
		<tr>
		 <td align="right">人民币：</td>
			<td>
				<input name="money" id="money" size="20"  value="${bean.money}"  />
			</td>
			<td align="right">银行业务编号：</td>
			<td>
				<input type="text" name="banknumber" id="banknumber" size="20"  value="${bean.banknumber}"  />
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
