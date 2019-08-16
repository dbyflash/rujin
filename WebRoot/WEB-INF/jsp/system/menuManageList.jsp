<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<html>
	<head>
<%@ include file="/commons/meta.jsp"%>
<script type="text/javascript">
$(function() {

	$("#role_edit_btn").linkbutton("disable");
	
	//------------------edit-----------------------------
	$("#role_edit_btn").click(function(){
		var row = $("#role_list_box").datagrid("getSelected");
		if(row){
			var url ="${ctx }/system/resource/menuManage.do?roleid="+row.id;
			var title = "角色："+row.name+"--权限设置";
			var opts = {
				region:"east",
				width:350,
				title:title,
				href:url
			}
			$("body").layout('remove','east').layout('add',opts);
		}
	});
	
	//------------------refresh-----------------------------
	$("#role_refresh_btn").click(function(){
		 $("#role_list_box").datagrid("reload");
	});
	
});


</script>
</head>
<body class="easyui-layout" >
<div id="tb" style="padding: 3px; height: auto">
		<a href="javascript:void(0)" id="role_edit_btn" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">编辑</a>
		<a href="javascript:void(0)" id="role_refresh_btn" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>
	</div>
<div region="center" border="false" >
	  <table id="role_list_box"  class="easyui-datagrid"  
	  data-options="striped:true,toolbar:'#tb', rownumbers:true,border:false,fit:true,pagination:true,singleSelect:true,pageSize:25,pageList:[25,50,100],
	  url:'${ctx }/system/role/list.do',onClickRow:function(){$('#role_edit_btn').linkbutton('enable');}" >
		                  <thead>
			               <tr>
				             <th data-options="field:'id',hidden:true">ID</th>
				             <th data-options="field:'name',width:100,halign:'center',align:'left'">名称</th>
				             <th data-options="field:'type',width:100,halign:'center',align:'left'">类别</th>
				             <th data-options="field:'descn',width:180,halign:'center',align:'left'">描述</th>
			              </tr>
		                </thead>
	                  </table>
</div>

</body>
</html>