<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<script type="text/javascript">
	var pid=undefined;
	var tnode=undefined;
	var roleid='${param.roleid}';
	function add(){
	
		$("#menuManage_edit_box").show().dialog({
			width:550,
			height:250, 
			modal:true,
			href:'${ctx }/system/resource/create.do?roleid='+roleid+'&pid='+pid,
			title:'添加菜单',
			buttons: [{
					text:'确定',
					iconCls:'icon-ok',
					handler:function(){
						$("#menuManage_edit_form").submit();
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$("#menuManage_edit_box").dialog("close");
					}
				}]
	});
	}
	function edit(){
	
	 	
		if(pid){
			var url = "${ctx }/system/resource/edit.do?id="+pid+"&roleid="+roleid;
			$("#menuManage_edit_box").show().dialog({
				width:550,
				height:250,
				modal:true,
				href:url,
				title:'编辑角色',
				buttons: [{
						text:'确定',
						iconCls:'icon-ok',
						handler:function(){
							$("#menuManage_edit_form").submit();
						}
					},{
						text:'取消',
						iconCls:'icon-cancel',
						handler:function(){
							$("#menuManage_edit_box").dialog("close");
						}
					}]
			});
		}else{
			rightBottom("请选择后再操作");
		}
	}
	function removeTree(){
		if($("#menuset_tree").tree("isLeaf",tnode.target)){
			$.messager.confirm("提示信息", "确认删除吗？", function(r){
				if(r){
					var url="${ctx}/system/resource/delete.do?id="+pid;
					$.post(url,function(msg){
						rightBottom(msg.message);
						 $("#menuset_tree").tree("reload");
					},'json');
				}
			});
		}else{
			rightBottom("请先删除子节点！");
			tnode=undefined;
		}
	}
	function save(){
		if($("#validateform").form('validate')){//验证
			var id=$("#resourceid").val();
			var name=$("#name").val();
			var resstring=$("#url").val();
			var ordernum=$("#ordernum").numberbox("getValue");
			var url="${ctx}/system/resource/save.do";
			if(id=="undefined") id="";
			var param="id="+id+"&name="+name+"&resstring="+encodeURIComponent(resstring)+"&ordernum="+ordernum+"&level=${param.level}&pid="+pid+"&roleid=${param.roleid}";
			$.post(url,param,function(msg){
				   if(msg.statusCode==200){
				     $("#menuset_tree").tree("reload");
				     $("#addTreeSet").dialog("close");
				     $("#resourceid").val("");
				     $("#name").val("");
					 $("#url").val("");
					 $("#ordernum").numberbox("clear");
					 pid=undefined;
					 name=undefined;
					 url=undefined;
					 ordernum=undefined;
					 tnode=undefined;
				   }
				  rightBottom(msg.message);
               
			},'json');
			
			
		}
	}
	
	
	
	
</script>
<div class="easyui-layout" fit="true">
	<div region="south" border="false" style="height:50px;background-color: #F4F4F4;padding: 15px;text-align: center">
		<a href="javascript:void(0)" id="role_menu_ok_btn" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a>
		<a href="javascript:void(0)" id="role_menu_cancel_btn" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">退出</a>
	</div>
	<div region="center" border="false" style="padding: 10px">
		<ul id="menuset_tree" class="easyui-tree" data-options="
			url: '${ctx }/system/resource/getResourceTree.do?roleid=${param.roleid }',
			method: 'post',
			animate: true,
			onContextMenu: function(e,node){
				e.preventDefault();
				pid=node.id;
				tnode=node;
				$('#mm').menu('show',{
					left: e.pageX,
					top: e.pageY
				});
			}
			"></ul>
	</div>
	<div id="mm" class="easyui-menu">
  		<div id="add" onclick="add()" data-options="iconCls:'icon-add'">新建</div>
  		<div id="edit" onclick="edit()" data-options="iconCls:'icon-edit'">编辑</div>
  		<div id="remove" onclick="removeTree()" data-options="iconCls:'icon-cancel'">删除</div>
	</div>
	<div style="display: none;padding: 20px" id="menuManage_edit_box" />
</div>


