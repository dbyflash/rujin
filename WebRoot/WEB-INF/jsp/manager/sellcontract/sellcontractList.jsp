<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<html>
	<head>
<%@ include file="/commons/meta.jsp"%>
<script type="text/javascript">

$(function() {

//产品combobox
    $("#s_name").combobox({
    	  width:'90',
          required:false,
		  url:context+'/manager/product/getlist.do',
		  valueField:'id',
		  textField:'name',
		  mode:'remote',
		  editable:true,
		  onLoadSuccess:function(){
		 	
		  	
          },
          onSelect:function(){
   			
          }
    });
	//------------------add-----------------------------
	$("#sellcontract_add_btn").click(function(){
		$("#sellcontract_edit_box").show().dialog({
			width:580,
			height:300,
			modal:true,
			href:'${ctx }/manager/sellcontract/create.do',
			title:'添加合同',
			buttons: [{
					text:'确定',
					iconCls:'icon-ok',
					handler:function(){
					    $("#sellcontract_edit_form").submit();
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$("#sellcontract_edit_box").dialog("close");
					}
				}]
		});
		
		
		
		
	});
	
	//------------------edit-----------------------------
	$("#sellcontract_edit_btn").click(function(){
		var row = $("#sellcontract_list_box").datagrid("getSelected");
		if(row){
			var url = "${ctx }/manager/sellcontract/edit.do?id="+row.id;
			$("#sellcontract_edit_box").show().dialog({
				width:580,
				height:300,
				modal:true,
				href:url,
				title:'编辑合同',
				buttons: [{
						text:'确定',
						iconCls:'icon-ok',
						handler:function(){
							  $("#sellcontract_edit_form").submit();
						}
					},{
						text:'取消',
						iconCls:'icon-cancel',
						handler:function(){
							$("#sellcontract_edit_box").dialog("close");
						}
					}]
			});
		}else{
		
		  rightBottom("请选择行后进行编辑。");
		
		}
	});
	
	//------------------remove-----------------------------
	$("#sellcontract_remove_btn").click(function(){
		var row = $("#sellcontract_list_box").datagrid("getSelected");
		if(row){
			var title = "您确定要删除这条记录吗?";
			$.messager.confirm('', title, function(r){
				if (r){
					var url = "${ctx }/manager/sellcontract/delete.do?id="+row.id;
					$.get(url,function(json){
						if(json.statusCode==200){
 							var index = $("#sellcontract_list_box").datagrid("getRowIndex",row);
 							$("#sellcontract_list_box").datagrid("deleteRow",index);
						}
						rightBottom(json.message);
					},'json');
				}
			});
		}
	});
	//------------------refresh-----------------------------
	$("#sellcontract_refresh_btn").click(function(){
		 $("#sellcontract_list_box").datagrid("reload");
	});

	$("#doSearch").click(function(){
	   $("#sellcontract_list_box").datagrid({
		  url : "${ctx }/manager/sellcontract/list.do?productid="+$("#s_name").combobox("getValue")+"&s_number="+encodeURI($("#s_number").val())+"&s_begin="+$("#s_begin").val()+"&s_end="+$("#s_end").val()
	   });
	
	});
	
	
	
	
	
	$("#sellcontract_pwdreset_btn").click(function(){
	
		var row = $("#sellcontract_list_box").datagrid("getSelected");
		if(row){
		$("#sellcontract_edit_box").show().dialog({
			width:310,
			height:230,
			modal:true,
			href:'${ctx }/manager/sellcontract/passwordReset.do?type=toreset&id='+row.id,
			title:'密码重置',
			buttons: [{
					text:'确定',
					iconCls:'icon-ok',
					handler:function(){
						$("#password_edit_form").submit();
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$("#sellcontract_edit_box").dialog("close");
					}
				}]
		});
		}else{
		 rightBottom("请选择行后进行操作。");
		}
	});
	
	
	
});
function formatterCZ(value,row,index){
	return "<a href=\"javascript:void(0)\" onclick=\"view('"+row.number+"')\">查看</a>";
}
function view(number){
			var url = "${ctx }/manager/sellcontract/checkPay.do?number="+number;
			$("#sellcontract_edit_box").show().dialog({
				width:350,
				height:280,
				modal:true,
				href:url,
				title:'货款回收情况',
				buttons: [{
						text:'关闭',
						iconCls:'icon-cancel',
						handler:function(){
							$("#sellcontract_edit_box").dialog("close");
						}
					}]
			});

}

 
</script>
</head>
<body class="easyui-layout" >
  <div region="north" border="false" style="height: 70px;background-color:#f4f4f4;">
   <div id="tb" style="padding: 2px; height: auto">
		<a href="javascript:void(0)" id="sellcontract_add_btn" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
		<a href="javascript:void(0)" id="sellcontract_edit_btn" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">编辑</a>
		<a href="javascript:void(0)" id="sellcontract_remove_btn" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>
		<a href="javascript:void(0)" id="sellcontract_refresh_btn" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>
	</div>
		<table border="0" style="margin-top: 0" class="table">
			<tr style="width: 100%">
		        <th>合同编号：</th>
		        <td><input id="s_number"  ></html:text> &nbsp;&nbsp;</td>
		        <th>产品名称：</th>
		        <td><input id="s_name"  ></html:text> &nbsp;&nbsp;</td>
		        <th>签订日期：</th>
		        <td>
		          <input name="s_begin" id="s_begin"  class="easyui-my97" style=" height: 17px;" readonly="readonly" editable="false" data-options="skin:'twoer',dateFmt:'yyyy-MM-dd'"  />
		          -
		          <input name="s_end" id="s_end"  class="easyui-my97" style=" height: 17px;" readonly="readonly" editable="false" data-options="skin:'twoer',dateFmt:'yyyy-MM-dd'"  />
		        </td>
		        <th> 
		          <a data-options="iconCls:'icon-search'" class="easyui-linkbutton" id="doSearch"  style="margin-left:10px">查询</a>
		        </th>
			</tr>
		</table>
  </div>
 
<div region="center" border="false" >
	  <table id="sellcontract_list_box"  class="easyui-datagrid"  
	  data-options="striped:true, rownumbers:true,border:false,fit:true,pagination:true,singleSelect:true,pageSize:25,pageList:[25,50,100],
	  url:'${ctx }/manager/sellcontract/list.do'" >
		                  <thead>
			               <tr>
				             <th data-options="field:'id',hidden:true">ID</th>
				             <th data-options="field:'number',width:120,halign:'center',align:'center'">合同编号</th>
				             <th data-options="field:'productname',width:100,halign:'center',align:'center'">产品名称</th>
				             <th data-options="field:'price',width:100,halign:'center',align:'center'">单价</th>
				             <th data-options="field:'mount',width:100,halign:'center',align:'center'">数量</th>
				             <th data-options="field:'money',width:100,halign:'center',align:'center'">金额</th>
				             <th data-options="field:'signdate',width:100,halign:'center',align:'center'">签订日期</th>
				             <th data-options="field:'sellperson',width:100,halign:'center',align:'center'">销售人员</th>
				             <th data-options="field:'customername',width:100,halign:'center',align:'center'">客户</th>
				              <th data-options="field:'dt',width:100,halign:'center',align:'center'">交货日期</th>
				             <th data-options="field:'cnumber',width:100,halign:'center',align:'center'">翻单</th>
				             <th data-options="field:'aa',width:60,halign:'center',align:'center',formatter:formatterCZ">操作</th>
			              </tr>
		                </thead>
	  </table>
</div>
<div style="display: none;padding: 5px" id="sellcontract_edit_box" />
</body>

</html>
