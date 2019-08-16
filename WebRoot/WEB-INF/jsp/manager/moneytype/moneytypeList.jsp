<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<html>
	<head>
<%@ include file="/commons/meta.jsp"%>
<script type="text/javascript">

$(function() {

	//------------------add-----------------------------
	$("#moneytype_add_btn").click(function(){
		$("#moneytype_edit_box").show().dialog({
			width:300,
			height:180,
			modal:true,
			href:'${ctx }/manager/moneytype/create.do',
			title:'添加外币',
			buttons: [{
					text:'确定',
					iconCls:'icon-ok',
					handler:function(){
					    $("#moneytype_edit_form").submit();
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$("#moneytype_edit_box").dialog("close");
					}
				}]
		});
		
		
		
		
	});
	
	//------------------edit-----------------------------
	$("#moneytype_edit_btn").click(function(){
		var row = $("#moneytype_list_box").datagrid("getSelected");
		if(row){
			var url = "${ctx }/manager/moneytype/edit.do?id="+row.id;
			$("#moneytype_edit_box").show().dialog({
				width:300,
				height:180,
				modal:true,
				href:url,
				title:'编辑外币',
				buttons: [{
						text:'确定',
						iconCls:'icon-ok',
						handler:function(){
							  $("#moneytype_edit_form").submit();
						}
					},{
						text:'取消',
						iconCls:'icon-cancel',
						handler:function(){
							$("#moneytype_edit_box").dialog("close");
						}
					}]
			});
		}else{
		
		  rightBottom("请选择行后进行编辑。");
		
		}
	});
	
	//------------------remove-----------------------------
	$("#moneytype_remove_btn").click(function(){
		var row = $("#moneytype_list_box").datagrid("getSelected");
		if(row){
			var title = "您确定要删除这条记录吗?";
			$.messager.confirm('', title, function(r){
				if (r){
					var url = "${ctx }/manager/moneytype/delete.do?id="+row.id;
					$.get(url,function(json){
						if(json.statusCode==200){
 							var index = $("#moneytype_list_box").datagrid("getRowIndex",row);
 							$("#moneytype_list_box").datagrid("deleteRow",index);
						}
						rightBottom(json.message);
					},'json');
				}
			});
		}
	});
	//------------------refresh-----------------------------
	$("#moneytype_refresh_btn").click(function(){
		 $("#moneytype_list_box").datagrid("reload");
	});

	$("#doSearch").click(function(){
	   $("#moneytype_list_box").datagrid({
		  url : "${ctx }/manager/moneytype/list.do?s_name="+encodeURI($("#s_name").val())
	   });
	
	});
	
	
	
	
	
	
	
	
	
});


 
</script>
</head>
<body class="easyui-layout" >
  <div region="north" border="false" style="height: 70px;background-color:#f4f4f4;">
   <div id="tb" style="padding: 2px; height: auto">
		<a href="javascript:void(0)" id="moneytype_add_btn" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
		<a href="javascript:void(0)" id="moneytype_edit_btn" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">编辑</a>
		<a href="javascript:void(0)" id="moneytype_remove_btn" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>
		<a href="javascript:void(0)" id="moneytype_refresh_btn" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>
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
	  <table id="moneytype_list_box"  class="easyui-datagrid"  
	  data-options="striped:true, rownumbers:true,border:false,fit:true,pagination:true,singleSelect:true,pageSize:25,pageList:[25,50,100],
	  url:'${ctx }/manager/moneytype/list.do'" >
		                  <thead>
			               <tr>
				             <th data-options="field:'id',hidden:true">ID</th>
				             <th data-options="field:'code',width:120,halign:'center',align:'center'">外币代码</th>
				             <th data-options="field:'name',width:150,halign:'center',align:'center'">外币名称</th>
			              </tr>
		                </thead>
	  </table>
</div>
<div style="display: none;padding: 5px" id="moneytype_edit_box" />
</body>

</html>
