<%@ page contentType="text/html;charset=UTF-8"%>
<%-- Error Messages --%>
<logic:messagesPresent>
	<div class="error" style="border: 2px solid red;margin-bottom: 30px;color: red;margin: 3px;padding: 2px;">
		<html:messages id="error">
			${error}<br/>
		</html:messages>
	</div>
</logic:messagesPresent>

<%-- Success Messages --%>
<logic:messagesPresent message="true">

	<div id="message" style="border: 1px solid black;padding: 4px;background-color: #fff;position: absolute; Z-INDEX: 999;float: left;margin-left: 3px;">
		<html:messages id="message" message="true">
			${message}<br/>
		</html:messages>
	</div>

	 
</logic:messagesPresent>

<script type="text/javascript">
	setTimeout("yinchang()",5000);
	
	function yinchang(){
	document.getElementById("message").style.display="none";
	 
	}
	</script>


<%-- 20121219 解决返回问题临时放到这里 --%>
<c:if test="${not empty lastedlisturl}">
	<script>
		window.parent.parent.frames["topFrame"].document.getElementById("lastedlisturl").value = "${lastedlisturl}";
	</script>
</c:if>

