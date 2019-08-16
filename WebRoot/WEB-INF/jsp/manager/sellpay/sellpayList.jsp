<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<html>
	<head>
<%@ include file="/commons/meta.jsp"%>
<script type="text/javascript">

$(function() {

	//------------------add-----------------------------
	$("#sellpay_add_btn").click(function(){
		$("#sellpay_edit_box").show().dialog({
			width:600,
			height:300,
			modal:true,
			href:'${ctx }/manager/sellpay/create.do',
			title:'添加货款回收',
			buttons: [{
					text:'确定',
					iconCls:'icon-ok',
					handler:function(){
					    $("#sellpay_edit_form").submit();
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$("#sellpay_edit_box").dialog("close");
					}
				}]
		});
		
		
		
		
	});
	
	//------------------edit-----------------------------
	$("#sellpay_edit_btn").click(function(){
		var row = $("#sellpay_list_box").datagrid("getSelected");
		if(row){
			var url = "${ctx }/manager/sellpay/edit.do?id="+row.id;
			$("#sellpay_edit_box").show().dialog({
				width:600,
				height:300,
				modal:true,
				href:url,
				title:'编辑货款回收',
				buttons: [{
						text:'确定',
						iconCls:'icon-ok',
						handler:function(){
							  $("#sellpay_edit_form").submit();
						}
					},{
						text:'取消',
						iconCls:'icon-cancel',
						handler:function(){
							$("#sellpay_edit_box").dialog("close");
						}
					}]
			});
		}else{
		
		  rightBottom("请选择行后进行编辑。");
		
		}
	});
	
	//------------------remove-----------------------------
	$("#sellpay_remove_btn").click(function(){
		var row = $("#sellpay_list_box").datagrid("getSelected");
		if(row){
			var title = "您确定要删除这条记录吗?";
			$.messager.confirm('', title, function(r){
				if (r){
					var url = "${ctx }/manager/sellpay/delete.do?id="+row.id;
					$.get(url,function(json){
						if(json.statusCode==200){
 							var index = $("#sellpay_list_box").datagrid("getRowIndex",row);
 							$("#sellpay_list_box").datagrid("deleteRow",index);
						}
						rightBottom(json.message);
					},'json');
				}
			});
		}
	});
	//------------------refresh-----------------------------
	$("#sellpay_refresh_btn").click(function(){
		 $("#sellpay_list_box").datagrid("reload");
	});

	$("#doSearch").click(function(){
	   $("#sellpay_list_box").datagrid({
		  url : "${ctx }/manager/sellpay/list.do?s_unitname="+encodeURI($("#s_unitname").val())+"&s_number="+encodeURI($("#s_number").val())+"&s_begin="+$("#s_begin").val()+"&s_end="+$("#s_end").val()+"&s_cnumber="+encodeURI($("#s_cnumber").val())
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
		<a href="javascript:void(0)" id="sellpay_add_btn" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
		<a href="javascript:void(0)" id="sellpay_edit_btn" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">编辑</a>
		<a href="javascript:void(0)" id="sellpay_remove_btn" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>
		<a href="javascript:void(0)" id="sellpay_refresh_btn" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>
	</div>
		<table border="0" style="margin-top: 0" class="table">
			<tr style="width: 100%">
		        <th>销售合同编号：</th>
		        <td><input id="s_cnumber"  style="width: 100px"></html:text> &nbsp;&nbsp;</td>
		        <th>单据号码：</th>
		        <td><input id="s_number"  style="width: 100px"></html:text> &nbsp;&nbsp;</td>
		        <th>付款单位：</th>
		        <td><input id="s_unitname" style="width: 100px" ></html:text> &nbsp;&nbsp;</td>
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
	  <table id="sellpay_list_box"  class="easyui-datagrid"  
	  data-options="striped:true, rownumbers:true,border:false,fit:true,pagination:true,singleSelect:true,pageSize:25,pageList:[25,50,100],
	  url:'${ctx }/manager/sellpay/list.do'" >
		                  <thead>
			               <tr>
				             <th data-options="field:'id',hidden:true">ID</th>
				             <th data-options="field:'unitname',width:120,halign:'center',align:'center'">付款单位</th>
				             <th data-options="field:'paytype',width:120,halign:'center',align:'center',formatter:formatterType">结算方式</th>
				             <th data-options="field:'number',width:100,halign:'center',align:'center'">单据号码</th>
				             <th data-options="field:'cnumber',width:100,halign:'center',align:'center'">销售合同编号</th>
				             <th data-options="field:'moneytypename',width:100,halign:'center',align:'center'">外币种类</th>
				             <th data-options="field:'foreignmoney',width:100,halign:'center',align:'center'">外币金额</th>
				             <th data-options="field:'money',width:100,halign:'center',align:'center'">人民币</th>
				             <th data-options="field:'banknumber',width:100,halign:'center',align:'center'">银行业务编号</th>
				              <th data-options="field:'dt',width:100,halign:'center',align:'center'">日期</th>
			              </tr>
		                </thead>
	  </table>
</div>
<div style="display: none;padding: 5px" id="sellpay_edit_box" />
</body>

</html>
