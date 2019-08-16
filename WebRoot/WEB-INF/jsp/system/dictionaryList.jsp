<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<html>
	<head>
<%@ include file="/commons/meta.jsp"%>
<script type="text/javascript">

 function onContextMenu(e,row){
            e.preventDefault();
            $(this).treegrid('select', row.id);
            if(typeof(row._parentId)=="undefined"){//根节点
             $('#parentmenu').menu('show',{
                left: e.pageX,
                top: e.pageY
              });
            
            }else{
              $('#leafmenu').menu('show',{
                left: e.pageX,
                top: e.pageY
              });
            }
        }

function create(){
	var row = $("#treegrid").treegrid("getSelected");
	if(row){
  	$("#dictionary_edit_box").show().dialog({
			width:350,
			height:250,
			modal:true,
			href:'${ctx }/system/dictionary/create.do?parentid='+row.id,
			title:'添加字典',
			buttons: [{
					text:'确定',
					iconCls:'icon-ok',
					handler:function(){
						$("#dictionary_edit_form").submit();
					}
				},{
					text:'取消',
					iconCls:'icon-cancel',
					handler:function(){
						$("#dictionary_edit_box").dialog("close");
					}
				}]
		});
     }else{
      rightBottom("请选择行后进行添加。");
     }
}

function edit(){
	var row = $("#treegrid").treegrid("getSelected");
		if(row){
			var url = "${ctx }/system/dictionary/edit.do?id="+row.id;
			$("#dictionary_edit_box").show().dialog({
				width:350,
				height:250,
				modal:true,
				href:url,
				title:'编辑字典',
				buttons: [{
						text:'确定',
						iconCls:'icon-ok',
						handler:function(){
							$("#dictionary_edit_form").submit();
						}
					},{
						text:'取消',
						iconCls:'icon-cancel',
						handler:function(){
							$("#dictionary_edit_box").dialog("close");
						}
					}]
			});
		}else{
		  rightBottom("请选择行后进行编辑。");
		}
}

function del(){
var row = $("#treegrid").treegrid("getSelected");
if(row){
  if(typeof(row._parentId)=="undefined"){
   rightBottom("根节点无法删除");
   return;
  }
    $.messager.confirm('信息提示', '删除将删除本节点及所有子节点，确定要删除吗?', function(r){
                if (r){
                   var url = "${ctx }/system/dictionary/isdelete.do?id="+row.id;
					$.get(url,function(json){
						if(json.statusCode==200){
 							 $('#treegrid').treegrid("reload",row._parentId);
						}
						rightBottom(json.message);
					},'json');
                }
            });
}else{
   rightBottom("请选择后删除");
}
}
 
function refresh(){
	   $("#treegrid").treegrid({
		  url : "${ctx }/system/dictionary/list.do"
	   });
	};
</script>

</head>
<body class="easyui-layout" >
<div id="tb" style="padding: 3px; height: auto">
		<a href="javascript:void(0)" id="dictionary_refresh_btn" onclick="refresh();" class="easyui-linkbutton" data-options="iconCls:'icon-reload',plain:true">刷新</a>
	</div>
<div region="center" border="false" >
	   <table id="treegrid"  class="easyui-treegrid" style="width:700px;height:300px"
            data-options="
                url: '${ctx }/system/dictionary/list.do',
                rownumbers: true,
                fit:true,
                toolbar:'#tb',
                collapsible: false,
                pagination: false,
                idField: 'id',
                treeField: 'name',
                onContextMenu: onContextMenu,
                onBeforeLoad:function(row,param){
                  if (row){
                    $(this).treegrid('options').url = '${ctx }/system/dictionary/list.do?node='+row.id;
                  }
               }
            ">
        <thead>
            <tr>
                <th field="id" width="10" data-options="hidden:true">id</th>
                <th field="name" width="350">名称</th>
                <th field="descn" width="400" >备注</th>
            </tr>
        </thead>
    </table>
</div>

<div style="display: none;padding: 20px" id="dictionary_edit_box" />

   <div id="leafmenu" class="easyui-menu" style="width:100px;">
    <div onClick="edit();" data-options="iconCls:'icon-edit'">编辑</div>
    <div onClick="del();" data-options="iconCls:'icon-cancel'">删除</div>
   </div>

   <div id="parentmenu" class="easyui-menu" style="width:100px;">
    <div onClick="create();" data-options="iconCls:'icon-new'">新建子节点</div>
    <div onClick="edit();" data-options="iconCls:'icon-edit'">编辑</div>
    <div onClick="del();" data-options="iconCls:'icon-cancel'">删除</div>
    </div>
</div>
</body>
</html>