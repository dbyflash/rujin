<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<script type="text/javascript">
$(function(){
	$("#sellinvoice_edit_form").form({
		method:'post',
		url : "${ctx }/manager/sellinvoice/save.do",
		onSubmit : function() {
				return $(this).form('validate');
		},
		success : function(msg) {
				var json = JSON.parse(msg);
				if (json.statusCode == 200) {
				       
				       $("#sellinvoice_edit_box").dialog("close");
				       $("#sellinvoice_list_box").datagrid("reload");
				    
				} 
				rightBottom(json.message);
		}
	});
	

});
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

<form id="sellinvoice_edit_form" >
	<table class="table">
		<tr>
			<td align="right" width="100px">销售发票编号：</td>
			<td>
				<input name="number" id="number" size="20" class="easyui-validatebox" data-options="required:true" value="${bean.number}"/>
				<input type="hidden" name="id" id="id" value="${bean.id}"/>
			</td>
			<td align="right" width="100px">销售合同编号：</td>
			<td>
				<input name="cnumber" id="cnumber" size="20" class="easyui-validatebox" data-options="required:true" value="${bean.cnumber}" validtype="remote['${ctx }/manager/sellcontract/checkContract.do','cnumber']" invalidMessage="合同不存在"/>
			</td>
			
		</tr>
		<tr>
		     <td align="right">产品名称：</td>
			<td>
				 <input name="productname" id="productname" size="20" onclick="selectProduct('productid','productname')" class="easyui-validatebox" readonly="readonly" value="${bean.productname}"  />
				<input type="hidden" name="productid" id="productid" size="20" class="easyui-validatebox" value="${bean.productid}"  />
			</td>
		    <td align="right">单价：</td>
			<td>
				<input name="price" id="price" size="20" class="easyui-validatebox" value="${bean.price}"  />
			</td>
			
		</tr>
		<tr>
		<td align="right">数量：</td>
			<td>
				<input type="text" name="mount" id="mount" size="20" class="easyui-validatebox" value="${bean.mount}"  />
			</td>
		    <td align="right">金额：</td>
			<td>
				<input name="money" id="money" size="20" class="easyui-validatebox" value="${bean.money}"  />
			</td>
		</tr>
		<tr>
		 <td align="right">税额：</td>
			<td>
				<input name="tax" id="tax" size="20"  value="${bean.tax}"  />
			</td>
			<td align="right">发票类型：</td>
			<td>
				<select  name="type" id="type"  >
				  <option value="0">普通发票</option>
				  <option value="1" <c:if test="${bean.type==1}">selected="selected"</c:if> >专用发票</option>
				</select>
			</td>
		</tr>
		<tr>
		 <td align="right">票据日期：</td>
			<td colspan="3">
				<input name="dt" id="dt" size="20" class="easyui-my97" style=" height: 17px;" readonly="readonly" editable="false" data-options="skin:'twoer',dateFmt:'yyyy-MM-dd'" value="${bean.dt}"  />
			</td>
		</tr>
	</table>
	<%@ include file="/commons/forminclude.jsp"%>
</form>
