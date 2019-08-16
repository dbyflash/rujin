<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%
	 /**
	 * 天气预报小工具
	 *
	 * 0:sina (默认)
	 * 1:265
	 * 2:yahoo
	 * 3:163
	 */

	String typeStr = request.getParameter("type");
	int type = 0;
	try {
		type = Integer.parseInt(typeStr);
	} catch (Exception e) {
		type = 0;
	}
%>
<%
if (type == 0) {
%>
<iframe id="weather_sina" name="sina" width="150" height="20" frameborder="0" marginheight="0" marginwidth="0" scrolling="no" src="http://news.sina.com.cn/iframe/2010/0820/564.html"></iframe>
<%
} else if (type == 1) {
%>
<iframe id="weather_265" name="265"
	src="http://weather.265.com/weather.htm" width="168" height="50"
	frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>
<%
} else if (type == 2) {
%>
<iframe id="weather_yahoo" name="yahoo"
	src="http://weather.cn.yahoo.com/cframe.html" width="468" height="30"
	frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>
<%
} else if (type == 3) {
%>
<iframe id="weather_163" name="163" src="${ctx}/commons/weather_163.jsp"
	width="200" height="20" frameborder="0" marginwidth="0"
	marginheight="0" scrolling="no"></iframe>
<%
}
%>
