<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<script type="text/javascript">
$(function(){
	$("#receipt_edit_form").form({
		method:'post',
		url : "${ctx }/manager/receipt/save.do",
		onSubmit : function() {
				return $(this).form('validate');
		},
		success : function(msg) {
				var json = JSON.parse(msg);
				if (json.statusCode == 200) {
				       
				       $("#receipt_edit_box").dialog("close");
				       $("#receipt_list_box").datagrid("reload");
				    
				} 
				rightBottom(json.message);
		}
	});
	

});
 function selectMaterial(id,name){
 	$("<div id='selectMaterial' style='padding: 0px'></div>").show().dialog({
			width:500,
			height:400,
			modal:true,
			href:'${ctx }/manager/buycontract/selectMaterial.do',
			title:'选择物料',
			buttons: [{
					text:'确定',
					iconCls:'icon-ok',
					handler:function(){
						savesearch_material(id,name);//保存
						$("#selectMaterial").dialog("destroy");
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$("#selectMaterial").dialog("destroy");
					}
				}],
		    onClose : function() {
               $(this).dialog('destroy');
            } 
				
		});
 	};
 	function selectProvider(id,name){
 	$("<div id='selectProvider' style='padding: 0px'></div>").show().dialog({
			width:500,
			height:400,
			modal:true,
			href:'${ctx }/manager/buycontract/selectProvider.do',
			title:'选择供应商',
			buttons: [{
					text:'确定',
					iconCls:'icon-ok',
					handler:function(){
						savesearch_provider(id,name);//保存
						$("#selectProvider").dialog("destroy");
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$("#selectProvider").dialog("destroy");
					}
				}],
		    onClose : function() {
               $(this).dialog('destroy');
            } 
				
		});
 	}
</script>

<form id="receipt_edit_form" >
	<table class="table">
		<tr>
			<td align="right" width="100px">收料单编号：</td>
			<td>
				<input name="number" id="number" size="20" class="easyui-validatebox" data-options="required:true" value="${bean.number}"/>
				<input type="hidden" name="id" id="id" value="${bean.id}"/>
			</td>
			<td align="right" width="100px">供应商：</td>
			<td>
				<input name="providername" id="providername" onclick="selectProvider('providerid','providername')"   value="${bean.providername}" class="easyui-validatebox" readonly="readonly" />
				<input type="hidden" name="providerid" id="providerid" size="20" class="easyui-validatebox" value="${bean.providerid}"  />
			</td>
			
		</tr>
		<tr>
		     <td align="right">物料名称：</td>
			<td>
				<input name="materialname" id="materialname" onclick="selectMaterial('materialid','materialname')"   value="${bean.materialname}" class="easyui-validatebox" readonly="readonly" />
				<input type="hidden" name="materialid" id="materialid" size="20" class="easyui-validatebox" value="${bean.materialid}"  />
			</td>
		    <td align="right">计量单位：</td>
			<td>
				<input name="style" id="style" size="20" class="easyui-validatebox"  value="${bean.style}" />
			</td>
			
		</tr>
		<tr>
		<td align="right">单价：</td>
			<td>
				<input type="text" name="price" id="price" size="20" class="easyui-validatebox" value="${bean.price}"  />
			</td>
		    <td align="right">数量(米)：</td>
			<td>
				<input name="meters" id="meters" size="20" class="easyui-validatebox" value="${bean.meters}"  />
			</td>
		</tr>
		<tr>
		 <td align="right">数量(件)：</td>
			<td>
				<input name="mount" id="mount" size="20"  value="${bean.mount}"  />
			</td>
			<td align="right">金额：</td>
			<td>
				<input type="text" name="money" id="money" size="20"  value="${bean.money}"  />
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
