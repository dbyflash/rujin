<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="${ctx}/css/style.css">
<script src="${ctx}/js/jquery-1.8.0.min.js" type="text/javascript"></script>

<script type="text/javascript">
$(function(){	
	
	$('.title').click(function(){
		var $ul = $(this).next('ul');
		$('dd').find('ul').slideUp();
		if($ul.is(':visible')){
			$(this).next('ul').slideUp();
		}else{
			$(this).next('ul').slideDown();
		}
	});
})	

function refreshMenu(p_id){
        var url="${ctx}/leftmenu.do?p_id="+p_id;
        $.post(url,function(data){
        
        var html="<ul class=\"menuson\">";
		for(var i=0;i<data.length;i++){
		      html+="<li id='"+data[i].id+"' url='"+data[i].resstring+"'><cite></cite><a href=\"#\" >"+data[i].name+"</a><i></i></li>";
		}
		html+="</ul>";
		$("#menu").html(html);
		// $("#menu").css("height",$(window).height()-237);    
		//导航切换
		$(".menuson li").click(function(){
			$(".menuson li.active").removeClass("active")
			$(this).addClass("active");
			parent.document.getElementById("mainFrame").src="${ctx}/"+$(this).attr("url");
		});
	},'json');
 }
        
</script>

    
</head>

<body style="background:#f0f9fd;">
	<div class="lefttop"><span></span>通讯录</div>
    
    <dl class="leftmenu">
        
    <dd id="menu">
    	
    </dd>
        
    
    
    </dl>
</body>
</html>
