<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%response.addHeader("pragma", "no-cache");
response.addHeader("cache-control", "no-cache,must-revalidate");
response.addHeader("expires", "0");%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
 