<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<html>
	<head>
		<title>信息</title>
		<style type="text/css">
<!--
body {
	margin:0 auto;
	padding:0;
	font:bold 16px  "宋体",Arial;
	background: #fff;
	text-align: center;
}
* { 
	margin:0; 
	padding:0;
	list-style:none;
}
.warn {
    width:498px;
	height:398px;
	border:1px solid #90dff1;
    background:url(${ctx}/images/warning.jpg) no-repeat 0 0;
    text-align: left;
    margin-top: 100px;
}
.warn p{
    width:340px;
	height:auto;
	line-height:22px;
    margin:150px 0 0 50px;
}

-->
</style>
	</head>
	<body>
			<div class="warn">
				<p>
					<%-- Error Messages --%>
					<logic:messagesPresent>
						<html:messages id="error"><font color="red">${error}</font>><br />
						</html:messages>
					</logic:messagesPresent>

					<%-- Success Messages --%>
					<logic:messagesPresent message="true">
						<html:messages id="message" message="true"><font color="#003399">${message}</font><br />
						</html:messages>
					</logic:messagesPresent>

					<logic:present name="MESSAGE"><font color="#003399">${MESSAGE}</font><br />
					</logic:present>
				</p>
			</div>
	</body>
</html>

