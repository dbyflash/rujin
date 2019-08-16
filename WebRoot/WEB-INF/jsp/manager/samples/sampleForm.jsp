<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<script type="text/javascript">
$(function(){
	$("#sample_edit_form").form({
		method:'post',
		url : "${ctx }/manager/sample/save.do",
		onSubmit : function() {
				return $(this).form('validate');
		},
		success : function(msg) {
				var json = JSON.parse(msg);
				if (json.statusCode == 200) {
				       
				       $("#sample_edit_box").dialog("close");
				       $("#sample_list_box").datagrid("reload");
				    
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
</script>

<form id="sample_edit_form" >
	<table class="table">
		<tr>
			<td align="right" width="100px">样品编号：</td>
			<td>
				<input name="number" id="number" size="20" class="easyui-validatebox" data-options="required:true" value="${bean.number}"/>
				<input type="hidden" name="id" id="id" value="${bean.id}"/>
			</td>
			<td align="right" width="100px">客户：</td>
			<td>
				<input name="customername" id="customername" size="20" onclick="selectCustomer('customerid','customername')" class="easyui-validatebox" readonly="readonly" value="${bean.customername}"  />
				<input type="hidden" name="customerid" id="customerid" size="20" class="easyui-validatebox" value="${bean.customerid}"  />
			</td>
			
		</tr>
		<tr>
		     <td align="right">价格：</td>
			<td>
				<input type="text" name="price" id="price" size="20" class="easyui-validatebox" value="${bean.price}"  />
			</td>
		    <td align="right">运送方式：</td>
			<td>
				<input name="sendtype" id="sendtype" size="20" class="easyui-validatebox"  value="${bean.sendtype}" />
			</td>
			
		</tr>
		<tr>
		<td align="right">运费：</td>
			<td>
				<input type="text" name="transfee" id="transfee" size="20" class="easyui-validatebox" value="${bean.transfee}"  />
			</td>
		    <td align="right">样品归类：</td>
			<td>
				<input name="type" id="type" size="20" class="easyui-validatebox" value="${bean.type}"  />
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
