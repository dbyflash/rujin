<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<html>
	<head>
<%@ include file="/commons/meta.jsp"%>
<script type="text/javascript">

$(function() {

	//------------------add-----------------------------
	$("#buypayapply_add_btn").click(function(){
		$("#buypayapply_edit_box").show().dialog({
			width:600,
			height:270,
			modal:true,
			href:'${ctx }/manager/buypayapply/create.do',
			title:'添加付款申请',
			buttons: [{
					text:'确定',
					iconCls:'icon-ok',
					handler:function(){
					    $("#buypayapply_edit_form").submit();
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$("#buypayapply_edit_box").dialog("close");
					}
				}]
		});
		
		
		
		
	});
	
	//------------------edit-----------------------------
	$("#buypayapply_edit_btn").click(function(){
		var row = $("#buypayapply_list_box").datagrid("getSelected");
		if(row){
			var url = "${ctx }/manager/buypayapply/edit.do?id="+row.id;
			$("#buypayapply_edit_box").show().dialog({
				width:600,
				height:270,
				modal:true,
				href:url,
				title:'编辑付款申请',
				buttons: [{
						text:'确定',
						iconCls:'icon-ok',
						handler:function(){
							  $("#buypayapply_edit_form").submit();
						}
					},{
						text:'取消',
						iconCls:'icon-cancel',
						handler:function(){
							$("#buypayapply_edit_box").dialog("close");
						}
					}]
			});
		}else{
		
		  rightBottom("请选择行后进行编辑。");
		
		}
	});
	
	//------------------remove-----------------------------
	$("#buypayapply_remove_btn").click(function(){
		var row = $("#buypayapply_list_box").datagrid("getSelected");
		if(row){
			var title = "您确定要删除这条记录吗?";
			$.messager.confirm('', title, function(r){
				if (r){
					var url = "${ctx }/manager/buypayapply/delete.do?id="+row.id;
					$.get(url,function(json){
						if(json.statusCode==200){
 							var index = $("#buypayapply_list_box").datagrid("getRowIndex",row);
 							$("#buypayapply_list_box").datagrid("deleteRow",index);
						}
						rightBottom(json.message);
					},'json');
				}
			});
		}
	});
	//------------------refresh-----------------------------
	$("#buypayapply_refresh_btn").click(function(){
		 $("#buypayapply_list_box").datagrid("reload");
	});

	$("#doSearch").click(function(){
	   $("#buypayapply_list_box").datagrid({
		  url : "${ctx }/manager/buypayapply/list.do?s_applyman="+encodeURI($("#s_applyman").val())+"&s_number="+encodeURI($("#s_number").val())+"&s_cnumber="+encodeURI($("#s_cnumber").val())
	   });
	
	});
	
	
	
	
	
	
	
	
	
});

function formatterType(value,row,index){

   if(value==0){
   return "现金";
   }else if(value==1){
   return "现金转账支票";
   }else if(value==2){
   return "银行转账支票";
   }else if(value==3){
   return "电子银行转账";
   }else if(value==4){
   return "协议转账";
   }else if(value==5){
   return "其他";
   }
  
   
}
 
</script>
</head>
<body class="easyui-layout" >
  <div region="north" border="false" style="height: 70px;background-color:#f4f4f4;">
   <div id="tb" style="padding: 2px; height: auto">
		<a href="javascript:void(0)" id="buypayapply_add_btn" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
		<a href="javascript:void(0)" id="buypayapply_edit_btn" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">编辑</a>
		<a href="javascript:void(0)" id="buypayapply_remove_btn" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>
		<a href="javascript:void(0)" id="buypayapply_refresh_btn" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>
	</div>
		<table border="0" style="margin-top: 0" class="table">
			<tr style="width: 100%">
		        <th>坯布流转单号：</th>
		        <td><input id="s_cnumber"  style="width: 100px"></html:text> &nbsp;&nbsp;</td>
		        <th>申请单号：</th>
		        <td><input id="s_number"  style="width: 100px"></html:text> &nbsp;&nbsp;</td>
		        <th>申请人：</th>
		        <td><input id="s_applyman" style="width: 100px" ></html:text> &nbsp;&nbsp;</td>
		        <th> 
		          <a data-options="iconCls:'icon-search'" class="easyui-linkbutton" id="doSearch"  style="margin-left:10px">查询</a>
		        </th>
			</tr>
		</table>
  </div>
 
<div region="center" border="false" >
	  <table id="buypayapply_list_box"  class="easyui-datagrid"  
	  data-options="striped:true, rownumbers:true,border:false,fit:true,pagination:true,singleSelect:true,pageSize:25,pageList:[25,50,100],
	  url:'${ctx }/manager/buypayapply/list.do'" >
		                  <thead>
			               <tr>
				             <th data-options="field:'id',hidden:true">ID</th>
				             <th data-options="field:'number',width:120,halign:'center',align:'center'">付款申请单号</th>
				             <th data-options="field:'changeplacenumber',width:100,halign:'center',align:'center'">坯布流转单号</th>
				             <th data-options="field:'type',width:100,halign:'center',align:'center',formatter:formatterType">付款方式</th>
				             <th data-options="field:'unit',width:100,halign:'center',align:'center'">收款单位</th>
				             <th data-options="field:'money',width:100,halign:'center',align:'center'">金额</th>
				             <th data-options="field:'reason',width:100,halign:'center',align:'center'">事由</th>
				             <th data-options="field:'applyman',width:100,halign:'center',align:'center'">申请人</th>
				             <th data-options="field:'approveman',width:100,halign:'center',align:'center'">核准人</th>
			              </tr>
		                </thead>
	  </table>
</div>
<div style="display: none;padding: 5px" id="buypayapply_edit_box" />
</body>

</html>
