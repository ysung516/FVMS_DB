<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="jsp.DB.method.*"
	import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	
		int num = Integer.parseInt(request.getParameter("num"));
		String AmPlace = request.getParameter("amPlaceSel");
		
		String AMother = "미입력";
		String PMother = "미입력";
		
		if(!(request.getParameter("amselboxDirect") == "")){
			AMother = request.getParameter("amselboxDirect");	
		}
		
		if(!(request.getParameter("pmselboxDirect") == "")){
			PMother = request.getParameter("pmselboxDirect");	
		}
		
		
		if(AmPlace != null && AmPlace.equals("기타")){
			AmPlace = AMother;
		}
		
		String PmPlace = request.getParameter("pmPlaceSel");
		if(PmPlace != null && PmPlace.equals("기타")){
			PmPlace = PMother;
		}
		String date = request.getParameter("DATE");
		PrintWriter script =  response.getWriter();
		MSC_DAO method = new MSC_DAO();
		
		if(method.update_MSC(num, AmPlace, PmPlace, date) == 1){
			 script.print("<script> alert('일정이 수정되었습니다.'); location.href = 'manager_schedule.jsp'; </script>");
			
		} else script.print("<script> alert('수정되지 않았습니다.'); history.back(); </script>");
		
	
	%>
</body>
</html>