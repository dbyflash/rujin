<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<script type="text/javascript">
$(function(){
	$("#storage_edit_form").form({
		method:'post',
		url : "${ctx }/manager/storage/save.do",
		onSubmit : function() {
				return $(this).form('validate');
		},
		success : function(msg) {
				var json = JSON.parse(msg);
				if (json.statusCode == 200) {
				       
				       $("#storage_edit_box").dialog("close");
				       $("#storage_list_box").datagrid("reload");
				    
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

<form id="storage_edit_form" >
	<table class="table">
		<tr>
			<td align="right" width="100px">入库单编号：</td>
			<td>
				<input name="number" id="number" size="20" class="easyui-validatebox" data-options="required:true" value="${bean.number}"/>
				<input type="hidden" name="id" id="id" value="${bean.id}"/>
			</td>
			<td align="right" width="100px">加工厂：</td>
			<td>
				<input name="factory" id="factory" size="20"   value="${bean.factory}" />
			</td>
			
		</tr>
		<tr>
		     <td align="right">产品名称：</td>
			<td>
				<input name="productname" id="productname" size="20" onclick="selectProduct('productid','productname')" class="easyui-validatebox" readonly="readonly" value="${bean.productname}"  />
				<input type="hidden" name="productid" id="productid" size="20" class="easyui-validatebox" value="${bean.productid}"  />
			</td>
		    <td align="right">计量单位：</td>
			<td>
				<input name="style" id="style" size="20" class="easyui-validatebox"  value="${bean.style}" />
			</td>
			
		</tr>
		<tr>
		 <td align="right">数量：</td>
			<td>
				<input name="mount" id="mount" size="20"  value="${bean.mount}"  />
			</td>
			<td align="right">日期：</td>
			<td>
				<input name="dt" id="dt" size="20" class="easyui-my97" style=" height: 17px;" readonly="readonly" editable="false" data-options="skin:'twoer',dateFmt:'yyyy-MM-dd'" value="${bean.dt}"  />
			</td>
		</tr>
	</table>
	<%@ include file="/commons/forminclude.jsp"%>
</form>
