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
    <meta http-equiv="X-UA-Compatible" content="chrome=1"/>
    <title>系统</title>
    <link rel="stylesheet" href="${ctx }/login/login/css/css.css" />
    <script type="text/javascript" src="${ctx }/login/login/js/jquery.min.js" ></script>

    <script type="text/javascript">
<%--        var sUserAgent = navigator.userAgent,--%>
<%--        mobileAgents = ['Windows CE', 'iPod', 'Symbian', 'iPhone', 'BlackBerry', 'Android', 'Windows Phone'];--%>
<%--        if ((sUserAgent.match(/iPad/i))) {--%>
<%--            location.href = '${ctx}/login/login/MobileIndex.htm';--%>
<%--        }--%>
<%--        for (var i = 0, len = mobileAgents.length; i < len; i++) {--%>
<%--            if (sUserAgent.indexOf(mobileAgents[i]) !== -1) {--%>
<%--                location.href = '${ctx}/login/login/MobileIndex.htm';--%>
<%--                break;--%>
<%--            }--%>
<%--        }--%>
<%--        var ads = [];--%>
    </script>
    
    <script type="text/javascript">

        $(function () {
            var _height = $(window).height();
            $(".in-backspace").css("height", _height - "680" + "px");
            $("#nickLogin").click();
            $("#loginname").focus();
          
            $("#loginname").keydown(function (event) {
                if (event.keyCode == 13) {
                   $("#password").focus();
                }
            });
            
            $("#password").keydown(function (event) {
                if (event.keyCode == 13) {
                    login();
                }
            });
        });

      function login(){
    	if(!$("#loginname").val()){
			$("#tiptxt").html("请输入用户名！");
			$("#loginname").focus();
		}else if(!$("#password").val()){
		   $("#tiptxt").html("请输入密码！");
			$("#password").focus();
		}else{
			var data = "loginname="+encodeURI($("#loginname").val())+"&password="+encodeURI($("#password").val());
			$.post("${ctx }/login.do",data,function(json){
				if (json.statusCode == 200) {
				    $('#tiptxt').css("color","green");
				    $("#tiptxt").html(json.message);
				    setTimeout(function(){
				     window.location.href = "${ctx }/index.jsp";
				    },500);
				} else {
					$("#tiptxt").html(json.message);
				}
			},"json");
		 }
      
      }
      
   
    </script>
    <!--[if IE 6]>
        <script type="text/javascript" src="${ctx }/login/login/js/DD_belatedPNG.js" ></script>
        <script type="text/javascript">
            DD_belatedPNG.fix('div,a');
        </script>
    <![endif]-->

</head>
<body>
    <div class="head">
        <div class="w980 mauto"><a class="logo"></a></div>
    </div>
    <div class="main">
        <div class="w980 mauto pr">
<%--            <div class="tips"><span>技术支持</span> &nbsp;&nbsp;&nbsp;&nbsp;电话：</div>--%>
            <div class="ad"></div>
            <div style="clear: both;"></div>
            <div class="login">
                <ul class="nav">
                    <li class="left-01 curr" id="nickLogin"><span style="margin-left:30px;">用户登录</span></li>
                </ul>
                <ul class="guest" style="clear: both">
                    <li style="display: block">
                        <div class="name label" style="padding-left: 20px;">
                               用户名：<input class="input code account" id="loginname" placeholder="请输入用户名" type="text" tabindex="1" />
                        </div>
                        <div class="password label" style="margin-top: 20px;padding-left: 20px;">
                            &nbsp; &nbsp;密码：<input class="input psd" id="password" placeholder="请输入密码" type="password" tabindex="2" />
                        </div>
                         <div style="margin-top: 20px;"><span style="color: red;margin-left: 30px;" id="tiptxt" ></span><div>
                    </li>
                    
                </ul>
                
                <input class="loginbtn" type="button" onClick="login()" value="登 录" />
            </div>
        </div>
        <div style="clear: both"></div>
    </div>
    <div style="clear: both"></div>
    <div class="in-backspace"></div>
    <div class="footer">
        <div class="w980 mauto textcenter h50">
            © 版权所有   2015<br />
        </div>
    </div>

</body>
</html>
