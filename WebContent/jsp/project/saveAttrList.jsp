<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="jsp.Bean.model.*"
	import="java.io.PrintWriter" 
	import="jsp.DB.method.*"
	import="java.util.ArrayList"
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
			script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
		}
		ProjectDAO projectDao = new ProjectDAO();
		String AttrText = request.getParameter("attrList");
		String saveAttr = "";
		
		for(int i=0; i<AttrText.split(" ").length; i++){
			if(!(AttrText.split(" ")[i].equals(""))){
				saveAttr += AttrText.split(" ")[i]+" ";
			}
		}
		System.out.print(saveAttr);
		if(projectDao.updateAttrList(saveAttr.trim(), session.getAttribute("sessionID").toString())==1){
			script.print("<script> alert('저장되었습니다'); location.href = 'project.jsp'; </script>");
		}else{
			script.print("<script> alert('저장 실패!!'); history.back(); </script>");
		}
	%>
</body>
</html>