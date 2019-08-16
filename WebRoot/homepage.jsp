<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<%@ include file="/commons/meta.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="http://libs.baidu.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://www.jq22.com/jquery/font-awesome.4.6.0.css"/>
<link rel="stylesheet" href="${ctx}/js/drag/dist/gridstack.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/js/drag/css/default.css">
<style type="text/css">
       .grid-stack {
           background: lightgoldenrodyellow;
       }

       .grid-stack-item-content {
           color: #2c3e50;
           text-align: center;
           background-color: #18bc9c;
       }
       
       .deleteme{
         width:16px;
         height:16px;
         background:url("${ctx}/js/drag/fonts/delete.png");
       }
</style>
<!--[if IE]>
	<script src="http://libs.baidu.com/html5shiv/3.7/html5shiv.min.js"></script>
<![endif]-->
<title></title>
    
<!-- <script src="${ctx}/js/jquery-1.8.0.min.js" type="text/javascript"></script> -->
<!-- <script src="http://www.jq22.com/jquery/1.11.1/jquery.min.js"></script> -->
<script src="http://libs.baidu.com/jqueryui/1.10.4/jquery-ui.min.js"></script>
<script src="http://libs.baidu.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="${ctx}/js/drag/js/lodash.min.js"></script>
<script src="${ctx}/js/drag/dist/gridstack.js"></script>
<script type="text/javascript">

        var moveid="";//移动中的节点id
        $(function () {
        	
        	var list=JSON.parse('${list}');
           	for(var i=0;i<list.length;i++){
           		 $('#'+list[i].domid).attr('data-gs-x',list[i].positionx);
           		 $('#'+list[i].domid).attr('data-gs-y',list[i].positiony);
           		 $('#'+list[i].domid).attr('data-gs-width',list[i].domwidth);
           		 $('#'+list[i].domid).attr('data-gs-height',list[i].domheight);
              }
           	
            var options = {
                float: true
            };
            $('.grid-stack').gridstack(options);

            new function () {
                this.items = [
                    {x: 0, y: 0, width: 2, height: 2},
                    {x: 3, y: 1, width: 1, height: 2},
                    {x: 4, y: 1, width: 1, height: 1},
                    {x: 2, y: 3, width: 3, height: 1},
                    {x: 2, y: 5, width: 1, height: 1}
                ];
                this.grid = $('.grid-stack').data('gridstack');

                this.add_new_widget = function () {
                    var node = this.items.pop() || {
                                x: 12 * Math.random(),
                                y: 5 * Math.random(),
                                width: 1 + 3 * Math.random(),
                                height: 1 + 3 * Math.random()
                            };
                    this.grid.add_widget($('<div id="ccc"><div class="grid-stack-item-content" /><div/>'),
                        node.x, node.y, node.width, node.height);
                }.bind(this);

                $('#add-new-widget').click(this.add_new_widget);
            };
        });
        
        //保存主动移动的dom
        function save( domid, x, y, width, height){
        	var url="${ctx }/manager/position/save.do?domid="+domid+"&positionx="+x+"&positiony="+y+"&domwidth="+width+"&domheight="+height;
        	$.post(url,function(msg){
        		rightBottom(msg.message);
        	},'json');
        }
        //保存被挤走的dom
        function askSave( domid, x, y, width, height){
        	if(domid!=moveid){
        		var url="${ctx }/manager/position/save.do?domid="+domid+"&positionx="+x+"&positiony="+y+"&domwidth="+width+"&domheight="+height;
            	$.post(url,function(msg){
            		rightBottom(msg.message);
            	},'json');
        	}
        }
        
        function movingDom(id){
        	moveid=id;
        }
        //显示删除按钮
        function showDelete(obj){
        	$($(obj).children()[0]).children()[0].style.display="";
        }
        // 隐藏删除按钮
        function hideDelete(obj){
        	$($(obj).children()[0]).children()[0].style.display="none";
        }
        //删除dom
        function deleteme(obj){
        	$('.grid-stack').data('gridstack').remove_widget(obj.parentNode.parentNode);
        }
    </script>
</head>
<body>
  <div class="jq22-container">
		<div class="jq22-content ">
			<div class="container-fluid">
		        <h1>Float grid demo</h1>

		        <div>
		            <a class="btn btn-default" id="add-new-widget" href="#">Add Widget</a>
		        </div>

		        <br/>

		        <div class="grid-stack" style="height: 500px">
		        
		          <div id="aaa" data-gs-x="0" data-gs-y="1" data-gs-width="1" data-gs-height="1" class="grid-stack-item ui-draggable ui-resizable ui-resizable-autohide" onmouseover = "showDelete(this)" onmouseout="hideDelete(this)">
		            <div class="grid-stack-item-content">
		              <div class="deleteme" style="z-index: 90;display: none;position: absolute;right:0 " onclick="deleteme(this)"></div>
		                                                哈哈哈哈
		            </div>
		            <div></div>
		          </div>
		          
<!-- 		          <div id="bbb" data-gs-x="1" data-gs-y="0" data-gs-width="3" data-gs-height="1" class="grid-stack-item ui-draggable ui-resizable ui-resizable-autohide"><div class="grid-stack-item-content"></div><div></div><div class="ui-resizable-handle ui-resizable-se ui-icon ui-icon-gripsmall-diagonal-se" style="z-index: 90; display: none;"></div></div> -->
		        </div>
		    </div>
	    </div>
		
	</div>
</body>
</html>
