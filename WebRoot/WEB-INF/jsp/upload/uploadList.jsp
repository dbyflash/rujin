<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<html>
	<head>
<link rel="stylesheet" type="text/css" href="${ctx}/css/webupload/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${ctx}/css/webupload/bootstrap-theme.min.css">
<link rel="stylesheet" type="text/css" href="${ctx}/css/webupload/style.css">
<link rel="stylesheet" type="text/css" href="${ctx}/css/webupload/webuploader.css">
</head>

<script  type="text/javascript">
	 var context = "${pageContext.request.contextPath}";
</script>

<body >

<!-- 隐藏域 实时保存上传进度 -->
  <input id="jindutiao" type="hidden"/> 
  <div id="uploader" class="wu-example">
    <!--用来存放文件信息-->
    <div id="thelist" class="uploader-list"></div>
    <div class="btns">
        <div id="picker">选择文件</div>
        <button id="ctlBtn" class="btn btn-default">开始上传</button>
    </div>
</div>
  
<script src="${ctx}/js/jquery-1.8.0.min.js" type="text/javascript"></script>    
<script src="${ctx}/js/webuploader.js" type="text/javascript"></script>
<script src="${ctx}/js/getting-started.js" type="text/javascript"></script>

</body>
</html>
