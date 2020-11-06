<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.Bean.model.*" import="java.util.ArrayList"
	import="java.util.List" import="jsp.DB.method.*"
	import="jsp.Bean.model.*"
	import="java.text.SimpleDateFormat" import="java.util.Date"%>
<!DOCTYPE html>
<html lang="kor">

<head>
<%
		PrintWriter script =  response.getWriter();
		if (session.getAttribute("sessionID") == null){
			script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
		}
		
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		int nowYear = Integer.parseInt(sdf.format(now));
		
		MemberDAO memberDao = new MemberDAO();
		ProjectDAO projectDao = new ProjectDAO();
		
		ArrayList<ProjectBean> projectList = projectDao.getProjectList(nowYear);
		ArrayList<careerSummary_Bean> careerSmList = projectDao.getCareerSummary();
	%>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Sure FVMS - Meeting_view</title>

<!-- Custom fonts for this template-->
<link href="../../vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="../../https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="../../css/sb-admin-2.min.css" rel="stylesheet">

</head>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
	
<script>
</script>

<style>
</style>

<body id="page-top">
<%=nowYear %>
</body>

</html>