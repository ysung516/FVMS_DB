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
	
	String[] workerID = {};	//투입명단 id 저장용
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
	table{
		margin-left: auto;
		margin-right: auto;
		margin-top:20px;
		border : 1px solid;
	}
	th, td{
		padding:10px;
		border : 1px solid;
	}
</style>

<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script>
//정렬함수
function sortSelect(selId) {
	var sel = $('#'+selId);
	var optionList = sel.find('option');
	optionList.sort(function(a, b){
		if (a.text > b.text) return 1;
		else if (a.text < b.text) return -1;
		else { 
			if (a.value > b.value) return 1; 
			else if (a.value < b.value) return -1; 
			else return 0; 
			} 
		}); 
		sel.html(optionList); 
}

//명단선택
function getSelectValue(){
	//팀, 이름 저장
	var team = $("#teamlist option:selected").val();
	var id = $("#WORKER_LIST option:selected").val();
	var name = ($("#WORKER_LIST option:selected").text()).split("-")[1].trim();
	var part = ($("#WORKER_LIST option:selected").text()).split("-")[0].trim();
	var inner = "";
	inner += "<tr>";
	inner += "<td style='display:none;'>"+id+"</td>";
	inner += "<td>"+team+"</td>";
	inner += "<td>"+part+"</td>";
	inner += "<td>"+name+"</td>";
	inner += "<td><input type='button' class='workDel' value='삭제'/></td>";
	inner += "</tr>";
	$('#workerList > tbody:last').append(inner);
	//id 저장
	$("#textValue2").append(id+" ");
}

//명단삭제
function workDelete(){
	$(document).on("click",".workDel",function(){
		var str =""
		var tdArr = new Array();
		var btn = $(this);
		var tr = btn.parent().parent();
		var td = tr.children();
		var delID = td.eq(0).text();
		var text = $("#textValue2").text();
		var te = text.replace(delID+" ", "");
		$("#textValue2").text(te);
		tr.remove();
	});
}

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
	sortSelect('WORKER_LIST');
	workDelete();
	teamMember('#teamlist','#WORKER_LIST');
});
</script>

<body>
	<br>
	<p id="name"><%=projectName %></p>
	<p>투입 명단 수정</p>
	<form method="post" action="update_worker_pro.jsp" target="project.jsp">
	<input type="hidden" name="no" value="<%=projectNo %>">
	<select id="teamlist"
		name="teamlist"
		onchange="teamMember('#teamlist','#WORKER_LIST')">
			<%
              		for(int i=0; i<teamList.size(); i++){
              			%><option value="<%=teamList.get(i)%>"><%=teamList.get(i)%></option>
			<%
              		}
              	%>
	</select> <select id="WORKER_LIST" name="WORKER_LIST"
		onChange="getSelectValue();"></select> <textarea
			id="textValue2" name="WORKER_LIST2" style="display: none;">
			<%if(project.getWORKER_LIST()!=null)%><%=project.getWORKER_LIST()%></textarea>
		<table id="workerList">
			<thead>
				<tr>
					<th style="display: none;">id</th>
					<th>팀</th>
					<th>소속</th>
					<th>이름</th>
				</tr>
			</thead>
			<tbody id="workerListAdd">
				<%
       				if(project.getWORKER_LIST().length() != 0) {
       				workerID = project.getWORKER_LIST().split(" ");
       				for(int c=0; c<workerID.length;c++){
					MemberBean member = memberDao.returnMember(workerID[c]); %>
				<tr>
					<td style='display: none;'><%=workerID[c]%></td>
					<td><%=member.getTEAM()%></td>
					<td><%=member.getPART()%></td>
					<td><%=member.getNAME()%></td>
					<td><input type='button' class='workDel' value='삭제' /></td>
				</tr>
				<%}} %>
			</tbody>
		</table>
	<br>
	<input type="submit" onclick="window.close()" name="submit" id="submit" value="수정">
	</form>
</body>
</html>