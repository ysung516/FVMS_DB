<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.io.PrintWriter"
    import = "jsp.DB.method.*"
    import = "jsp.Bean.model.*"
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		PrintWriter script =  response.getWriter();
		if (session.getAttribute("sessionID") == null){
			script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../../html/login.html' </script>");
		}
		String sessionID = session.getAttribute("sessionID").toString();
		String sessionName = session.getAttribute("sessionName").toString();
		int no = Integer.parseInt(request.getParameter("no"));
		String WeekPlan = request.getParameter("WeekPlan");
		String WeekPro = request.getParameter("WeekPro");
		String NextPlan = request.getParameter("NextPlan");
		String specialty = request.getParameter("specialty");
		String note = request.getParameter("note");
		
		
		ReportDAO reportDao = new ReportDAO();
		ReportBean report = reportDao.getReportBean(no);
		
		
		if(reportDao.updateReport(no, WeekPlan, WeekPro, NextPlan,  specialty, note) == 1){
			script.print("<script> alert('보고서가 수정되었습니다.'); location.href = 'report.jsp'; </script>");
		}
		else{
			script.print("<script> alert('보고서 수정에 실패했습니다.'); history.back(); </script>");
		}
	%>
</body>
</html>