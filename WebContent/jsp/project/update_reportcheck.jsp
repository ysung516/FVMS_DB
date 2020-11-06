<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="jsp.Bean.model.*"
	import="java.io.PrintWriter" 
	import="jsp.DB.method.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<!-- Custom fonts for this template-->
<link href="../../vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="../../css/sb-admin-2.min.css" rel="stylesheet">
</head>

<%
	request.setCharacterEncoding("UTF-8");
	
	PrintWriter script =  response.getWriter();
	if (session.getAttribute("sessionID") == null){
		script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
	}
	
	int projectNo = Integer.parseInt(request.getParameter("no"));
	String projectName = request.getParameter("name");
	int check = Integer.parseInt(request.getParameter("check"));
	int year = Integer.parseInt(request.getParameter("year"));
	
	String attr = request.getParameter("attr");
	
	ProjectDAO projectDao = new ProjectDAO();	
%>

<style>
	body{
		text-align:center;
	}
	#submit{
		margin:10px;
	}
	#name{
		font-size:18px;
		word-break:break-all;
	}
</style>

<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script>
function check_ori(){
	var check = <%=check%>;
	$("input:radio[name='chk_info']:radio[value='"+check+"']").attr('checked', true);
}

$(document).ready(function(){
	check_ori();	
});
</script>

<body>
	<br>
	<p id="name"><%=projectName %></p>
	<p><%=attr %> 사용 여부 수정</p>
	<form method="post" action="update_reportcheck_pro.jsp" target="project.jsp">
	<input type="hidden" name="no" value="<%=projectNo %>">
	<input type="hidden" name="attr" value="<%=attr %>">
	<input type="hidden" name="year" value="<%=year %>">
	<label><input type="radio" name="chk_info" value="1">ON</label>
	<label><input type="radio" name="chk_info" value="0">OFF</label>
	<br>
	<input type="submit" onclick="window.close()" name="submit" id="submit" value="수정">
	</form>
</body>
</html>