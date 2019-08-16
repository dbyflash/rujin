<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/js/ztree/css/zTreeStyle/zTreeStyle.css">
<script type="text/javascript" charset="utf-8" src="${ctx}/js/ztree/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript">
var id='${id}';
$(function(){
var nodes = ${json};
var setting = {
			view: {
				selectedMulti: false
			},
			check: {
				enable: true
			},
			data: {
				simpleData: {
					enable: true
				}
			}
		};

	$.fn.zTree.init($("#menuset_tree"), setting, nodes);

	$("#role_menu_cancel_btn").bind('click',function(){
		$('body').layout('remove','east');
	});
	
	$("#role_menu_ok_btn").bind('click',function(){
		var idArray = [];
		var zTree = $.fn.zTree.getZTreeObj("menuset_tree");
		var checkedNodeArray = zTree.getCheckedNodes(true);
		for(var k in checkedNodeArray){
			idArray.push(checkedNodeArray[k].id);
		}
		idArray = idArray.join(',');
		
		if(!idArray){
			$.messager.confirm('确认提示框', '您没有给当前角色任何权限<br/>确认要提交吗?', function(r){
				if(r){
					var data = "id="+id;
					postSubmit(data);
				}
			});
		}else{
			var data = "id="+id+"&resourceids="+idArray;
			postSubmit(data);
		}
	});
});	

function postSubmit(data){
	$.post('${ctx }/system/role/saveResource.do',data,function(json){
		rightBottom(json.message);
	},'json');
}
</script>
<div class="easyui-layout" fit="true">
	<div region="south" border="false" style="height:50px;background-color: #F4F4F4;padding: 15px;text-align: center">
		<a href="javascript:void(0)" id="role_menu_ok_btn" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a>
		<a href="javascript:void(0)" id="role_menu_cancel_btn" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">退出</a>
	</div>
	<div region="center" border="false" style="padding: 10px">
		<ul id="menuset_tree" class="ztree"></ul>
	</div>
</div>