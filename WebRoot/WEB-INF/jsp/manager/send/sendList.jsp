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
	$("#send_add_btn").click(function(){
		$("#send_edit_box").show().dialog({
			width:600,
			height:300,
			modal:true,
			href:'${ctx }/manager/send/create.do',
			title:'添加收料单',
			buttons: [{
					text:'确定',
					iconCls:'icon-ok',
					handler:function(){
					    $("#send_edit_form").submit();
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$("#send_edit_box").dialog("close");
					}
				}]
		});
		
		
		
		
	});
	
	//------------------edit-----------------------------
	$("#send_edit_btn").click(function(){
		var row = $("#send_list_box").datagrid("getSelected");
		if(row){
			var url = "${ctx }/manager/send/edit.do?id="+row.id;
			$("#send_edit_box").show().dialog({
				width:600,
				height:300,
				modal:true,
				href:url,
				title:'编辑收料单',
				buttons: [{
						text:'确定',
						iconCls:'icon-ok',
						handler:function(){
							  $("#send_edit_form").submit();
						}
					},{
						text:'取消',
						iconCls:'icon-cancel',
						handler:function(){
							$("#send_edit_box").dialog("close");
						}
					}]
			});
		}else{
		
		  rightBottom("请选择行后进行编辑。");
		
		}
	});
	
	//------------------remove-----------------------------
	$("#send_remove_btn").click(function(){
		var row = $("#send_list_box").datagrid("getSelected");
		if(row){
			var title = "您确定要删除这条记录吗?";
			$.messager.confirm('', title, function(r){
				if (r){
					var url = "${ctx }/manager/send/delete.do?id="+row.id;
					$.get(url,function(json){
						if(json.statusCode==200){
 							var index = $("#send_list_box").datagrid("getRowIndex",row);
 							$("#send_list_box").datagrid("deleteRow",index);
						}
						rightBottom(json.message);
					},'json');
				}
			});
		}
	});
	//------------------refresh-----------------------------
	$("#send_refresh_btn").click(function(){
		 $("#send_list_box").datagrid("reload");
	});

	$("#doSearch").click(function(){
	   $("#send_list_box").datagrid({
		  url : "${ctx }/manager/send/list.do?materialid="+$("#s_name").combobox("getValue")+"&s_number="+encodeURI($("#s_number").val())+"&s_begin="+$("#s_begin").val()+"&s_end="+$("#s_end").val()+"&s_rnumber="+encodeURI($("#s_rnumber").val())
	   });
	
	});
	
	
	
	
	
	
	
	
	
});


 
</script>
</head>
<body class="easyui-layout" >
  <div region="north" border="false" style="height: 70px;background-color:#f4f4f4;">
   <div id="tb" style="padding: 2px; height: auto">
		<a href="javascript:void(0)" id="send_add_btn" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
		<a href="javascript:void(0)" id="send_edit_btn" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">编辑</a>
		<a href="javascript:void(0)" id="send_remove_btn" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>
		<a href="javascript:void(0)" id="send_refresh_btn" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>
	</div>
		<table border="0" style="margin-top: 0" class="table">
			<tr style="width: 100%">
		        <th>发料单编号：</th>
		        <td><input id="s_number"  style="width: 100px"></html:text> &nbsp;&nbsp;</td>
		        <th>物料名称：</th>
		        <td><input id="s_name" style="width: 100px" ></html:text> &nbsp;&nbsp;</td>
		        <th>收料单编号：</th>
		        <td><input id="s_rnumber"  style="width: 100px"></html:text> &nbsp;&nbsp;</td>
		        <th>日期：</th>
		        <td>
		          <input name="s_begin" id="s_begin"  class="easyui-my97" style="width:80px; height: 17px;" readonly="readonly" editable="false" data-options="skin:'twoer',dateFmt:'yyyy-MM-dd'"  />
		          -
		          <input name="s_end" id="s_end"  class="easyui-my97" style="width:80px; height: 17px;" readonly="readonly" editable="false" data-options="skin:'twoer',dateFmt:'yyyy-MM-dd'"  />
		        </td>
		        <th> 
		          <a data-options="iconCls:'icon-search'" class="easyui-linkbutton" id="doSearch"  style="margin-left:10px">查询</a>
		        </th>
			</tr>
		</table>
  </div>
 
<div region="center" border="false" >
	  <table id="send_list_box"  class="easyui-datagrid"  
	  data-options="striped:true, rownumbers:true,border:false,fit:true,pagination:true,singleSelect:true,pageSize:25,pageList:[25,50,100],
	  url:'${ctx }/manager/send/list.do'" >
		                  <thead>
			               <tr>
				             <th data-options="field:'id',hidden:true">ID</th>
				             <th data-options="field:'number',width:100,halign:'center',align:'center'">发料单编号</th>
				             <th data-options="field:'factory',width:120,halign:'center',align:'center'">加工厂</th>
				             <th data-options="field:'materialname',width:120,halign:'center',align:'center'">物料名称</th>
				             <th data-options="field:'take',width:80,halign:'center',align:'center'">领用数量</th>
				             <th data-options="field:'mount',width:80,halign:'center',align:'center'">开剪数量</th>
				             <th data-options="field:'borrow',width:100,halign:'center',align:'center'">借用</th>
				             <th data-options="field:'r',width:100,halign:'center',align:'center'">单耗</th>
				             <th data-options="field:'rnumber',width:100,halign:'center',align:'center'">收料单编号</th>
				             <th data-options="field:'left',width:70,halign:'center',align:'center'">物料剩余</th>
				             <th data-options="field:'dt',width:80,halign:'center',align:'center'">日期</th>
			              </tr>
		                </thead>
	  </table>
</div>
<div style="display: none;padding: 5px" id="send_edit_box" />
</body>

</html>
