<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<c:if test="${empty ADMININFO}">
	<c:redirect url="logout.jsp" />
</c:if>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Demo</title>
		<link rel="stylesheet" type="text/css" href="${ctx}/layer/skin/default/layer.css"/>
		<link rel="stylesheet" type="text/css" href="${ctx}/layer/skin/default/layui.css"/>

		<script src="${ctx}/js/jquery-1.8.0.min.js" type="text/javascript"></script>
		<script src="${ctx}/layer/layer.js" type="text/javascript"></script>
		<style >
		html,body{
		    margin:0; padding:0;
			height:100%;
		}
		</style>
		<script type="text/javascript">
       
function logout(){

 layer.msg('玩命提示中'); 
	var title = "您确定要退出吗?";
			layer.confirm(title, {
			     btn: ['退出','取消'] //按钮
			}, function(index, layero){
			    window.location.href="${ctx}/logout.jsp";
			}, function(index, layero){
			  layer.close(index);
			});
}

</script>
	</head>
	<body scroll="no">
	<!-- myiframe -->
		<iframe src="main.jsp" id="myiframe" scrolling="no" frameborder="0" style="width: 100%;height: 99%;" ></iframe>
	</body>
</html>
