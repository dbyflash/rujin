<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<html>
	<head>
<%@ include file="/commons/meta.jsp"%>
<script type="text/javascript">
$(function() {

	//------------------add-----------------------------
	$("#role_add_btn").click(function(){
		$("#role_edit_box").show().dialog({
			width:350,
			height:250, 
			modal:true,
			href:'${ctx }/system/role/edit.do',
			title:'添加角色',
			buttons: [{
					text:'确定',
					iconCls:'icon-ok',
					handler:function(){
						$("#role_edit_form").submit();
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$("#role_edit_box").dialog("close");
					}
				}]
		});
	});
	
	//------------------edit-----------------------------
	$("#role_edit_btn").click(function(){
		var row = $("#role_list_box").datagrid("getSelected");
		if(row){
			var url = "${ctx }/system/role/edit.do?id="+row.id;
			$("#role_edit_box").show().dialog({
				width:350,
				height:250,
				modal:true,
				href:url,
				title:'编辑角色',
				buttons: [{
						text:'确定',
						iconCls:'icon-ok',
						handler:function(){
							$("#role_edit_form").submit();
						}
					},{
						text:'取消',
						iconCls:'icon-cancel',
						handler:function(){
							$("#role_edit_box").dialog("close");
						}
					}]
			});
		}else{
			rightBottom("请选择后再操作");
		}
	});
	
	//------------------remove-----------------------------
	$("#role_remove_btn").click(function(){
		var row = $("#role_list_box").datagrid("getSelected");
		if(row){
			var title = "您确定要删除这条记录吗?";
			$.messager.confirm('', title, function(r){
				if (r){
					var url = "${ctx }/system/role/delete.do?id="+row.id;
					$.get(url,function(json){
						if(json.statusCode==200){
 							var index = $("#role_list_box").datagrid("getRowIndex",row);
 							$("#role_list_box").datagrid("deleteRow",index);
						}
						rightBottom(json.message);
					},'json');
				}
			});
		}else{
			rightBottom("请选择后再操作");
		}
	});
	//------------------refresh-----------------------------
	$("#role_refresh_btn").click(function(){
		 $("#role_list_box").datagrid("reload");
	});
	//----------------------role_add_menu---------------------
	$("#role_addMenu_btn").click(function(){
		var row = $("#role_list_box").datagrid("getSelected");
		if(row){
			var url = "${ctx }/system/role/resourcelist.do?roleid="+row.id;
			var title = "角色："+row.name+"--权限设置";
			var opts = {
				region:"east",
				width:350,
				title:title,
				href:url
			}
			$("body").layout('remove','east').layout('add',opts);
		}else{
			rightBottom("请选择后再操作");
		}
	});
	
});

</script>
</head>
<body class="easyui-layout" >
<div id="tb" style="padding: 3px; height: auto">
		<a href="javascript:void(0)" id="role_add_btn" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
		<a href="javascript:void(0)" id="role_edit_btn" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">编辑</a>
		<a href="javascript:void(0)" id="role_addMenu_btn" class="easyui-linkbutton" data-options="iconCls:'icon-key',plain:true">赋权</a>
		<a href="javascript:void(0)" id="role_remove_btn" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>
		<a href="javascript:void(0)" id="role_refresh_btn" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>
	</div>
<div region="center" border="false" >
	  <table id="role_list_box"  class="easyui-datagrid"  
	  data-options="striped:true,toolbar:'#tb', rownumbers:true,border:false,fit:true,pagination:true,singleSelect:true,pageSize:25,pageList:[25,50,100],
	  url:'${ctx }/system/role/list.do'" >
		                  <thead>
			               <tr>
				             <th data-options="field:'id',hidden:true">ID</th>
				             <th data-options="field:'name',width:100,halign:'center',align:'left'">名称</th>
				             <th data-options="field:'descn',width:180,halign:'center',align:'left'">描述</th>
			              </tr>
		                </thead>
	                  </table>
</div>
<div style="display: none;padding: 20px" id="role_edit_box" />
</body>
</html>