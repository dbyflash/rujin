<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<html>
	<head>
<%@ include file="/commons/meta.jsp"%>
<script type="text/javascript">

$(function() {

    //物料combobox
    $("#s_name").combobox({
    	  width:'90',
          required:false,
		  url:context+'/manager/material/getlist.do',
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
	$("#changeplace_add_btn").click(function(){
		$("#changeplace_edit_box").show().dialog({
			width:600,
			height:270,
			modal:true,
			href:'${ctx }/manager/changeplace/create.do',
			title:'添加坯布流转',
			buttons: [{
					text:'确定',
					iconCls:'icon-ok',
					handler:function(){
					    $("#changeplace_edit_form").submit();
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$("#changeplace_edit_box").dialog("close");
					}
				}]
		});
		
		
		
		
	});
	
	//------------------edit-----------------------------
	$("#changeplace_edit_btn").click(function(){
		var row = $("#changeplace_list_box").datagrid("getSelected");
		if(row){
			var url = "${ctx }/manager/changeplace/edit.do?id="+row.id;
			$("#changeplace_edit_box").show().dialog({
				width:600,
				height:270,
				modal:true,
				href:url,
				title:'编辑坯布流转',
				buttons: [{
						text:'确定',
						iconCls:'icon-ok',
						handler:function(){
							  $("#changeplace_edit_form").submit();
						}
					},{
						text:'取消',
						iconCls:'icon-cancel',
						handler:function(){
							$("#changeplace_edit_box").dialog("close");
						}
					}]
			});
		}else{
		
		  rightBottom("请选择行后进行编辑。");
		
		}
	});
	
	//------------------remove-----------------------------
	$("#changeplace_remove_btn").click(function(){
		var row = $("#changeplace_list_box").datagrid("getSelected");
		if(row){
			var title = "您确定要删除这条记录吗?";
			$.messager.confirm('', title, function(r){
				if (r){
					var url = "${ctx }/manager/changeplace/delete.do?id="+row.id;
					$.get(url,function(json){
						if(json.statusCode==200){
 							var index = $("#changeplace_list_box").datagrid("getRowIndex",row);
 							$("#changeplace_list_box").datagrid("deleteRow",index);
						}
						rightBottom(json.message);
					},'json');
				}
			});
		}
	});
	//------------------refresh-----------------------------
	$("#changeplace_refresh_btn").click(function(){
		 $("#changeplace_list_box").datagrid("reload");
	});

	$("#doSearch").click(function(){
	   $("#changeplace_list_box").datagrid({
		  url : "${ctx }/manager/changeplace/list.do?materialid="+$("#s_name").combobox("getValue")+"&s_number="+encodeURI($("#s_number").val())+"&s_factory="+encodeURI($("#s_factory").val())
	   });
	
	});
	
	
	
	
	
	
});
function formatterPay(value,row,index){
	if(value==null){
	  return "未付款";
	}else{
	  return value;
	}
}

 
</script>
</head>
<body class="easyui-layout" >
  <div region="north" border="false" style="height: 70px;background-color:#f4f4f4;">
   <div id="tb" style="padding: 2px; height: auto">
		<a href="javascript:void(0)" id="changeplace_add_btn" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
		<a href="javascript:void(0)" id="changeplace_edit_btn" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">编辑</a>
		<a href="javascript:void(0)" id="changeplace_remove_btn" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>
		<a href="javascript:void(0)" id="changeplace_refresh_btn" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>
	</div>
		<table border="0" style="margin-top: 0" class="table">
			<tr style="width: 100%">
		        <th>坯布流转编号：</th>
		        <td><input id="s_number"  style="width: 100px"></html:text> &nbsp;&nbsp;</td>
		        <th>物料名称：</th>
		        <td><input id="s_name"  style="width: 100px"></html:text> &nbsp;&nbsp;</td>
		        <th>受托工厂：</th>
		        <td><input id="s_factory"  style="width: 100px"></html:text> &nbsp;&nbsp;</td>
		        
		        <th> 
		          <a data-options="iconCls:'icon-search'" class="easyui-linkbutton" id="doSearch"  style="margin-left:10px">查询</a>
		        </th>
			</tr>
		</table>
  </div>
 
<div region="center" border="false" >
	  <table id="changeplace_list_box"  class="easyui-datagrid"  
	  data-options="striped:true, rownumbers:true,border:false,fit:true,pagination:true,singleSelect:true,pageSize:25,pageList:[25,50,100],
	  url:'${ctx }/manager/changeplace/list.do'" >
		                  <thead>
			               <tr>
				             <th data-options="field:'id',hidden:true">ID</th>
				             <th data-options="field:'number',width:100,halign:'center',align:'center'">坯布流转编号</th>
				             <th data-options="field:'factory',width:100,halign:'center',align:'center'">受托工厂</th>
				             <th data-options="field:'materialname',width:100,halign:'center',align:'center'">物料名称</th>
				             <th data-options="field:'deal',width:100,halign:'center',align:'center'">约定数量</th>
				             <th data-options="field:'elongation',width:100,halign:'center',align:'center'">伸长率</th>
				             <th data-options="field:'real',width:100,halign:'center',align:'center'">实际数量</th>
				             <th data-options="field:'cnumber',width:120,halign:'center',align:'center'">采购合同编号</th>
				             <th data-options="field:'paymoney',width:120,halign:'center',align:'center',formatter:formatterPay">付款情况</th>
			              </tr>
		                </thead>
	  </table>
</div>
<div style="display: none;padding: 5px" id="changeplace_edit_box" />
</body>

</html>
