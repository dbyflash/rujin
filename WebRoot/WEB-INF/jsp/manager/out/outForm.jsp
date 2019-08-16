<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<script type="text/javascript">
$(function(){
	$("#out_edit_form").form({
		method:'post',
		url : "${ctx }/manager/out/save.do",
		onSubmit : function() {
				return $(this).form('validate');
		},
		success : function(msg) {
				var json = JSON.parse(msg);
				if (json.statusCode == 200) {
				       
				       $("#out_edit_box").dialog("close");
				       $("#out_list_box").datagrid("reload");
				    
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

<form id="out_edit_form" >
	<table class="table">
		<tr>
			<td align="right" width="100px">出库单编号：</td>
			<td>
				<input name="number" id="number" size="20" class="easyui-validatebox" data-options="required:true" value="${bean.number}"/>
				<input type="hidden" name="id" id="id" value="${bean.id}"/>
			</td>
			<td align="right" width="100px">货号：</td>
			<td>
				<input name="productnumber" id="productnumber" size="20"   value="${bean.productnumber}" />
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
		<td align="right">英寸：</td>
			<td>
				<input type="text" name="inch" id="inch" size="20" class="easyui-validatebox" value="${bean.inch}"  />
			</td>
		    <td align="right">数量：</td>
			<td>
				<input name="mount" id="mount" size="20" class="easyui-validatebox" value="${bean.mount}"  />
			</td>
		</tr>
		<tr>
		 <td align="right">箱数：</td>
			<td>
				<input name="boxmount" id="boxmount" size="20"  value="${bean.boxmount}"  />
			</td>
			<td align="right">箱入(条)：</td>
			<td>
				<input type="text" name="boxin" id="boxin" size="20"  value="${bean.boxin}" />
			</td>
		</tr>
		<tr>
		<td align="right">净重：</td>
			<td>
				<input name="netweight" id="netweight" size="20"  value="${bean.dt}"  />
			</td>
		 <td align="right">毛重：</td>
			<td>
              <input name="gw" id="gw" size="20"  value="${bean.gw}"  />
           </td>
		</tr>
		<tr>
		<td align="right">纸箱尺寸：</td>
			<td>
				<input name="boxstyle" id="boxstyle" size="20"  value="${bean.boxstyle}"  />
			</td>
		 <td align="right">箱号：</td>
			<td>
              <input name="boxnumber" id="boxnumber" size="20"  value="${bean.boxnumber}"  />
           </td>
		</tr>
		<tr>
		<td align="right">借用：</td>
			<td>
				<input name="borrow" id="borrow" size="20"  value="${bean.borrow}"  />
			</td>
		 <td align="right">入库单编号：</td>
			<td>
              <input name="snumber" id="snumber" size="20"  value="${bean.snumber}"  class="easyui-validatebox"  validtype="remote['${ctx }/manager/storage/checkStorage.do','snumber']" invalidMessage="入库单不存在"/>
           </td>
		</tr>
		<tr>
		<td align="right">产品剩余：</td>
			<td>
				<input name="left" id="left" size="20"  value="${bean.left}"  />
			</td>
		 <td align="right">日期：</td>
			<td >
				<input name="dt" id="dt" size="20" class="easyui-my97" style=" height: 17px;" readonly="readonly" editable="false" data-options="skin:'twoer',dateFmt:'yyyy-MM-dd'" value="${bean.dt}"  />
			</td>
		</tr>
	</table>
	<%@ include file="/commons/forminclude.jsp"%>
</form>
