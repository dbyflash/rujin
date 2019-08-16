<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<script type="text/javascript">
$(function(){
	$("#changeplace_edit_form").form({
		method:'post',
		url : "${ctx }/manager/changeplace/save.do",
		onSubmit : function() {
				return $(this).form('validate');
		},
		success : function(msg) {
				var json = JSON.parse(msg);
				if (json.statusCode == 200) {
				       
				       $("#changeplace_edit_box").dialog("close");
				       $("#changeplace_list_box").datagrid("reload");
				    
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

<form id="changeplace_edit_form" >
	<table class="table">
		<tr>
			<td align="right">坯布流转编号：</td>
			<td>
				<input name="number" id="number" size="25" class="easyui-validatebox" value="${bean.number}" data-options="required:true" />
				<input type="hidden" name="id" id="id" value="${bean.id}"/>
			</td>
			<td align="right">受托工厂：</td>
			<td>
				<input type="text" name="factory" id="factory" size="25" class="easyui-validatebox" value="${bean.factory}"  />
			</td>
		</tr>
		<tr>
			<td align="right">物料名称：</td>
			<td>
				<input name="materialname" id="materialname" size="25" onclick="selectMaterial('materialid','materialname')"   value="${bean.materialname}" class="easyui-validatebox" readonly="readonly" />
				<input type="hidden" name="materialid" id="materialid" size="25" class="easyui-validatebox" value="${bean.materialid}"  />
			</td>
			<td align="right">约定数量：</td>
			<td>
				<input name="deal" id="deal" size="25" class="easyui-validatebox" value="${bean.deal}"  />
			</td>
		</tr>
		<tr>
		 <td align="right">伸长率：</td>
			<td>
				<input name="elongation" id="elongation" size="25" class="easyui-validatebox" value="${bean.elongation}"  />
			</td>
			<td align="right">实际数量：</td>
			<td>
				<input type="text" name="real" id="real" size="25" class="easyui-validatebox" value="${bean.real}"  data-options="required:true"/>
			</td>
			
		</tr>
		<tr>
		 <td align="right">采购合同编号：</td>
			<td colspan="3">
				<input name="cnumber" id="cnumber" size="25" class="easyui-validatebox" value="${bean.cnumber}" validtype="remote['${ctx }/manager/buycontract/checkContract.do','cnumber']" invalidMessage="采购合同不存在" />
			</td>
		</tr>
	</table>
	<%@ include file="/commons/forminclude.jsp"%>
</form>
