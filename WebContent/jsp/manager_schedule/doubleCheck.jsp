<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import ="jsp.Bean.model.MSC_Bean"
    import = "java.io.PrintWriter"
    import = "jsp.DB.method.*"
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
		MSC_DAO mscDao = new MSC_DAO();
		MSC_Bean mb = new MSC_Bean();
		PrintWriter script =  response.getWriter();
		String sessionID = session.getAttribute("sessionID").toString();
		String date = request.getParameter("date");
		int num = mscDao.returnNo(sessionID, date);
		String amPlace ="";
		String pmPlace ="";
		if(num != 0){
			mb = mscDao.getMSCList_set(num);
			amPlace = mb.getAMplace();
			pmPlace = mb.getPMplace();
		}
		
		%>
		
		<form id="GoAdd" name="GoAdd"method="post" action="manager_schedule_add.jsp">
			<input type="hidden" name = "date" value="<%=date%>"/>
		</form>
		<form id="GoUpdate" name="GoUpdate" method="post" action="manager_schedule_update.jsp">
			<input type="hidden" name = "date" value="<%=date%>"/>
			<input type="hidden" name = "num" value="<%=num%>"/>
			<input type="hidden" name = "amPlace" value="<%=amPlace%>"/>
			<input type="hidden" name = "pmPlace" value="<%=pmPlace%>"/>
		</form>
		
		<%
		if(num == 0){
			%><script>document.GoAdd.submit();</script><%
		}
		else{
			%><script>document.GoUpdate.submit();</script><%
		}
	%>

</body>
</html>