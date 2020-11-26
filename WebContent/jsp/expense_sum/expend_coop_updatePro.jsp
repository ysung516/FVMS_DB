<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.DB.method.*" import="jsp.Bean.model.*"%>
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
		String [] value = request.getParameterValues("expend_coop");	
		int [] val = new int[value.length];
		ExpendDAO expendDao = new ExpendDAO();
	
		for(int i=0; i<value.length; i++){
			if(value[i].equals("")){
				script.print("<script> alert('빈 칸이 있습니다'); history.back(); </script>");
			} else{
				val[i] = Integer.parseInt(value[i]);
			}
		}
		
		int [] result = expendDao.update_CostData(val[0],val[1],val[2],val[3],"expend_coop");
		if(result[0] == 1 && result[1]==1 && result[2]==1 && result[3]==1){
			script.print("<script> alert('외주 인력 직급 단가가 변경 되었습니다. '); location.href = 'expense_sum.jsp'; </script>");
		}else{
			script.print("<script> alert('변경 실패!!'); history.back(); </script>");
		}
		
	%>
</body>
</html>