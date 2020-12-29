<%@ page import="org.apache.catalina.valves.rewrite.RewriteCond"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.Bean.model.*" import="jsp.DB.method.*"
	import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<%	
	PrintWriter script =  response.getWriter();
	if (session.getAttribute("sessionID") == null){
		script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
	}
	int permission = Integer.parseInt(session.getAttribute("permission").toString());
	if(permission > 2){
		script.print("<script> alert('접근 권한이 없습니다.'); history.back(); </script>");
	}

	String sessionID = session.getAttribute("sessionID").toString();
	String sessionName = session.getAttribute("sessionName").toString();
	
	String id = request.getParameter("id");
	int year = Integer.parseInt(request.getParameter("year"));
	MemberDAO memberDao = new MemberDAO();
	MemberBean memInfo = memberDao.returnMember(id);
	String Name = memInfo.getNAME();
	String Team = memInfo.getTEAM();
	String Part = "";
	if(Team.equals("미래차검증전략실") && !(memInfo.getPART().equals("슈어소프트테크"))){
		Part = "(" + memInfo.getPART() + ")";
	}
	SchDAO schDao = new SchDAO();
	ArrayList<CareerBean> careerList = schDao.getCareer_id(id);
	
%>
<head>
<meta charset="UTF-8">
<title><%=Team%> <%=Name%> <%=Part%> 프로젝트 수행이력</title>
</head>

<style>
	#dataTable{
		width: 100%;
		border: 1px solid;
    	border-collapse: collapse;
	}
	th, td{
		padding : 10px;
		border: 1px solid;
	}
</style>

<body>
<h3 style="text-align: center;"><%=Team%> <%=Name%><%=Part%> 프로젝트 수행이력</h3>
<div>
	<table id="dataTable">
		<thead id="Theader">
			<tr>
				<th style="width:65%;">프로젝트명</th>
				<th style="width:15%;">시작날짜</th>
				<th style="width:15%;">종료날짜</th>
				<th style="width:5%;">PM</th>
			</tr>
		</thead>
		<tbody id="Tcontent">
			<%for(int i = 0; i<careerList.size(); i++){ 
				String pmCheck = "X";
				if(careerList.get(i).getPm().equals("1")){
					pmCheck = "O";
				}
				
				if(careerList.get(i).getProjectState().equals("6.진행중")){%>
					<tr style="background-color:greenyellow;">
						<td><a href="../project/project_update.jsp?no=<%=careerList.get(i).getProjectNo()%>&year=<%=year%>"><%=careerList.get(i).getProjectName() %></a></td>
						<td style="text-align:center;"><%=careerList.get(i).getStart() %></td>
						<td style="text-align:center;"><%=careerList.get(i).getEnd() %></td>
						<td style="text-align:center;"><%=pmCheck %></td>
					</tr>
				<%}else{%>
					<tr>
						<td><a href="../project/project_update.jsp?no=<%=careerList.get(i).getProjectNo()%>&year=<%=year%>"><%=careerList.get(i).getProjectName() %></a></td>
						<td style="text-align:center;"><%=careerList.get(i).getStart() %></td>
						<td style="text-align:center;"><%=careerList.get(i).getEnd() %></td>
						<td style="text-align:center;"><%=pmCheck %></td>
					</tr>
				<%}}%>
		</tbody>
	</table>
</div>
</body>
</html>