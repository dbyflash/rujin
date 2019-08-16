<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<html>
	<head>
<%@ include file="/commons/meta.jsp"%>
<script type="text/javascript">

$(function() {

	//------------------add-----------------------------
	$("#worker_add_btn").click(function(){
		$("#worker_edit_box").show().dialog({
			width:310,
			height:250,
			modal:true,
			href:'${ctx }/manager/worker/create.do',
			title:'添加用户',
			buttons: [{
					text:'确定',
					iconCls:'icon-ok',
					handler:function(){
					    $("#worker_edit_form").submit();
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$("#worker_edit_box").dialog("close");
					}
				}]
		});
		
		
		
		
	});
	
	//------------------edit-----------------------------
	$("#worker_edit_btn").click(function(){
		var row = $("#worker_list_box").datagrid("getSelected");
		if(row){
			var url = "${ctx }/manager/worker/edit.do?id="+row.id;
			$("#worker_edit_box").show().dialog({
				width:310,
				height:250,
				modal:true,
				href:url,
				title:'编辑用户',
				buttons: [{
						text:'确定',
						iconCls:'icon-ok',
						handler:function(){
							  $("#worker_edit_form").submit();
						}
					},{
						text:'取消',
						iconCls:'icon-cancel',
						handler:function(){
							$("#worker_edit_box").dialog("close");
						}
					}]
			});
		}else{
		
		  rightBottom("请选择行后进行编辑。");
		
		}
	});
	
	//------------------remove-----------------------------
	$("#worker_remove_btn").click(function(){
		var row = $("#worker_list_box").datagrid("getSelected");
		if(row){
			var title = "您确定要删除这条记录吗?";
			$.messager.confirm('', title, function(r){
				if (r){
					var url = "${ctx }/manager/worker/delete.do?id="+row.id;
					$.get(url,function(json){
						if(json.statusCode==200){
 							var index = $("#worker_list_box").datagrid("getRowIndex",row);
 							$("#worker_list_box").datagrid("deleteRow",index);
						}
						rightBottom(json.message);
					},'json');
				}
			});
		}
	});
	//------------------refresh-----------------------------
	$("#worker_refresh_btn").click(function(){
		 $("#worker_list_box").datagrid("reload");
	});

	$("#doSearch").click(function(){
	   $("#worker_list_box").datagrid({
		  url : "${ctx }/manager/worker/list.do?s_name="+encodeURIComponent($("#s_name").val())
	   });
	
	});
	
	$("#doTest").click(function(){
	      
	      
	      	var url = "${ctx }/manager/worker/test1.do";
					$.post(url,function(json){
 							 alert("执行完毕");
					},'json');
	});
	
	
	
	$("#worker_pwdreset_btn").click(function(){
	
		var row = $("#worker_list_box").datagrid("getSelected");
		if(row){
		$("#worker_edit_box").show().dialog({
			width:310,
			height:230,
			modal:true,
			href:'${ctx }/manager/worker/passwordReset.do?type=toreset&id='+row.id,
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
						$("#worker_edit_box").dialog("close");
					}
				}]
		});
		}else{
		 rightBottom("请选择行后进行操作。");
		}
	});
	
	
	
});

function formatterSex(value,row,index){

   if(value==0){
   return "男";
   }else if(value==1){
   return "女";
   }
  
   
}

 
</script>
</head>
<body class="easyui-layout" >
  <div region="north" border="false" style="height: 70px;background-color:#f4f4f4;">
   <div id="tb" style="padding: 2px; height: auto">
		<a href="javascript:void(0)" id="worker_add_btn" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
		<a href="javascript:void(0)" id="worker_edit_btn" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">编辑</a>
		<a href="javascript:void(0)" id="worker_remove_btn" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>
		<a href="javascript:void(0)" id="worker_refresh_btn" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>
	</div>
		<table border="0" style="margin-top: 0" class="table">
			<tr style="width: 100%">
		        <th>姓名：</th>
		        <td><input id="s_name"  ></html:text> &nbsp;&nbsp;</td>
		        <th> <a data-options="iconCls:'icon-search'" class="easyui-linkbutton" id="doSearch"  style="margin-left:10px">查询</a>
		       	
		        </th>
			</tr>
		</table>
  </div>
 
<div region="center" border="false" >
	  <table id="worker_list_box"  class="easyui-datagrid"  
	  data-options="striped:true, rownumbers:true,border:false,fit:true,pagination:true,singleSelect:true,pageSize:25,pageList:[25,50,100],
	  url:'${ctx }/manager/worker/list.do'" >
		                  <thead>
			               <tr>
				             <th data-options="field:'id',hidden:true">ID</th>
				             <th data-options="field:'name',width:120,halign:'center',align:'center'">姓名</th>
				             <th data-options="field:'sex',width:100,halign:'center',align:'center',formatter:formatterSex">性别</th>
				             <th data-options="field:'age',width:100,halign:'center',align:'center'">年龄</th>
				             <th data-options="field:'gh',width:100,halign:'center',align:'center'">工号</th>
				             <th data-options="field:'tel',width:100,halign:'center',align:'center'">电话</th>
			              </tr>
		                </thead>
	  </table>
</div>
<div style="display: none;padding: 5px" id="worker_edit_box" />
</body>

</html>
