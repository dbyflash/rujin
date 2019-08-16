<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<script type="text/javascript">
$(function(){
	$("#send_edit_form").form({
		method:'post',
		url : "${ctx }/manager/send/save.do",
		onSubmit : function() {
				return $(this).form('validate');
		},
		success : function(msg) {
				var json = JSON.parse(msg);
				if (json.statusCode == 200) {
				       
				       $("#send_edit_box").dialog("close");
				       $("#send_list_box").datagrid("reload");
				    
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
 	}
</script>

<form id="send_edit_form" >
	<table class="table">
		<tr>
			<td align="right" width="100px">发料单编号：</td>
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
		     <td align="right">物料名称：</td>
			<td>
				<input name="materialname" id="materialname" onclick="selectMaterial('materialid','materialname')"   value="${bean.materialname}" class="easyui-validatebox" readonly="readonly" />
				<input type="hidden" name="materialid" id="materialid" size="20" class="easyui-validatebox" value="${bean.materialid}"  />
			</td>
		    <td align="right">领用数量：</td>
			<td>
				<input name="take" id="take" size="20" class="easyui-validatebox"  value="${bean.take}" />
			</td>
			
		</tr>
		<tr>
		<td align="right">开剪数量：</td>
			<td>
				<input type="text" name="mount" id="mount" size="20" class="easyui-validatebox" value="${bean.mount}"  />
			</td>
		    <td align="right">借用：</td>
			<td>
				<input name="borrow" id="borrow" size="20" class="easyui-validatebox" value="${bean.borrow}"  />
			</td>
		</tr>
		<tr>
			<td align="right">收料单编号：</td>
			<td>
				<input type="text" name="rnumber" id="rnumber" size="20"  value="${bean.rnumber}" class="easyui-validatebox"  validtype="remote['${ctx }/manager/receipt/checkReceipt.do','rnumber']" invalidMessage="收料单不存在"/>
			</td>
			<td align="right">物料剩余：</td>
			<td>
				<input type="text" name="left" id="left" size="20"  value="${bean.left}" />
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
