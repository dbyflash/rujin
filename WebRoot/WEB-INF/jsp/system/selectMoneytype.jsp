<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<script type="text/javascript">

	function search_collector(nodeid,type){

	    $("#search_moneytype_list_box").datagrid({
		  url : "${ctx }/manager/moneytype/list.do?s_name="+encodeURI($("#s_name").val())
	   });
	}
	
	function savesearch_moneytype(idinput,nameinput){
	   var row = $("#search_moneytype_list_box").datagrid("getSelected"); 
	   if(row==null){
	       rightBottom("请选择外币");
	   }
      $("#"+idinput).val(row.id);
      $("#"+nameinput).val(row.name);
    

	}

</script>
 <div class="easyui-layout" fit="true"  border="false">
  <div region="north" border="false" style="height: 40px;background-color:#f4f4f4;">
		<table border="0" style="margin-top: 0" class="table">
			<tr style="width: 100%">
			    <th>名称：</th>
				<td height="23px">
				<input id="s_name"/>
		        </td>
		        <th> <a data-options="iconCls:'icon-search'" class="easyui-linkbutton" id="search_collector_doSearch" onclick="search_collector()" style="margin-left:10px">查询</a></th>
			</tr>
		</table>
  </div>
<div data-options="region:'center'" fit="true" border="false">
    <table id="search_moneytype_list_box"  class="easyui-datagrid"  
	  data-options="striped:true, rownumbers:true,border:false,fit:true,pagination:true,singleSelect:true,pageSize:25,pageList:[25,50,100]" >
		                  <thead>
			               <tr>
			                <th data-options="field:'ck',checkbox:true"></th>
				             <th data-options="field:'id',hidden:true">客户ID</th>
				             <th data-options="field:'name',width:250,halign:'center',align:'left'">外币名称</th>
			              </tr>
		                </thead>
	  </table>
</div>

</div>
 
