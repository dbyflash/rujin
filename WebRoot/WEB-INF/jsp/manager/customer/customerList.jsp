<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<html>
	<head>
<%@ include file="/commons/meta.jsp"%>
<script src="${ctx}/js/vuejs/dist/vue.js" type="text/javascript"></script>


<script type="text/javascript">

$(function() {
	var app3 = new Vue({
		  el: '#app-3',
		  data: {
		    seen: false
		  }
		});
	setTimeout(function(){
		app3.seen=true;
	}, 2000)
	
	
	//------------------add-----------------------------
	$("#customer_add_btn").click(function(){
		$("#customer_edit_box").show().dialog({
			width:330,
			height:300,
			modal:true,
			href:'${ctx }/manager/customer/create.do',
			title:'添加客户',
			buttons: [{
					text:'确定',
					iconCls:'icon-ok',
					handler:function(){
					    $("#customer_edit_form").submit();
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$("#customer_edit_box").dialog("close");
					}
				}]
		});
		
		
		
		
	});
	
	//------------------edit-----------------------------
	$("#customer_edit_btn").click(function(){
		var row = $("#customer_list_box").datagrid("getSelected");
		if(row){
			var url = "${ctx }/manager/customer/edit.do?id="+row.id;
			$("#customer_edit_box").show().dialog({
				width:330,
				height:300,
				modal:true,
				href:url,
				title:'编辑客户',
				buttons: [{
						text:'确定',
						iconCls:'icon-ok',
						handler:function(){
							  $("#customer_edit_form").submit();
						}
					},{
						text:'取消',
						iconCls:'icon-cancel',
						handler:function(){
							$("#customer_edit_box").dialog("close");
						}
					}]
			});
		}else{
		
		  rightBottom("请选择行后进行编辑。");
		
		}
	});
	
	//------------------remove-----------------------------
	$("#customer_remove_btn").click(function(){
		var row = $("#customer_list_box").datagrid("getSelected");
		if(row){
			var title = "您确定要删除这条记录吗?";
			$.messager.confirm('', title, function(r){
				if (r){
					var url = "${ctx }/manager/customer/delete.do?id="+row.id;
					$.get(url,function(json){
						if(json.statusCode==200){
 							var index = $("#customer_list_box").datagrid("getRowIndex",row);
 							$("#customer_list_box").datagrid("deleteRow",index);
						}
						rightBottom(json.message);
					},'json');
				}
			});
		}
	});
	//------------------refresh-----------------------------
	$("#customer_refresh_btn").click(function(){
		 $("#customer_list_box").datagrid("reload");
	});

	$("#doSearch").click(function(){
	   $("#customer_list_box").datagrid({
		  url : "${ctx }/manager/customer/list.do?s_name="+encodeURI($("#s_name").val())
	   });
	
	});
	
	//文件上传
	$("#customer_file_btn").click(function(){
		var url = "${ctx }/manager/doupload/uploadFile.do";
		$("#customer_edit_box").show().dialog({
			width:800,
			height:500,
			modal:true,
			href:url,
			title:'上传文件',
			buttons: [{
					text:'确定',
					iconCls:'icon-ok',
					handler:function(){
						  uploadFile();
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$("#customer_edit_box").dialog("close");
					}
				}]
		});
	});
	
	
	
	
	
	
	
});


 
</script>
</head>
<body class="easyui-layout" >
  <div region="north" border="false" style="height: 70px;background-color:#f4f4f4;">
   <div id="tb" style="padding: 2px; height: auto">
		<a href="javascript:void(0)" id="customer_add_btn" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
		<a href="javascript:void(0)" id="customer_edit_btn" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">编辑</a>
		<a href="javascript:void(0)" id="customer_remove_btn" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>
		<a href="javascript:void(0)" id="customer_refresh_btn" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>
		<a href="javascript:void(0)" id="customer_file_btn" class="easyui-linkbutton" data-options="iconCls:'icon-filesave',plain:true">文件上传</a>
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

	  <div id="app-3">
  <p v-if="seen">现在你看到我了</p>
</div>



</div>
<div style="display: none;padding: 5px" id="customer_edit_box" />
</body>

</html>
