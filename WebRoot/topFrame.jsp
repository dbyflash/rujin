<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="${ctx}/css/style.css">
<link rel="stylesheet" type="text/css" href="${ctx}/layer/skin/default/layer.css">
<link rel="stylesheet" type="text/css" href="${ctx}/layer/skin/default/layui.css">
<title></title>
<script src="${ctx}/js/jquery-1.8.0.min.js" type="text/javascript"></script>
<script src="${ctx}/layer/layer.js" type="text/javascript"></script>

<script type="text/javascript">
 $(function(){
    var toplist=JSON.parse('${toplist}');
    for(var i=0;i<toplist.length;i++){
      if(i==0){
        $("#nav").append(" <li><a href=\"#\" p_id=\""+toplist[i].id+"\" class=\"selected\"><img src=\""+toplist[i].options+"\"  /><h2>"+toplist[i].name+"</h2></a></li>");
      }else{
        $("#nav").append(" <li><a href=\"#\" p_id=\""+toplist[i].id+"\"><img src=\""+toplist[i].options+"\"  /><h2>"+toplist[i].name+"</h2></a></li>");
      }
    }
    var myUl = document.getElementById("nav");//一个节点
	var myLi = myUl.getElementsByTagName("li");    //数组
    setTimeout(function(){
        var p_id=myLi[0].getElementsByTagName("a")[0].attributes["p_id"].nodeValue; 
	    self.parent.frames['leftFrame'].refreshMenu(p_id);
	},500);
	      
	//顶部导航切换
	$(".nav li a").click(function(){
		$(".nav li a.selected").removeClass("selected")
		$(this).addClass("selected");
		self.parent.frames['leftFrame'].refreshMenu($(this).attr("p_id"));
	})	
 })
</script>
     
</head>
<body style="background:url(images/topbg.gif) repeat-x;">

    <div class="topleft">
    <a href="main.html" target="_parent"><img src="images/logo.png" title="系统首页" /></a>
    </div>
        
    <ul id="nav" class="nav"></ul>
            
    <div class="topright">    
    <ul>
    <li><span><img src="images/help.png" title="帮助"  class="helpimg"/></span><a href="#">帮助</a></li>
    <li><a href="#">关于</a></li>
    <li><a href="#" onclick="parent.parent.logout();">退出</a></li>
    </ul>
     
    <div class="user">
    <span>admin</span>
    <i>消息</i>
    <b>5</b>
    </div>    
    
    </div>
</body>

</html>
