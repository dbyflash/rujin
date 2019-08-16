<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<html>
	<head>
<%@ include file="/commons/meta.jsp"%>
<script type="text/javascript">

$(function() {

//产品combobox
    $("#s_name").combobox({
    	  width:'90',
          required:false,
		  url:context+'/manager/product/getlist.do',
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
	$("#out_add_btn").click(function(){
		$("#out_edit_box").show().dialog({
			width:600,
			height:400,
			modal:true,
			href:'${ctx }/manager/out/create.do',
			title:'添加出库单',
			buttons: [{
					text:'确定',
					iconCls:'icon-ok',
					handler:function(){
					    $("#out_edit_form").submit();
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$("#out_edit_box").dialog("close");
					}
				}]
		});
		
		
		
		
	});
	
	//------------------edit-----------------------------
	$("#out_edit_btn").click(function(){
		var row = $("#out_list_box").datagrid("getSelected");
		if(row){
			var url = "${ctx }/manager/out/edit.do?id="+row.id;
			$("#out_edit_box").show().dialog({
				width:600,
				height:400,
				modal:true,
				href:url,
				title:'编辑出库单',
				buttons: [{
						text:'确定',
						iconCls:'icon-ok',
						handler:function(){
							  $("#out_edit_form").submit();
						}
					},{
						text:'取消',
						iconCls:'icon-cancel',
						handler:function(){
							$("#out_edit_box").dialog("close");
						}
					}]
			});
		}else{
		
		  rightBottom("请选择行后进行编辑。");
		
		}
	});
	//------------------view-----------------------------
	$("#out_view_btn").click(function(){
		var row = $("#out_list_box").datagrid("getSelected");
		if(row){
			var url = "${ctx }/manager/out/view.do?id="+row.id;
			$("#out_edit_box").show().dialog({
				width:550,
				height:350,
				modal:true,
				href:url,
				title:'查看详情',
				buttons: [{
						text:'取消',
						iconCls:'icon-cancel',
						handler:function(){
							$("#out_edit_box").dialog("close");
						}
					}]
			});
		}else{
		
		  rightBottom("请选择行后进行查看。");
		
		}
	});
	//------------------remove-----------------------------
	$("#out_remove_btn").click(function(){
		var row = $("#out_list_box").datagrid("getSelected");
		if(row){
			var title = "您确定要删除这条记录吗?";
			$.messager.confirm('', title, function(r){
				if (r){
					var url = "${ctx }/manager/out/delete.do?id="+row.id;
					$.get(url,function(json){
						if(json.statusCode==200){
 							var index = $("#out_list_box").datagrid("getRowIndex",row);
 							$("#out_list_box").datagrid("deleteRow",index);
						}
						rightBottom(json.message);
					},'json');
				}
			});
		}
	});
	//------------------refresh-----------------------------
	$("#out_refresh_btn").click(function(){
		 $("#out_list_box").datagrid("reload");
	});

	$("#doSearch").click(function(){
	   $("#out_list_box").datagrid({
		  url : "${ctx }/manager/out/list.do?productid="+$("#s_name").combobox("getValue")+"&s_number="+encodeURI($("#s_number").val())+"&s_begin="+$("#s_begin").val()+"&s_end="+$("#s_end").val()+"&s_snumber="+encodeURI($("#s_snumber").val())
	   });
	
	});
	
	
	
	
	
	
	
	
	
});


 
</script>
</head>
<body class="easyui-layout" >
  <div region="north" border="false" style="height: 70px;background-color:#f4f4f4;">
   <div id="tb" style="padding: 2px; height: auto">
		<a href="javascript:void(0)" id="out_add_btn" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
		<a href="javascript:void(0)" id="out_edit_btn" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">编辑</a>
		<a href="javascript:void(0)" id="out_remove_btn" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>
		<a href="javascript:void(0)" id="out_view_btn" class="easyui-linkbutton" data-options="iconCls:'icon-detail',plain:true">详情</a>
		<a href="javascript:void(0)" id="out_refresh_btn" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>
	</div>
		<table border="0" style="margin-top: 0" class="table">
			<tr style="width: 100%">
		        <th>出库单编号：</th>
		        <td><input id="s_number"  style="width: 100px"></html:text> &nbsp;&nbsp;</td>
		        <th>产品名称：</th>
		        <td><input id="s_name" style="width: 100px" ></html:text> &nbsp;&nbsp;</td>
		        <th>入库单编号：</th>
		        <td><input id="s_snumber"  style="width: 100px"></html:text> &nbsp;&nbsp;</td>
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
	  <table id="out_list_box"  class="easyui-datagrid"  
	  data-options="striped:true, rownumbers:true,border:false,fit:true,pagination:true,singleSelect:true,pageSize:25,pageList:[25,50,100],
	  url:'${ctx }/manager/out/list.do'" >
		                  <thead>
			               <tr>
				             <th data-options="field:'id',hidden:true">ID</th>
				             <th data-options="field:'number',width:100,halign:'center',align:'center'">出库单编号</th>
				             <th data-options="field:'productnumber',width:100,halign:'center',align:'center'">货号</th>
				             <th data-options="field:'productname',width:120,halign:'center',align:'center'">产品名称</th><!--
				             <th data-options="field:'style',width:100,halign:'center',align:'center'">计量单位</th>
				             <th data-options="field:'inch',width:70,halign:'center',align:'center'">英寸</th>
				             <th data-options="field:'mount',width:70,halign:'center',align:'center'">数量</th>
				             <th data-options="field:'boxmount',width:70,halign:'center',align:'center'">箱数</th>
				             <th data-options="field:'boxin',width:70,halign:'center',align:'center'">箱入(条)</th>
				             <th data-options="field:'netweight',width:70,halign:'center',align:'center'">净重</th>
				             <th data-options="field:'gw',width:70,halign:'center',align:'center'">毛重</th>
				             <th data-options="field:'boxstyle',width:100,halign:'center',align:'center'">纸箱尺寸</th>
				             <th data-options="field:'boxnumber',width:70,halign:'center',align:'center'">箱号</th>
				             <th data-options="field:'borrow',width:70,halign:'center',align:'center'">借用</th>
				             --><th data-options="field:'snumber',width:100,halign:'center',align:'center'">入库单编号</th>
				             <th data-options="field:'left',width:90,halign:'center',align:'center'">产品剩余</th>
				             <th data-options="field:'dt',width:90,halign:'center',align:'center'">日期</th>
			              </tr>
		                </thead>
	  </table>
</div>
<div style="display: none;padding: 5px" id="out_edit_box" />
</body>

</html>
