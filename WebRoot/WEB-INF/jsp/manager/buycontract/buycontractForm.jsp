<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<script type="text/javascript">
$(function(){
	$("#buycontract_edit_form").form({
		method:'post',
		url : "${ctx }/manager/buycontract/save.do",
		onSubmit : function() {
				return $(this).form('validate');
		},
		success : function(msg) {
				var json = JSON.parse(msg);
				if (json.statusCode == 200) {
				       
				       $("#buycontract_edit_box").dialog("close");
				       $("#buycontract_list_box").datagrid("reload");
				    
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

<form id="buycontract_edit_form" >
	<table class="table">
		<tr>
			<td align="right" >合同编号：</td>
			<td>
				<input name="number" id="number" size="20" class="easyui-validatebox" value="${bean.number}" data-options="required:true" />
				<input type="hidden" name="id" id="id" value="${bean.id}"/>
			</td>
			<td align="right">类型：</td>
			<td>
				<select name="type" id="type" >
				 <option value=""></option>
				 <option value="0" <c:if test="${bean.type==0}">selected="selected"</c:if>>物料合同</option>
				 <option value="1" <c:if test="${bean.type==1}">selected="selected"</c:if>>印染合同</option>
				 <option value="2" <c:if test="${bean.type==2}">selected="selected"</c:if>>加工合同</option>
				 <option value="3" <c:if test="${bean.type==3}">selected="selected"</c:if>>运输合同</option>
				</select>
			</td>
		</tr>
		<tr>
			<td align="right">坯布流转编号：</td>
			<td>
				<input type="text" name="changeplacenumber" id="changeplacenumber" size="20" class="easyui-validatebox" value="${bean.changeplacenumber}" validtype="remote['${ctx }/manager/changeplace/checkReplace.do','changeplacenumber']" invalidMessage="坯布流转不存在" />
			</td>
			<td align="right">物料名称：</td>
			<td>
				<input name="materialname" id="materialname" onclick="selectMaterial('materialid','materialname')"   value="${bean.materialname}" class="easyui-validatebox" readonly="readonly" />
				<input type="hidden" name="materialid" id="materialid" size="20" class="easyui-validatebox" value="${bean.materialid}"  />
			</td>
		</tr>
		<tr>
		 <td align="right">单价：</td>
			<td>
				<input name="price" id="price" size="20" class="easyui-validatebox" value="${bean.price}"  />
			<td align="right">数量：</td>
			<td>
				<input type="text" name="mount" id="mount" size="20" class="easyui-validatebox" value="${bean.mount}" data-options="required:true"/>
			</td>
		</tr>
		<tr>
		 <td align="right">金额：</td>
			<td>
				<input name="money" id="money" size="20" class="easyui-validatebox" value="${bean.money}"  />
			</td>
			<td align="right">供应商：</td>
			<td>
				<input name="providername" id="providername" onclick="selectProvider('providerid','providername')"   value="${bean.providername}" class="easyui-validatebox" readonly="readonly" />
				<input type="hidden" name="providerid" id="providerid" size="20" class="easyui-validatebox" value="${bean.providerid}"  />
			</td>
			
		</tr>
		<tr>
		 <td align="right">供应人员：</td>
			<td>
				<input name="providperson" id="providperson" size="20" class="easyui-validatebox" value="${bean.providperson}"  />
			</td>
			<td align="right">签订日期：</td>
			<td>
				<input type="text" name="dt" id="dt" size="20" class="easyui-my97" style=" height: 17px;" readonly="readonly" editable="false" data-options="skin:'twoer',dateFmt:'yyyy-MM-dd'" value="${bean.dt}"  />
			</td>
		</tr>
	</table>
	<%@ include file="/commons/forminclude.jsp"%>
</form>
