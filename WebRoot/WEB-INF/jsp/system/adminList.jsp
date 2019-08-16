<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<html>
	<head>
<%@ include file="/commons/meta.jsp"%>
<script type="text/javascript">
$(function() {

	//------------------add-----------------------------
	$("#admin_add_btn").click(function(){
		$("#admin_edit_box").show().dialog({
			width:600,
			height:500,
			modal:true,
			href:'${ctx }/system/admin/create.do',
			title:'添加用户',
			buttons: [{
					text:'确定',
					iconCls:'icon-ok',
					handler:function(){
						save();//保存
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$("#admin_edit_box").dialog("close");
					}
				}]
		});
	});
	
	//------------------edit-----------------------------
	$("#admin_edit_btn").click(function(){
		var row = $("#admin_list_box").datagrid("getSelected");
		if(row){
			var url = "${ctx }/system/admin/edit.do?id="+row.id;
			$("#admin_edit_box").show().dialog({
				width:600,
				height:500,
				modal:true,
				href:url,
				title:'编辑用户',
				buttons: [{
						text:'确定',
						iconCls:'icon-ok',
						handler:function(){
							save();//保存
						}
					},{
						text:'取消',
						iconCls:'icon-cancel',
						handler:function(){
							$("#admin_edit_box").dialog("close");
						}
					}]
			});
		}else{
		
		  rightBottom("请选择行后进行编辑。");
		
		}
	});
	
	//------------------remove-----------------------------
	$("#admin_remove_btn").click(function(){
		var row = $("#admin_list_box").datagrid("getSelected");
		if(row){
			var title = "您确定要删除这条记录吗?";
			$.messager.confirm('', title, function(r){
				if (r){
					var url = "${ctx }/system/admin/isdelete.do?id="+row.id;
					$.get(url,function(json){
						if(json.statusCode==200){
 							var index = $("#admin_list_box").datagrid("getRowIndex",row);
 							$("#admin_list_box").datagrid("deleteRow",index);
						}
						rightBottom(json.message);
					},'json');
				}
			});
		}
	});
	//------------------refresh-----------------------------
	$("#admin_refresh_btn").click(function(){
		 $("#admin_list_box").datagrid("reload");
	});
	//----------------------admin_add_menu---------------------
	$("#admin_addMenu_btn").click(function(){
		var row = $("#admin_list_box").datagrid("getSelected");
		if(row){
			var url = "${ctx }/system/role/resourcelist.do?roleid="+row.id;
			var title = "用户："+row.name+"--权限设置";
			var opts = {
				region:"east",
				width:350,
				title:title,
				href:url
			}
			$("body").layout('remove','east').layout('add',opts);
		}
	});
	
	$("#doSearch").click(function(){
	   $("#admin_list_box").datagrid({
		  url : "${ctx }/system/admin/list.do?s_loginname="+$("#s_loginname").val()+"&s_name="+$("#s_name").val()
	   });
	
	});
	
	
	$("#admin_pwdreset_btn").click(function(){
		var row = $("#admin_list_box").datagrid("getSelected");
		if(row){
		$("#admin_edit_box").show().dialog({
			width:310,
			height:230,
			modal:true,
			href:'${ctx }/system/admin/passwordReset.do?type=toreset&id='+row.id,
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
						$("#admin_edit_box").dialog("close");
					}
				}]
		});
		}else{
		 rightBottom("请选择行后进行操作。");
		}
	});
	
	
	
});

function formatterState(value,row,index){

   if(value==0){
   return "正常";
   }else if(value==1){
   return "禁用";
   }
  
   
}

 
</script>
</head>
<body class="easyui-layout" >
  <div region="north" border="false" style="height: 70px;background-color:#f4f4f4;">
   <div id="tb" style="padding: 2px; height: auto">
		<a href="javascript:void(0)" id="admin_add_btn" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
		<a href="javascript:void(0)" id="admin_edit_btn" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">编辑</a>
		<a href="javascript:void(0)" id="admin_pwdreset_btn" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">密码重置</a>
		<a href="javascript:void(0)" id="admin_remove_btn" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>
		<a href="javascript:void(0)" id="admin_refresh_btn" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>
	</div>
		<table border="0" style="margin-top: 0" class="table">
			<tr style="width: 100%">
			    <th>登录名：</th>
				<td height="23px">
				<input id="s_loginname"/>&nbsp;&nbsp;
		 	 	    
		        </td>
		        <th>真实姓名：</th>
		        <td><input id="s_name"  ></html:text> &nbsp;&nbsp;</td>
		        <th> <a data-options="iconCls:'icon-search'" class="easyui-linkbutton" id="doSearch"  style="margin-left:10px">查询</a></th>
			</tr>
		</table>
  </div>
 
<div region="center" border="false" >
	  <table id="admin_list_box"  class="easyui-datagrid"  
	  data-options="striped:true, rownumbers:true,border:false,fit:true,pagination:true,singleSelect:true,pageSize:25,pageList:[25,50,100],
	  url:'${ctx }/system/admin/list.do'" >
		                  <thead>
			               <tr>
				             <th data-options="field:'id',hidden:true">ID</th>
				             <th data-options="field:'loginname',width:120,halign:'center',align:'left'">登陆名称</th>
				             <th data-options="field:'name',width:100,halign:'center',align:'left'">真实姓名</th>
				             <th data-options="field:'isforbidden',width:80,halign:'center',align:'left',formatter:formatterState">账号状态</th>
			              </tr>
		                </thead>
	  </table>
</div>
<div style="display: none;padding: 5px" id="admin_edit_box" />
</body>

</html>
