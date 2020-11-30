<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.Bean.model.*" import="java.util.ArrayList"
	import="java.util.List" import="jsp.DB.method.*"
	import="jsp.Bean.model.*"
	import="java.text.SimpleDateFormat" import="java.util.Date"%>
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
			script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
		}
		String sessionID = session.getAttribute("sessionID").toString();
		String sessionName = session.getAttribute("sessionName").toString();
		String sum = request.getParameter("sum");
		String team = request.getParameter("team");
		int semi = Integer.parseInt(request.getParameter("eq_semi"));
		int year = Integer.parseInt(request.getParameter("year"));
		ExpendDAO expendDao = new ExpendDAO();
		String lc_semi = "";
		if(semi == 0){
			lc_semi = "상반기";
		} else{
			lc_semi = "하반기";
		}	
		if(request.getParameterValues("name") == null){
			expendDao.drop_EQpurchaseTable(team, year, semi);
			script.print("<script> alert('장비 구매 내역이 저장 되었습니다.'); location.href = 'expense_dp.jsp?team="+team+"&year="+year+"&semi="+lc_semi+"&sum="+sum+"'</script>");
		} else{
			String [] name = request.getParameterValues("name");
			String [] date = request.getParameterValues("date");
			String [] cost = request.getParameterValues("cost");
			String [] count = request.getParameterValues("count");

			int cnt = name.length; 
			

			
			expendDao.drop_EQpurchaseTable(team, year, semi);
			expendDao.save_eqPurchase(team, name, date, cost, count, year, semi, cnt);
			script.print("<script> alert('장비 구매 내역이 저장 되었습니다.'); location.href = 'expense_dp.jsp?team="+team+"&year="+year+"&semi="+lc_semi+"&sum="+sum+"'</script>");
		}
	%>
</body>
</html>