<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<script type="text/javascript">
$(function(){
	$("#sellcontract_edit_form").form({
		method:'post',
		url : "${ctx }/manager/sellcontract/save.do",
		onSubmit : function() {
				return $(this).form('validate');
		},
		success : function(msg) {
				var json = JSON.parse(msg);
				if (json.statusCode == 200) {
				       
				       $("#sellcontract_edit_box").dialog("close");
				       $("#sellcontract_list_box").datagrid("reload");
				    
				} 
				rightBottom(json.message);
		}
	});
	

});
function selectCustomer(id,name){
 	$("<div id='selectCustomer' style='padding: 0px'></div>").show().dialog({
			width:500,
			height:400,
			modal:true,
			href:'${ctx }/manager/sellcontract/selectCustomer.do',
			title:'选择客户',
			buttons: [{
					text:'确定',
					iconCls:'icon-ok',
					handler:function(){
						savesearch_customer(id,name);//保存
						$("#selectCustomer").dialog("destroy");
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$("#selectCustomer").dialog("destroy");
					}
				}],
		    onClose : function() {
               $(this).dialog('destroy');
            } 
				
		});
 	}
 function selectProduct(id,name){
 	$("<div id='selectProduct' style='padding: 0px'></div>").show().dialog({
			width:500,
			height:400,
			modal:true,
			href:'${ctx }/manager/sellcontract/selectProduct.do',
			title:'选择产品',
			buttons: [{
					text:'确定',
					iconCls:'icon-ok',
					handler:function(){
						savesearch_product(id,name);//保存
						$("#selectProduct").dialog("destroy");
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$("#selectProduct").dialog("destroy");
					}
				}],
		    onClose : function() {
               $(this).dialog('destroy');
            } 
				
		});
 	}
</script>

<form id="sellcontract_edit_form" >
	<table class="table">
		<tr>
			<td align="right">合同编号：</td>
			<td>
				<input name="number" id="number" size="25" class="easyui-validatebox" value="${bean.number}" data-options="required:true" />
				<input type="hidden" name="id" id="id" value="${bean.id}"/>
			<td align="right">产品名称：</td>
			<td>
			    <input name="productname" id="productname" size="25" onclick="selectProduct('productid','productname')" class="easyui-validatebox" readonly="readonly" value="${bean.productname}"  />
				<input type="hidden" name="productid" id="productid" size="25" class="easyui-validatebox" value="${bean.productid}"  />
			</td>
		</tr>
		<tr>
		 <td align="right">单价：</td>
			<td>
				<input name="price" id="price" size="25" class="easyui-validatebox" value="${bean.price}"  />
			<td align="right">数量：</td>
			<td>
				<input type="text" name="mount" id="mount" size="25" class="easyui-validatebox" value="${bean.mount}"  />
			</td>
		</tr>
		<tr>
		 <td align="right">金额：</td>
			<td>
				<input name="money" id="money" size="25" class="easyui-validatebox" value="${bean.money}"  />
			</td>
			<td align="right">销售人员：</td>
			<td>
				<input type="text" name="sellperson" id="sellperson" size="25" class="easyui-validatebox" value="${bean.sellperson}"  />
			</td>
			
		</tr>
		<tr>
		 <td align="right">签订日期：</td>
			<td>
				<input name="signdate" id="signdate" size="25" class="easyui-my97" style=" height: 17px;" readonly="readonly" editable="false" data-options="skin:'twoer',dateFmt:'yyyy-MM-dd'" value="${bean.signdate}"  />
			</td>
			<td align="right">交货日期：</td>
			<td>
				<input type="text" name="dt" id="dt" size="25" class="easyui-my97" style=" height: 17px;" readonly="readonly" editable="false" data-options="skin:'twoer',dateFmt:'yyyy-MM-dd'" value="${bean.dt}"  />
			</td>
		</tr>
		<tr>
		 <td align="right">客户：</td>
			<td>
				<input name="customername" id="customername" size="25" onclick="selectCustomer('customerid','customername')" class="easyui-validatebox" readonly="readonly" value="${bean.customername}"  />
				<input type="hidden" name="customerid" id="customerid" size="25" class="easyui-validatebox" value="${bean.customerid}"  />
			</td>
			<td align="right">翻单：</td>
			<td>
				<input type="text" name="cnumber" id="cnumber" size="25" class="easyui-validatebox" value="${bean.cnumber}" validtype="remote['${ctx }/manager/sellcontract/checkContract.do','cnumber']" invalidMessage="合同不存在" />
			</td>
		</tr>
	</table>
	<%@ include file="/commons/forminclude.jsp"%>
</form>
