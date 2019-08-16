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
			<td align="right" width="100px" height="20px">出库单编号：</td>
			<td width="150px">${bean.number}</td>
			<td align="right" width="100px">货号：</td>
			<td width="150px">
				${bean.productnumber}
			</td>
			
		</tr>
		<tr>
		     <td align="right" height="20px">产品名称：</td>
			<td>${bean.productname}</td>
		    <td align="right">计量单位：</td>
			<td>
				${bean.style}
			</td>
			
		</tr>
		<tr>
		<td align="right" height="20px">英寸：</td>
			<td>
				${bean.inch}
			</td>
		    <td align="right">数量：</td>
			<td>
				${bean.mount}
			</td>
		</tr>
		<tr>
		 <td align="right" height="20px">箱数：</td>
			<td>
				${bean.boxmount}
			</td>
			<td align="right">箱入(条)：</td>
			<td>
				${bean.boxin}
			</td>
		</tr>
		<tr>
		<td align="right" height="20px">净重：</td>
			<td>
				${bean.dt}
			</td>
		 <td align="right">毛重：</td>
			<td>
              ${bean.gw}
           </td>
		</tr>
		<tr>
		<td align="right" height="20px">纸箱尺寸：</td>
			<td>
				${bean.boxstyle}
			</td>
		 <td align="right">箱号：</td>
			<td>
              ${bean.boxnumber}
           </td>
		</tr>
		<tr>
		<td align="right" height="20px">借用：</td>
			<td>
				${bean.borrow}
			</td>
		 <td align="right">入库单编号：</td>
			<td>
              ${bean.snumber}
           </td>
		</tr>
		<tr>
		<td align="right" height="20px">产品剩余：</td>
			<td>
				${bean.left}
			</td>
		    <td align="right">日期：</td>
			<td >
				${bean.dt}
			</td>
		</tr>
	</table>
	<%@ include file="/commons/forminclude.jsp"%>
</form>
