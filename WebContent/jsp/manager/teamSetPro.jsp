<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.PrintWriter"
    import="jsp.Bean.model.*" import="jsp.DB.method.*"
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>file upload</title>
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
	
	String year = request.getParameter("nowYear");
	int count = Integer.parseInt(request.getParameter("count"));
	String [] teamNum = new String[count-1];
	String [] teamName = new String[count-1];
	String [] fh_order = new String[count-1];
	String [] fh_sale = new String[count-1];
	String [] sh_order = new String[count-1];
	String [] sh_sale = new String[count-1];
	
	for(int i = 0; i < count; i++){
		teamNum = request.getParameterValues("teamNum");
		teamName = request.getParameterValues("teamName");
		fh_order = request.getParameterValues("fh_order");
		fh_sale = request.getParameterValues("fh_sale");
		sh_order = request.getParameterValues("sh_order");
		sh_sale = request.getParameterValues("sh_sale");
	}
	
	ManagerDAO managerDao = new ManagerDAO();
	int rs = managerDao.teamSet(year, teamNum, teamName, fh_order, fh_sale, sh_order, sh_sale, count);
	
	if(rs == count){
		script.print("<script> alert('팀 정보가 저장 되었습니다.'); location.href = 'teamSet.jsp?year="+year+"'</script>");
	}else{
		script.print("<script> alert('저장 실패!!'); history.back();</script>");
	}
%>

</body>
</html>