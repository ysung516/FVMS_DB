<%@page import="java.awt.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.Bean.model.*" import="jsp.DB.method.*"
	import="java.util.ArrayList" import="java.util.Date"
	import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html lang="en">

<head>

<%

	PrintWriter script =  response.getWriter();
	if (session.getAttribute("sessionID") == null){
		script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
	}
	int permission = Integer.parseInt(session.getAttribute("permission").toString());
	if (permission > 1){
		script.print("<script> alert('관리자가 아닙니다.'); history.back(); </script>");
	}

	String sessionID = session.getAttribute("sessionID").toString();
	String sessionName = session.getAttribute("sessionName").toString();
	
	Date nowTime = new Date();
	int nowYear = Integer.parseInt(request.getParameter("year"));
	
	ProjectDAO projectDao = new ProjectDAO();
	MemberDAO memberDao = new MemberDAO();
	ManagerDAO managerDao = new ManagerDAO();
	
	ArrayList<ProjectBean> projectList = projectDao.getProjectList(nowYear);
	ArrayList<String> teamList = projectDao.getTeamData(Integer.toString(nowYear));
	ArrayList<MemberBean> memberList = memberDao.getMemberData(nowYear);
	ArrayList<WorkPlaceBean> wpList = managerDao.getWorkPlaceList(nowYear);
%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">


<title>Sure FVMS - Project_Make</title>

<!-- Custom fonts for this template-->
<link href="../../vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="../../css/sb-admin-2.min.css" rel="stylesheet">

</head>
<style>
.sidebar .nav-item{
	 	word-break: keep-all;
}
#PROJECT_NAME{
	width:60%;
}
#WORK{
	width:60%;
}
#sidebarToggle{
		display:none;
	}
.sidebar{
	position:relative;
	z-index:997;
}
#insert {
	float: right;
	margin-right: 5px;
	display: inline-block;
	height: 36px;
}

.loading {
	position: fixed;
	text-align: center;
	width: 100%;
	height: 100%;
	top: 0;
	left: 0;
	font-size: 8px;
	background-color: #4e73df6b;
	background-image: linear-gradient(181deg, #3d5482 16%, #6023b654 106%);
	background-size: cover;
	z-index: 1000;
	color: #ffffffc4;
}

.loading #load {
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}

@media ( max-width :765px) {
#sidebarToggle{
		display:block;
	}
	.sidebar .nav-item{
	 	white-space:nowrap !important;
	 	font-size: x-large !important;	 	
	}
	
	#accordionSidebar{
	width: 100%;
	height: 100%;
	text-align: center;
	display: inline;
	padding-top: 60px;
	position: fixed;
	z-index: 998;
	}
	#content{
		margin-left:0;
	}
	.nav-item{
		position: absolute;
		display: inline-block;
		padding-top: 20px;
	}
	.topbar .dropdown {
			padding-top: 0px;
			
	} 
	.card-header{
		margin-top:3.75rem;
	}
	.topbar{
		z-index:999;
		position:fixed;
		width:100%;
		}
		
	.container-fluid {
		padding: 0;
	}
	.card-header:first-child {
		padding: 0;
	}
	.card-body {
		padding: 0;
	}
	body {
		font-size: small;
	}
}
</style>
<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript">

	$(document).ready(function () {
		$('.loading').hide();
		sortSelect('WORKER_LIST'); 
		workDelete();
		PMDelete();
		teamMember('#PM-team','#PROJECT_MANAGER');
		teamMember('#teamlist','#WORKER_LIST');
		defaultTeam();
	    // Warning
	    $(window).on('beforeunload', function(){
	        return "Any changes will be lost";
	    });
	    // Form Submit
	    $(document).on("submit", "form", function(event){
	        $(window).off('beforeunload');
	    });
	})
	
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

	//투입명단선택
	function getSelectValue(){
		//팀, 이름 저장
		var team = $("#teamlist option:selected").val();
		var id = $("#WORKER_LIST option:selected").val();
		var name = ($("#WORKER_LIST option:selected").text()).split("-")[1].trim();
		var part = ($("#WORKER_LIST option:selected").text()).split("-")[0].trim();
		var start = $("#PROJECT_START").val();
		var end = $("#PROJECT_END").val();
		
		var inner = "";
		inner += "<tr style='background-color: greenyellow'>";
		inner += "<td style='display:none'><input name=WORKER_LIST value="+id+"></td>";
		inner += "<td>"+team+"</td>";
		inner += "<td>"+part+"</td>";
		inner += "<td>"+name+"</td>";
		inner += "<td><input name = start type=date value="+start+"></td>";
		inner += "<td><input name = end type=date value="+end+"></td>";
		inner += "<td><input type='button' class='workDel' value='삭제'/></td>";
		inner += "</tr>";
		var cnt =0;
		
		for(var a=0; a<$('#workerListAdd tr').length; a++){
			if(id == $('#workerListAdd tr:eq('+a+')').children().children().val()){
				cnt = 1;
			}
		}
		
		if (cnt == 0){
			$('#workerListAdd').prepend(inner);
		} else{
			alert('이미 등록되어있는 명단 입니다');
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

//명단삭제
function workDelete(){
	$(document).on("click",".workDel",function(){
		var str =""
		var tdArr = new Array();
		var btn = $(this);
		var tr = btn.parent().parent();
		tr.remove();
	});
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

function defaultTeam(){
	var team = $("#team_order option:selected").val();
	$("#team_sales").val(team).attr("selected", "selected");
	$("#PM-team").val(team).attr("selected", "selected");
	$("#teamlist").val(team).attr("selected", "selected");
	teamMember('#PM-team','#PROJECT_MANAGER');
	$('#workerListAdd_PM').empty();
	$("#textValuePM").empty();
	getSelectPM();
	$("#teamlist").val(team).attr("selected", "selected");
	teamMember('#teamlist','#WORKER_LIST');
}

function btn_insert(){
	var copyProjectNO = sessionStorage.getItem("copyProjectNO");
	var no = new Array();
	var team_sales = new Array();
	var team_order = new Array();
	var state = new Array();
	var client = new Array();
	var client_part = new Array();
	var man_month = new Array();
	var project_desopit = new Array();
	var fh_order_projections = new Array();
	var fh_order = new Array();
	var fh_sales_projections = new Array();
	var fh_sales = new Array();
	var sh_order_projections = new Array();
	var sh_order =new Array();
	var sh_sales_projections =new Array();
	var sh_sales = new Array();
	var project_start = new Array();
	var project_end = new Array();
	var client_ptb = new Array();
	var work_place = new Array();
	var work = new Array();
	var project_manager = new Array();
	var assessment_type = new Array();
	var employ_demand = new Array();
	var outsource_demand = new Array();
	var reportcheck = new Array();
	var sheetcheck = new Array();
	
	var cnt = -1;
	<%
		for(int z=0; z<projectList.size(); z++){		
			%>
				no[<%=z%>] = '<%=projectList.get(z).getNO()%>';
				team_order[<%=z%>] = '<%=projectList.get(z).getTEAM_ORDER()%>';
				team_sales[<%=z%>] = '<%=projectList.get(z).getTEAM_SALES()%>';
				state[<%=z%>] = '<%=projectList.get(z).getSTATE()%>';
				client[<%=z%>] = '<%=projectList.get(z).getCLIENT()%>';
				client_part[<%=z%>] = '<%=projectList.get(z).getClIENT_PART()%>';
				man_month[<%=z%>] = '<%=projectList.get(z).getMAN_MONTH()%>';
				project_desopit[<%=z%>] = '<%=projectList.get(z).getPROJECT_DESOPIT()%>';
				fh_order_projections[<%=z%>] = '<%=projectList.get(z).getFH_ORDER_PROJECTIONS()%>';
				fh_order[<%=z%>] = '<%=projectList.get(z).getFH_ORDER()%>';
				fh_sales_projections[<%=z%>] = '<%=projectList.get(z).getFH_SALES_PROJECTIONS()%>';
				fh_sales[<%=z%>] = '<%=projectList.get(z).getFH_SALES()%>';
				sh_order_projections[<%=z%>] = '<%=projectList.get(z).getSH_ORDER_PROJECTIONS()%>';
				sh_order[<%=z%>] = '<%=projectList.get(z).getSH_ORDER()%>';
				sh_sales_projections[<%=z%>] = '<%=projectList.get(z).getSH_SALES_PROJECTIONS()%>';
				sh_sales[<%=z%>] = '<%=projectList.get(z).getSH_SALES()%>';
				project_start[<%=z%>] = '<%=projectList.get(z).getPROJECT_START()%>';
				project_end[<%=z%>] = '<%=projectList.get(z).getPROJECT_END()%>';
				client_ptb[<%=z%>] = '<%=projectList.get(z).getCLIENT_PTB()%>';
				work_place[<%=z%>] = '<%=projectList.get(z).getWORK_PLACE()%>';
				work[<%=z%>] = '<%=projectList.get(z).getWORK()%>';
				project_manager[<%=z%>] = '<%=projectList.get(z).getPROJECT_MANAGER()%>';
				assessment_type[<%=z%>] = '<%=projectList.get(z).getASSESSMENT_TYPE()%>';
				employ_demand[<%=z%>] = '<%=projectList.get(z).getEMPLOY_DEMAND()%>';
				outsource_demand[<%=z%>] = '<%=projectList.get(z).getOUTSOURCE_DEMAND()%>';
				reportcheck[<%=z%>] = '<%=projectList.get(z).getREPORTCHECK()%>';
	<%}%>
	
	for(var a=0; a<no.length; a++){
		if(no[a] == copyProjectNO){
			cnt = a;
		}
	}
	
	if(cnt != -1){
		$('#team_order').val(team_order[cnt]);
		$('#team_sales').val(team_sales[cnt]);	
		$('#STATE').val(state[cnt]);
		$('#CLIENT').val(client[cnt]);
		$('#CLIENT_PART').val(client_part[cnt]);
		$('#MAN_MONTH').val(man_month[cnt]);
		$('#PROJECT_DESOPIT').val(project_desopit[cnt]);
		$('#FH_ORDER').val(fh_order[cnt]);
		$('#FH_SALES_PROJECTIONS').val(fh_sales_projections[cnt]);
		$('#FH_SALES').val(fh_sales[cnt]);
		$('#SH_ORDER').val(sh_order[cnt]);
		$('#SH_SALES_PROJECTIONS').val(sh_sales_projections[cnt]);
		$('#SH_SALES').val(sh_sales[cnt]);
		$('#PROJECT_START').val(project_start[cnt]);
		$('#PROJECT_END').val(project_end[cnt]);
		$('#CLIENT_PTB').val(client_ptb[cnt]);
		$('#WORK_PLACE').val(work_place[cnt]);
		$('#WORK').val(work[cnt]);
		$('#PROJECT_MANAGER').val(project_manager[cnt]);
		$('#ASSESSMENT_TYPE').val(assessment_type[cnt]);
		$('#EMPLOY_DEMAND').val(employ_demand[cnt]);
		$('#OUTSOURCE_DEMAND').val(outsource_demand[cnt]);
		
		if(reportcheck[cnt] == 1){
			$('#reportTrue').prop('checked',true);
			$('#reportFalse').prop('checked',false);
		} else if(reportcheck[cnt] == 0){
			$('#reportTrue').prop('checked',false);
			$('#reportFalse').prop('checked',true);
		}
		
		
	}

}

</script>

<body id="page-top">

	<!--  로딩화면  시작  -->
	<div class="loading">
		<div id="load">
			<i class="fas fa-spinner fa-10x fa-spin"></i>
		</div>
	</div>
	<!--  로딩화면  끝  -->

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion toggled"
			id="accordionSidebar">

			<!-- Sidebar - Brand -->


			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../mypage/mypage.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>마이페이지</span></a></li>

			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../summary/summary.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>수입 요약</span></a></li>
					
			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../expense_sum/expense_sum.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>지출 요약</span></a></li>
					
			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../profit_analysis/profit_analysis.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>수익 지표</span></a></li>
					
			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../memchart/memchart.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>조직도</span></a></li>

			<!-- Nav Item - project -->
			<li class="nav-item active"><a class="nav-link"
				href="../project/project.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>프로젝트 관리</span></a></li>

			<!-- Nav Item - schedule -->
			<li class="nav-item"><a class="nav-link"
				href="../schedule/schedule.jsp"> <i
					class="fas fa-fw fa-calendar"></i> <span>스케줄 - 엔지니어</span></a></li>

			<li class="nav-item"><a class="nav-link"
				href="../project_schedule/project_schedule.jsp"> <i
					class="fas fa-fw fa-calendar"></i> <span>스케줄 - 프로젝트</span></a></li>
					
			<!-- Nav Item - manager schedule -->
			<li class="nav-item"><a class="nav-link"
				href="../manager_schedule/manager_schedule.jsp"> <i
					class="fas fa-fw fa-calendar"></i> <span>스케줄 - 관리자</span></a></li>

			<!-- Nav Item - report -->
			<li class="nav-item"><a class="nav-link"
				href="../report/report.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>프로젝트 주간보고</span></a></li>

			<!-- Nav Item - meeting -->
			<li class="nav-item"><a class="nav-link"
				href="../meeting/meeting.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>고객미팅 회의록</span></a></li>
					
			<!-- Nav Item - meeting -->
			<li class="nav-item"><a class="nav-link"
				href="../assessment/assessment.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>평가</span></a></li>

			<!-- Nav Item - manager page -->
			<%if(permission == 0){ %>
			<li class="nav-item"><a class="nav-link"
				href="../manager/manager.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>관리자 페이지</span></a></li>
			<% }%>

			

		</ul>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

					<!-- Sidebar Toggle (Topbar) -->
					<button id="sidebarToggleTop"
						class="btn btn-link d-md-none rounded-circle mr-3">
						<i class="fa fa-bars"></i>
					</button>

					<!-- Topbar Navbar -->
					<ul class="navbar-nav ml-auto">
						<div class="topbar-divider d-none d-sm-block"></div>

						<!-- Nav Item - User Information -->
						<li class="nav-item dropdown no-arrow"><a
							class="nav-link dropdown-toggle" href="#" id="userDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <span
								class="mr-2 d-none d-lg-inline text-gray-600 small"><%=sessionName%></span>
						</a> <!-- Dropdown - User Information -->
							<div
								class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
								aria-labelledby="userDropdown">
								<a class="dropdown-item" href="#" data-toggle="modal"
									data-target="#logoutModal"> <i
									class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
									Logout
								</a>
							</div></li>

					</ul>

				</nav>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!--프로젝트 생성 테이블 시작 *********************************************************** -->
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary"
								style="padding-left: 17px; display: inline">프로젝트 생성</h6>
							<input id="insert" type="button" value="붙여넣기"
								class="btn btn-primary" onclick="btn_insert()">
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<form method="post" action="project_makePro.jsp">
								<input type=hidden name=year value=<%=nowYear%>>
									<table class="table table-bordered" id="dataTable">
										<tr>
											<th><span style="color: red;">*</span>팀(수주)</th>
											<td><select id="team_order" name="team_order"
												onchange="defaultTeam()">
													<%
                      		for(int i=0; i<teamList.size(); i++){
                      			%><option value="<%=teamList.get(i)%>"><%=teamList.get(i)%></option>
													<%
                      		}
                      	%>
											</select></td>
										</tr>
										<tr>
											<th>팀(매출)</th>
											<td><select id="team_sales" name="team_sales">
													<%
                      		for(int i=0; i<teamList.size(); i++){
                      			%><option value="<%=teamList.get(i)%>"><%=teamList.get(i)%></option>
													<%
                      		}
                      	%>
											</select></td>
										</tr>
										<tr>
											<th><span style="color: red;">*</span>프로젝트 코드</th>
											<td><input name="PROJECT_CODE" id="PROJECT_CODE"></input>
											</td>
										</tr>
										<tr>
											<th><span style="color: red;">*</span>프로젝트 명</th>
											<td><input id="PROJECT_NAME" name="PROJECT_NAME"></input>
											</td>
										</tr>

										<tr>
											<th>상태</th>
											<td><select id="STATE" name="STATE">
													<option value="상태">상태</option>
													<option value="1.예산확보">1.예산확보</option>
													<option value="2.고객의사">2.고객의사</option>
													<option value="3.제안단계">3.제안단계</option>
													<option value="4.업체선정">4.업체선정</option>
													<option value="5.진행예정">5.진행예정</option>
													<option value="6.진행중">6.진행중</option>
													<option value="7.종료">7.종료</option>
													<option value="8.Dropped">8.Dropped</option>
											</select></td>
										</tr>

										<tr>
											<th>실</th>
											<td><input name="PART" value="VT"></td>
										</tr>

										<tr>
											<th>고객사</th>
											<td><input id="CLIENT" name="CLIENT"></input></td>
										</tr>

										<tr>
											<th>고객부서</th>
											<td><input id="CLIENT_PART" name="CLIENT_PART">
											</td>
										</tr>

										<tr>
											<th>M/M</th>
											<td><input id="MAN_MONTH" name="MAN_MONTH" value="0"></input>
											</td>
										</tr>

										<tr>
											<th>프로젝트계약금액</th>
											<td><input id="PROJECT_DESOPIT" name="PROJECT_DESOPIT"
												value="0"> (백만)</input></td>
										</tr>

										<tr>
											<th>상반기예상수주</th>
											<td><input id="FH_ORDER_PROJECTIONS"
												name="FH_ORDER_PROJECTIONS" value="0"></td>
										</tr>

										<tr>
											<th>상반기수주</th>
											<td><input id="FH_ORDER" name="FH_ORDER" value="0">
											</td>
										</tr>

										<tr>
											<th>상반기예상매출</th>
											<td><input id="FH_SALES_PROJECTIONS"
												name="FH_SALES_PROJECTIONS" value="0"></td>
										</tr>

										<tr>
											<th>상반기매출</th>
											<td><input id="FH_SALES" name="FH_SALES" value="0">
											</td>
										</tr>

										<tr>
											<th>하반기예상수주</th>
											<td><input id="SH_ORDER_PROJECTIONS"
												name="SH_ORDER_PROJECTIONS" value="0"></td>
										</tr>

										<tr>
											<th>하반기수주</th>
											<td><input id="SH_ORDER" name="SH_ORDER" value="0">
											</td>
										</tr>

										<tr>
											<th>하반기예상매출</th>
											<td><input id="SH_SALES_PROJECTIONS"
												name="SH_SALES_PROJECTIONS" value="0"></td>
										</tr>

										<tr>
											<th>하반기매출</th>
											<td><input id="SH_SALES" name="SH_SALES" value="0"></input>
											</td>
										</tr>

										<tr>
											<th>착수</th>
											<td><input type="date" id="PROJECT_START" name="PROJECT_START"></input></td>
										</tr>

										<tr>
											<th>종료</th>
											<td><input type="date" id="PROJECT_END" name="PROJECT_END"></input></td>
										</tr>

										<tr>
											<th>고객담당자</th>
											<td><input id="CLIENT_PTB" name="CLIENT_PTB"></input></td>
										</tr>

										<tr>
											<th>근무지</th>
											<td><select id="workPlace" name="WORK_PLACE">
											<%
												for(int i=0; i<wpList.size(); i++){%>
													<option value="<%=wpList.get(i).getPlace()%>"><%=wpList.get(i).getPlace()%></option>
											<%}%>
											</select></td>
										</tr>

										<tr>
											<th>업무</th>
											<td><input id="WORK" name="WORK"></input></td>
										</tr>

									<tr>
											<th><span style="color: red;">*</span>PM</th>
											<td id="PMTD"><select id="PM-team" name="PM-team"
												onchange="teamMember('#PM-team','#PROJECT_MANAGER')">
													<%
		                      		for(int i=0; i<teamList.size(); i++){
		                      			%><option value="<%=teamList.get(i)%>"><%=teamList.get(i)%></option>
													<%
		                      		}
		                      	%></select> 
		                      			<select id="PROJECT_MANAGER" name="PROJECT_MANAGER" onChange="getSelectPM()"></select>
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
													<tbody id="workerListAdd_PM"></tbody>
												</table>
											</td>
										</tr>

										<tr>
											<th>투입 명단</th>
											<td id="WorkerList"><select id="teamlist"
												name="teamlist"
												onchange="teamMember('#teamlist','#WORKER_LIST')">
													<%
		                      		for(int i=0; i<teamList.size(); i++){
		                      			%><option value="<%=teamList.get(i)%>"><%=teamList.get(i)%></option>
													<%
		                      		}
		                      	%>
											</select> <select id="WORKER_LIST" 
												onChange="getSelectValue();"></select>
												<table id="workerList" style="margin-top: 5px;">
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
													<tbody id="workerListAdd">
													</tbody>
												</table></td>
										</tr>
										<tr>
											<th>2020(상)평가유형</th>
											<td><input id="ASSESSMENT_TYPE" name="ASSESSMENT_TYPE"></input>
											</td>
										</tr>

										<tr>
											<th>채용수요</th>
											<td><input id="EMPLOY_DEMAND" name="EMPLOY_DEMAND"
												value="0"></input></td>
										</tr>

										<tr>
											<th>외주수요</th>
											<td><input id="OUTSOURCE_DEMAND" name="OUTSOURCE_DEMAND"
												value="0"></input></td>
										</tr>
										<tr>
											<th><span style="color: red;">*</span>주간보고서</th>
											<td><input id="reportTrue" class="reportCheck"
												type="radio" name="reportCheck" value="1" checked="checked">사용
												<input id="reportFalse" class="reportCheck" type="radio"
												name="reportCheck" value="0">미사용</td>
										</tr>
										<tr>
											<th><span style="color: red;">*</span>실적보고</th>
											<td><input class="sheetCheck" type="radio"
												name="sheetCheck" value="1" checked="checked">사용 <input
												class="sheetCheck" type="radio" name="sheetCheck" value="0">미사용
											</td>
										</tr>
										<tr>
											<th><span style="color: red;">*</span>복사</th>
											<td><input type="radio" name="copy" value="1" checked="checked">사용 
												<input type="radio" name="copy" value="0">미사용
											</td>
										</tr>
										<tr align="center">
											<td colspan="2"><input id="COMPLETE" type="submit"
												name="COMPLETE" value="완료" class="btn btn-primary">
												<a href="project.jsp" class="btn btn-primary">취소</a></td>
										</tr>
									</table>
								</form>
							</div>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>

	<!-- Logout Modal-->
	<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">로그아웃 하시겠습니까?</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">확인버튼을 누를 시 로그아웃 됩니다.</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button"
						data-dismiss="modal">취소</button>
					<form method="post" action="../LogoutPro.jsp">
						<input type="submit" class="btn btn-primary" value="확인" />
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap core JavaScript-->
	<script src="../../vendor/jquery/jquery.min.js"></script>
	<script src="../../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="../../vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="../../js/sb-admin-2.min.js"></script>

	<!-- Page level plugins -->
	<script src="../../vendor/chart.js/Chart.min.js"></script>

	<!-- Page level custom scripts -->
	<script src="../../js/demo/chart-area-demo.js"></script>
	<script src="../../js/demo/chart-pie-demo.js"></script>
	<script src="../../js/demo/chart-bar-demo.js"></script>

</body>

</html>
