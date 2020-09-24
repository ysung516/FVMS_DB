<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="jsp.Bean.model.*"
	import="java.io.PrintWriter" 
	import="jsp.DB.method.*"
	import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>주간보고서 사용 여부 수정</title>
<!-- Custom fonts for this template-->
<link href="../../vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="../../css/sb-admin-2.min.css" rel="stylesheet">
</head>

<%
	request.setCharacterEncoding("UTF-8");
	
	PrintWriter script =  response.getWriter();
	if (session.getAttribute("sessionID") == null){
		script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../../html/login.html' </script>");
	}
	
	int projectNo = Integer.parseInt(request.getParameter("no"));
	String projectName = request.getParameter("name");
	
	ProjectDAO projectDao = new ProjectDAO();
	ArrayList<String> teamList = projectDao.getTeamData();
	
	MemberDAO memberDao = new MemberDAO();
	ArrayList<MemberBean> memberList = memberDao.getMemberData();
	
	ProjectBean project = projectDao.getProjectBean_no(projectNo);
	MemberBean PMdata = memberDao.returnMember(project.getPROJECT_MANAGER());
%>

<style>
	body{
		text-align:center;
	}
	#submit{
		margin:10px;
	}
	#name{
		font-size:18px;
		word-break:break-all;
	}
</style>

<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script>
//팀별 명단
function teamMember(team, member){
	var team1 = $(team).val();
	var memberName;
	var memberPart;
	var memberID;
	var dfselect = $("<option selected disabled hidden>선택</option>");
	$(member).empty();
	$(member).append(dfselect);
	
	<%
		for(int j=0; j<memberList.size(); j++){
			%>if(team1 == '<%=memberList.get(j).getTEAM()%>'){
				memberPart = '<%=memberList.get(j).getPART()%>';
				memberName = '<%=memberList.get(j).getNAME()%>';
				memberID = '<%=memberList.get(j).getID()%>';
				var option = $("<option value="+memberID+">"+ memberPart +" - "+ memberName +"</option>");
				$(member).append(option);
				if($("#PM-team").val() == team1 && ('팀장' == '<%=memberList.get(j).getPosition()%>' || '실장' == '<%=memberList.get(j).getPosition()%>')){
					$("#PROJECT_MANAGER").val(memberID).attr("selected", "selected");
				}
			}
			
	<%}%>
}

$(document).ready(function(){
	$('#PM-team').val('<%=PMdata.getTEAM()%>').prop('selected', true);
	teamMember('#PM-team','#PROJECT_MANAGER');
	$('#PROJECT_MANAGER').val('<%=PMdata.getID()%>').prop("selected", true);
});
</script>

<body>
	<br>
	<p id="name"><%=projectName %></p>
	<p>PM 수정</p>
	<form method="post" action="update_pm_pro.jsp" target="project.jsp">
	<input type="hidden" name="no" value="<%=projectNo %>">
	<select id="PM-team" name="PM-team"
		onchange="teamMember('#PM-team','#PROJECT_MANAGER')">
			<%
              		for(int i=0; i<teamList.size(); i++){
              			%><option value="<%=teamList.get(i)%>"><%=teamList.get(i)%></option>
			<%
              		}
              	%>
	</select> <select id="PROJECT_MANAGER" name="PROJECT_MANAGER"></select>
	<br>
	<input type="submit" onclick="window.close()" name="submit" id="submit" value="수정">
	</form>
</body>
</html>