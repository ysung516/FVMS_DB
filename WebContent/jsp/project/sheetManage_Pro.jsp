<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.PrintWriter"
    import="jsp.Bean.model.*" import="jsp.DB.method.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sheetManage</title>

<%
request.setCharacterEncoding("UTF-8");
PrintWriter script =  response.getWriter();
if (session.getAttribute("sessionID") == null){
	script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
}
String sessionID = session.getAttribute("sessionID").toString();
String sessionName = session.getAttribute("sessionName").toString();

int cnt = Integer.parseInt(request.getParameter("count"));

String[] year = new String[cnt];
String[] sheetName = new String[cnt]; 

for(int i=0; i<cnt; i++){
	year = request.getParameterValues("year");
	sheetName = request.getParameterValues("sheetName");
}

ProjectDAO projectDAO = new ProjectDAO();
int rs = projectDAO.insertSpreadSheet(year, sheetName, cnt);

if(rs == cnt){
	script.print("<script language='javascript'> alert('팀 정보가 저장되었습니다.'); window.open('','_self').close();</script>");
}else{
	script.print("<script> alert('저장 실패!!'); history.back();</script>");
}
%>

</head>
<body>
ee
</body>
</html>