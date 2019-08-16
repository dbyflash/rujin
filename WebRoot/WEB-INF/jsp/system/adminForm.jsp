<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>

<script type="text/javascript">
  var id='${bean.id}';
     
  $(function(){
    if(id!=''){//修改
     $("#loginname").attr("readonly","readonly");
    }
  
  });
   
   
//保存
function save(){
     $target=$("#role_list_box");
     var rows = $target.datagrid('getSelections');
     if(rows.length==0){
        rightBottom("请选择角色后再提交");
        return;
     }
     var roleidArray=new Array();
     for(var i=0;i<rows.length;i++){
        roleidArray.push(rows[i].id);
     }
    var roleids=roleidArray.join(",");
   
    $("#roleids").val(roleids);
    if($("#admin_edit_form").form('validate')){//验证
    
    	var url = "${ctx }/system/admin/save.do";
    	var data=$("#admin_edit_form").serialize();
					$.post(url,data,function(msg){
						if(msg.statusCode==200){
				             $("#admin_list_box").datagrid("reload");
					         $("#admin_edit_box").dialog("close");
						}
						rightBottom(msg.message);
					},'json');
    }
}
//检查用户名是否重复
function checkAdmin(){
 var cid=$("#id").val();
 
 var loginname=$("#loginname").val();
 var data="id="+cid+"&loginname="+loginname;
 $.post("${ctx }/system/admin/checkAdmin.do",data,function(msg){
				if (msg.message=="ok") {
			      rightBottom("用户名可用！");
				}else{
				 rightBottom("用户名已存在！");
				 $("#loginname").val("");
				}
			},"json"); 

}

var roleids='${roleids}';
 //编辑状态时选中默认的角色 在datagrid onLoadSuccess后中调用
function selectRoles(){
 if(roleids==""){
   return;
 }
 $target=$("#role_list_box");
 var strs= new Array(); //定义一数组
 strs=roleids.split(","); //字符分割    
 var rows = $target.datagrid('getRows');
 for(var i=0;i<rows.length;i++){
   for(var j=0;j<strs.length;j++){
     if(rows[i].id==strs[j]){
        var rowindex = $target.datagrid('getRowIndex',rows[i]);
        $target.datagrid("selectRow",rowindex);
        break;
     }
   }
 }
 
 }
</script>
<form id="admin_edit_form">
 <div class="easyui-layout" style="width:765px;height:400px;margin-top: 0px;margin-left: 0px;" >
        <div data-options="region:'north'" style="height:70px">
	   <table class="table">
		<tr>
			<th>登录名称：</th>
			<td> <input type="hidden" id="roleids" name="roleids" value="${roleids }"/>
				<input type="text" name="loginname" id="loginname" size="20" class="easyui-validatebox" value="${bean.loginname}" data-options="required:true" onchange="checkAdmin();"/>
				<input type="hidden"  id="id" name="id" value="${bean.id}"/>
		    </td>
		    <th>名　　称：</th>
			<td>
				<input type="text" name="name" id="name" size="20" class="easyui-validatebox" value="${bean.name}" data-options="required:true" />
		    </td>
		</tr>
		<tr>
			<th>联系电话：</th>
			<td>
				<input type="text" name="tel" id="tel" size="20" class="easyui-validatebox" value="${bean.tel}"  />
		    </td>
		    <th>帐号状态：</th>
			<td>
				 <select id="isforbidden" name="isforbidden" >
					<option value="0" <c:if test='${bean.isforbidden eq 0 }'>selected</c:if>  >开通</option>
					<option value="1" <c:if test='${bean.isforbidden eq 1 }'>selected</c:if>  >禁用</option>
				   </select>
		    </td>
		</tr>
	</table>
        
        </div>
        <div data-options="region:'center',title:'拥有角色',iconCls:'icon-ok'">
         <table id="role_list_box"  class="easyui-datagrid"  
	      data-options="striped:true,fit:true, rownumbers:true,border:false,pagination:false,singleSelect:false,
	      url:'${ctx }/system/role/getAllRoles.do',onLoadSuccess:selectRoles" >
		                  <thead>
			               <tr>
			                 <th data-options="field:'ck',checkbox:true"></th>
				             <th data-options="field:'id',hidden:true">ID</th>
				             <th data-options="field:'name',width:100,halign:'center',align:'left'">名称</th>
				             <th data-options="field:'descn',width:180,halign:'center',align:'left'">描述</th>
			              </tr>
		                </thead>
	                  </table>
        </div>
    </div>
      <%@ include file="/commons/forminclude.jsp"%>
 </form>