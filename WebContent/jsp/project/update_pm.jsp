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

<title>PM 수정</title>
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
		script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
	}
	
	int projectNo = Integer.parseInt(request.getParameter("no"));
	int year = Integer.parseInt(request.getParameter("year"));
	String projectName = request.getParameter("name");
	
	ProjectDAO projectDao = new ProjectDAO();
	ArrayList<String> teamList = projectDao.getTeamData(request.getParameter("year"));
	
	MemberDAO memberDao = new MemberDAO();
	ArrayList<MemberBean> memberList = memberDao.getMemberData(year);
	
	ProjectBean project = projectDao.getProjectBean_no(projectNo,year);
	MemberBean PMdata = memberDao.returnMember(project.getPROJECT_MANAGER());
	

	ArrayList<CareerBean> careerList_PM = projectDao.getCarrerPM(Integer.toString(projectNo));

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

function PM_highlight(){
	var nowPM = '<%=project.getPROJECT_MANAGER()%>';	
	for(var a=0; a<$('#workerListAdd_PM tr').length; a++){
		if(nowPM == $('#workerListAdd_PM tr:eq('+a+')').children().children().val()){
			$('#workerListAdd_PM tr').css("background-color","white");
			$('#workerListAdd_PM tr:eq('+a+')').css("background-color","yellow");
		}
	}
}
//PM 변경 ==> 표 클릭
function changePM(td){
	var tr = $(td).parent();
	var td = tr.children();
	
	$('#workerListAdd_PM tr').css("background-color","white");
	$(tr).css("background-color","yellow");
	
	$('#PROJECT_MANAGER').val(td.eq(0).children().val()).prop("selected", true);
}

//PM선택
function getSelectPM(){
	//팀, 이름 저장
	var team = $("#PM-team option:selected").val();
	var id = $("#PROJECT_MANAGER option:selected").val();
	var name = ($("#PROJECT_MANAGER option:selected").text()).split("-")[1].trim();
	var part = ($("#PROJECT_MANAGER option:selected").text()).split("-")[0].trim();
	var start = $("#PROJECT_START").val();
	var end = $("#PROJECT_END").val();
	var inner = "";
	inner += "<tr style='background-color: greenyellow'>";
	inner += "<td style='display: none'><input name=WORKER_LIST_PM value="+id+"></td>";
	inner += "<td onclick='changePM(this)'>"+team+"</td>";
	inner += "<td onclick='changePM(this)'>"+part+"</td>";
	inner += "<td onclick='changePM(this)'>"+name+"</td>";
	inner += "<td onclick='changePM(this)'><input name = startPM type=date value="+start+"></td>";
	inner += "<td onclick='changePM(this)'><input name = endPM type=date value="+end+"></td>";
	inner += "<td><input type='button' class='PMDel' value='삭제'/></td>";
	inner += "</tr>";
	var cnt =0;
	
	for(var a=0; a<$('#workerListAdd_PM tr').length; a++){
		if(id == $('#workerListAdd_PM tr:eq('+a+')').children().children().val()){
			cnt = 1;
		}
	}
	
	if (cnt == 0){
		$('#workerListAdd_PM').prepend(inner);
		var trPM = $('#workerListAdd_PM tr:eq(0)').children().children();
		if(id == trPM.val()){
			$('#workerListAdd_PM tr').css("background-color","white");
			$('#workerListAdd_PM tr:eq(0)').css("background-color","yellow");
		}

	} else{
		for(var a=0; a<$('#workerListAdd_PM tr').length; a++){
			if(id == $('#workerListAdd_PM tr:eq('+a+')').children().children().val()){
				$('#workerListAdd_PM tr').css("background-color","white");
				$('#workerListAdd_PM tr:eq('+a+')').css("background-color","yellow");
			}
		}
		alert('이미 등록되어있는 PM입니다');
	}
	
}

//PM명단삭제
function PMDelete(){
	$(document).on("click",".PMDel",function(){
		var str =""
		var tdArr = new Array();
		var btn = $(this);
		var tr = btn.parent().parent();
		var td = tr.children();
		var delID = td.children().val();
		tr.remove();
		
		if(delID == $("#PROJECT_MANAGER option:selected").val()){
			$('#workerListAdd_PM tr:eq(0)').css("background-color","yellow");
			var id = $('#workerListAdd_PM tr:eq(0)').children().children().val();
			$('#PROJECT_MANAGER').val(id).prop("selected", true);
		}
	});
}

$(document).ready(function(){
	$('#PM-team').val('<%=PMdata.getTEAM()%>').prop('selected', true);
	teamMember('#PM-team','#PROJECT_MANAGER');
	$('#PROJECT_MANAGER').val('<%=PMdata.getID()%>').prop("selected", true);

	PMDelete();
	PM_highlight();
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
	</select> <select id="PROJECT_MANAGER" name="PROJECT_MANAGER" onChange="getSelectPM()"></select>
	
	<table id="workerList_PM" style="margin-top: 5px;">
		<thead>
			<tr>
				<th style="display: none;">id</th>
				<th>팀</th>
				<th>소속</th>
				<th>이름</th>
				<th>시작</th>
				<th>종료</th>
				<th></th>
			</tr>
		</thead>
		<tbody id="workerListAdd_PM">
			<%for(int c=0; c<careerList_PM.size(); c++){
			    CareerBean careerPM = careerList_PM.get(c);
				MemberBean member = memberDao.returnMember(careerPM.getId()); 
			%>
			<tr>
				<td style='display: none;'><input name="WORKER_LIST_PM" value="<%=careerPM.getId()%>"></td>
				<td onclick="changePM(this)"><%=member.getTEAM()%></td>
				<td onclick="changePM(this)"><%=member.getPART()%></td>
				<td onclick="changePM(this)"><%=member.getNAME()%></td>
				<td onclick="changePM(this)"><input name="startPM" type=date value="<%=careerPM.getStart()%>"></td>
				<td onclick="changePM(this)"><input name="endPM" type=date value="<%=careerPM.getEnd()%>"></td>
				<td><input type='button' class='PMDel' value='삭제'/></td>
			</tr>
			<%}%>
		</tbody>
	</table>
	<br>
	<input type="submit" onclick="window.close()" name="submit" id="submit" value="수정">
	</form>
</body>
</html>