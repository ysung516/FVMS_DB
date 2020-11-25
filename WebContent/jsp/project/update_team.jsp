<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="jsp.Bean.model.*"
	import="java.io.PrintWriter" 
	import="jsp.DB.method.*"
	import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>팀 수정</title>
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
	int year = Integer.parseInt(request.getParameter("year"));
	String projectName = request.getParameter("name");
	String team = request.getParameter("team");
	String what = request.getParameter("what");
	
	ProjectDAO projectDao = new ProjectDAO();
	ArrayList<String> teamList = projectDao.getTeamData(request.getParameter("year"));
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
function team_ori(){
	$("#team").val("<%=team%>").prop("selected", true);
}

$(document).ready(function(){
	team_ori();	
});
</script>

<body>
	<br>
	<p id="name"><%=projectName %></p>
	<p><%=what %>팀 수정</p>
	<form method="post" action="update_team_pro.jsp" target="project.jsp">
	<input type="hidden" name="no" value="<%=projectNo %>">
	<input type="hidden" name="year" value="<%=year%>">
	<input type="hidden" name="what" value="<%=what %>">
	<select id="team" name="team">
		<%for(int i=0; i<teamList.size(); i++){%>
   			<option value="<%=teamList.get(i)%>"><%=teamList.get(i)%></option>
		<%}%>
	</select>
	<br>
	<input type="submit" onclick="window.close()" name="submit" id="submit" value="수정">
	</form>
</body>
</html>