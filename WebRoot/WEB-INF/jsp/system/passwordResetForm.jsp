<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<script type="text/javascript">

  $.extend($.fn.validatebox.defaults.rules, {  
    surePwd: {
        validator: function(value, param){ 
    		var kl = $(param[0]).val();
			return kl==value;
        },  
        message: '确认密码与新密码不一致'  
    }  
});



$(function(){
  
	$("#password_edit_form").form({
		method:'post',
		url : "${ctx }/system/admin/passwordResetAction.do",
		onSubmit : function() {
				return $(this).form('validate');
		},
		success : function(msg) {
				var json = JSON.parse(msg);
				if (json.statusCode == 200) {
				       $("#admin_edit_box").dialog("close");
				}
				 
				rightBottom(json.message);
		}
	});
});
 
 
 
</script>

<form id="password_edit_form" >
	<table class="table">
	     <tr>
			<td align="right">用&nbsp;户&nbsp;名：</td>
			<td>
				<input type="text" name="title" id="title" size="20" value="${bean.loginname}" readonly="readonly" />
			   <input id="id" name="id" type="hidden" value="${bean.id }"/>
			<span style="color:blue">&nbsp;*</span></td>
		</tr>
		<tr>
			<td>
				新&nbsp;密&nbsp;码：
			</td>
			<td>
				<input type="password" name="pwd" id="pwd" size="20" class="easyui-validatebox" required="true" validType='length[1,20]'/>
			</td>
		</tr>
		<tr>
			<td>
				确认密码：
			</td>
			<td>
				<input type="password" name="repwd" id="repwd" size="20" class="easyui-validatebox" required="true" validType="surePwd['#pwd']"/>
			</td>
		</tr>
	</table>
	 <%@ include file="/commons/forminclude.jsp"%>
</form>