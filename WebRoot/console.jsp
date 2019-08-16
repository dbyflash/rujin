<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<meta http-equiv=Content-Type content='text/html; charset=utf-8'/>
    <meta name="viewport" content="width=device-width" />
    <meta name="renderer" content="webkit"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/css/syExtCss.css"/>
    <meta http-equiv="X-UA-Compatible" content="chrome=1"/>
    <title>系统监控</title>
     
</head>
<body>
     <h4>数据源列表</h4>
    <table id="flexme1" class="bordertable">
        <thead>
            <tr>
            <th width="300">URL</th>
            <th width="100">DbType</th>
            <th width="100">正在打开连接数</th>
            <th width="100">逻辑打开</th>
            <th width="100">逻辑关闭
            <th width="100">物理打开</th>
            <th width="100">物理关闭</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="data" items="${datasource }">
        <tr>
                <td>${data.url}</td>
                <td>${data.dbType}</td>
                <td>${data.activeCount}</td>
                <td>${data.connectCount}</td>
                <td>${data.closeCount}</td>
                <td>${data.createCount}</td>
                <td>${data.destroyCount}</td>
            </tr>
        </c:forEach>
            
    </tbody>
    </table>

</body>
</html>
