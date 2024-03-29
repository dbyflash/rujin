<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<html>
	<head>
<%@ include file="/commons/meta.jsp"%>
<script type="text/javascript">

$(function() {

	//------------------add-----------------------------
	$("#provider_add_btn").click(function(){
		$("#provider_edit_box").show().dialog({
			width:330,
			height:300,
			modal:true,
			href:'${ctx }/manager/provider/create.do',
			title:'添加供应商',
			buttons: [{
					text:'确定',
					iconCls:'icon-ok',
					handler:function(){
					    $("#provider_edit_form").submit();
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$("#provider_edit_box").dialog("close");
					}
				}]
		});
		
		
		
		
	});
	
	//------------------edit-----------------------------
	$("#provider_edit_btn").click(function(){
		var row = $("#provider_list_box").datagrid("getSelected");
		if(row){
			var url = "${ctx }/manager/provider/edit.do?id="+row.id;
			$("#provider_edit_box").show().dialog({
				width:330,
				height:300,
				modal:true,
				href:url,
				title:'编辑供应商',
				buttons: [{
						text:'确定',
						iconCls:'icon-ok',
						handler:function(){
							  $("#provider_edit_form").submit();
						}
					},{
						text:'取消',
						iconCls:'icon-cancel',
						handler:function(){
							$("#provider_edit_box").dialog("close");
						}
					}]
			});
		}else{
		
		  rightBottom("请选择行后进行编辑。");
		
		}
	});
	
	//------------------remove-----------------------------
	$("#provider_remove_btn").click(function(){
		var row = $("#provider_list_box").datagrid("getSelected");
		if(row){
			var title = "您确定要删除这条记录吗?";
			$.messager.confirm('', title, function(r){
				if (r){
					var url = "${ctx }/manager/provider/delete.do?id="+row.id;
					$.get(url,function(json){
						if(json.statusCode==200){
 							var index = $("#provider_list_box").datagrid("getRowIndex",row);
 							$("#provider_list_box").datagrid("deleteRow",index);
						}
						rightBottom(json.message);
					},'json');
				}
			});
		}
	});
	//------------------refresh-----------------------------
	$("#provider_refresh_btn").click(function(){
		 $("#provider_list_box").datagrid("reload");
	});

	$("#doSearch").click(function(){
	   $("#provider_list_box").datagrid({
		  url : "${ctx }/manager/provider/list.do?s_name="+encodeURI($("#s_name").val())
	   });
	
	});
	
	
	
	
	
	
	
	
	
});


 
</script>
</head>
<body class="easyui-layout" >
  <div region="north" border="false" style="height: 70px;background-color:#f4f4f4;">
   <div id="tb" style="padding: 2px; height: auto">
		<a href="javascript:void(0)" id="provider_add_btn" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
		<a href="javascript:void(0)" id="provider_edit_btn" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">编辑</a>
		<a href="javascript:void(0)" id="provider_remove_btn" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>
		<a href="javascript:void(0)" id="provider_refresh_btn" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>
	</div>
		<table border="0" style="margin-top: 0" class="table">
			<tr style="width: 100%">
		        <th>名称：</th>
		        <td><input id="s_name"  style="width: 100px"></html:text> &nbsp;&nbsp;</td>
		        <th> <a data-options="iconCls:'icon-search'" class="easyui-linkbutton" id="doSearch"  style="margin-left:10px">查询</a>
			</tr>
		</table>
  </div>
 
<div region="center" border="false" >
	  <table id="provider_list_box"  class="easyui-datagrid"  
	  data-options="striped:true, rownumbers:true,border:false,fit:true,pagination:true,singleSelect:true,pageSize:25,pageList:[25,50,100],
	  url:'${ctx }/manager/provider/list.do'" >
		                  <thead>
			               <tr>
				             <th data-options="field:'id',hidden:true">ID</th>
				             <th data-options="field:'name',width:120,halign:'center',align:'center'">供应商名称</th>
				             <th data-options="field:'addr',width:150,halign:'center',align:'center'">地址</th>
				             <th data-options="field:'tel',width:100,halign:'center',align:'center'">电话</th>
				             <th data-options="field:'mark',width:200,halign:'center',align:'center'">备注</th>
			              </tr>
		                </thead>
	  </table>
</div>
<div style="display: none;padding: 5px" id="provider_edit_box" />
</body>

</html>
