<%@ page contentType="text/html;charset=UTF-8"%>
<link href="${ctx}/styles/manager/print.css" type="text/css" rel="stylesheet" media="print">
<script language="javascript">
function doClose() {
	window.close();
}

function printSelf() {
	<%
	String print = request.getParameter("print");
	%>
	var printInstruction = "<%=print%>";
	if(printInstruction=="print") {
		print();
		window.close();
	} else if(printInstruction=="view") {
		print_view();
		window.close();
	} else if(printInstruction=="config") {
		print_config();
		window.close();
	}
}

function doPrint(action) {
   
var w,h,t,l;
	try{w = document.body.clientWidth;}catch(e){}
	try{h = document.body.clientHeight;}catch(e){}
	try{t =  (screen.availHeight-h)/2;}catch(e){}
	try{l =  (screen.availWidth-w)/2;}catch(e){}
	w = 1024;
	h=768;
	var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l;
	s += ', toolbar=no, scrollbars=no, menubar=no, location=no, resizable=no';
	window.open(window.location.href+"?&print="+action, "_blank", s);
}


function print_config() {
	wb.execwb(8, 1);
}
function print() {
	if (confirm("确定打印吗？")) {
		wb.execwb(6, 6);
	}
}
function print_view() {
	wb.execwb(7, 1);
}

</script>
<OBJECT classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height="0" id="wb" name="wb" width="0"></OBJECT>
