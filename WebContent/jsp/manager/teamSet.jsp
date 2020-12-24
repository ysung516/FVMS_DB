<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.DB.method.*" import="jsp.Bean.model.*"
	import="java.util.ArrayList" import="java.util.List"
	import="java.text.SimpleDateFormat" import="java.util.Date"
	import="java.util.LinkedHashMap"%>
	
<!DOCTYPE html>
<html lang="en">

<head>
<%
		PrintWriter script =  response.getWriter();
		if (session.getAttribute("sessionID") == null){
			script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
		}
		
		int permission = Integer.parseInt(session.getAttribute("permission").toString());
		if(permission != 0){
			script.print("<script> alert('접근 권한이 없습니다.'); history.back(); </script>");
		}
			
		String sessionID = session.getAttribute("sessionID").toString();
		String sessionName = session.getAttribute("sessionName").toString();
		
		SummaryDAO summaryDao = new SummaryDAO();
		MemberDAO memberDao = new MemberDAO();
		
		Date nowTime = new Date();
		SimpleDateFormat sf_yyyy = new SimpleDateFormat("yyyy");
		String nowYear = sf_yyyy.format(nowTime);
		int year = Integer.parseInt(sf_yyyy.format(nowTime));
		
		if(request.getParameter("selectYear") != null){
			nowYear = request.getParameter("selectYear");
		}
		
		int maxYear = summaryDao.maxYear();
		int yearCount = maxYear - summaryDao.minYear() + 1;
		
		LinkedHashMap<Integer, String> teamList = memberDao.getTeam_year(nowYear);
		LinkedHashMap<String, TeamBean> teamData = summaryDao.getTargetData(nowYear);
	%>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Sure FVMS - team Setting</title>

<!-- Custom fonts for this template-->
<link href="../../vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="../../css/sb-admin-2.min.css" rel="stylesheet">


<style>

.sidebar .nav-item{
	 	word-break: keep-all;
}
#sidebarToggle{
	display:none;
}
.sidebar{
	position:relative;
	z-index:997;
}


#manager_btn {
	position: fixed;
	bottom: 0;
	padding: 10px;
	width: 100%;
	text-align: center;
	background-color: #fff;
	border-top: 1px solid;
}


.m-0 .text-primary {
	vertical-align: middle;
	text-align: center;
}

.num_width{
	width: 60px;
}

.button_width{
	width : 55px;
}

.goal{
	width: 80px;
}

td, th{
	text-align: center;
}

th{
	font-size: small;
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
	.wpTable{
		padding: 5px;
		width: 100%;
	}
	#sidebarToggle{
		display:block;
	}
	.extra{
		display:none;
	}
	.card-header{
		margin-top:4.75rem;
	}
	.sidebar .nav-item{
	 	white-space:nowrap !important;
	 	font-size: x-large !important;	 	
	}
	.topbar{
		z-index:999;
		position:fixed;
		width:100%;
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
			
	} 	.container-fluid {
		padding: 0;
	}
	.card-header:first-child {
		padding: 0;
	}
	.table-responsive {
		width: 100%;
		margin-left:0;
	}
}

</style>

<!-- sorting table -->
<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript" src="jquery.tablednd.js"></script>
<script type="text/javascript">

	window.onbeforeunload = function () { $('.loading').show(); }  //현재 페이지에서 다른 페이지로 넘어갈 때 표시해주는 기능
	$(window).load(function () {          //페이지가 로드 되면 로딩 화면을 없애주는 것
	    $('.loading').hide();
	    $('#count').val($('#table tr').length-1);
		$('#selYear').val(<%=nowYear%>).prop("selected",true);
	});
	
	function loadYear(){
		var year = $('#selYear').val();
		location.href ="teamSet.jsp?selectYear="+year;
	}
	
	var count = $('#table tr').length-1;
	
	function rowAdd(){
		count = $('#table tr').length-1;
		console.log(count);
		var innerHtml = "";
		innerHtml += '<tr>';
		innerHtml += '<td><input class="num_width" name="teamNum" value="'+count+'" type="hidden"><span>'+count+'</span></td>';
		innerHtml += '<td><input class="team_width" name="teamName" value="" ></td>';
		innerHtml += '<td><input class="goal" name="fh_order" value=""></td>';
		innerHtml += '<td><input class="goal" name="fh_sale" value=""></td>';
		innerHtml += '<td><input class="goal" name="sh_order" value=""></td>';
		innerHtml += '<td><input class="goal" name="sh_sale" value=""></td>';
		innerHtml += '<td class="button_width"><input class="deleteNP" type="button" onclick="deleteNP()" value="삭제"></td>';
		innerHtml += '</tr>';
		$('#count').val(count+1);
		$('#workplaceList').append(innerHtml);
	}
	
	function deleteNP(){
		$(document).on("click",".deleteNP",function(){	
			var str =""
			var tdArr = new Array();
			var btn = $(this);
			var tr = btn.parent().parent();
			var td = tr.children();
			var delID = td.eq(0).text();
			tr.remove();
			
			var len = $('#workplaceList tr').length;
			for(var a=0; a<=len; a++){
				$("#workplaceList tr:eq("+a+") td:eq(0) span").text(a+1);
				$("#workplaceList tr:eq("+a+") td:eq(0) input").attr("name", "teamNum").val(a+1);
				$("#workplaceList tr:eq("+a+") td:eq(1) input").attr("name", "teamName");
				$("#workplaceList tr:eq("+a+") td:eq(2) input").attr("name", "fh_order");
				$("#workplaceList tr:eq("+a+") td:eq(3) input").attr("name", "fh_sale");
				$("#workplaceList tr:eq("+a+") td:eq(4) input").attr("name", "sh_order");
				$("#workplaceList tr:eq("+a+") td:eq(5) input").attr("name", "sh_sale");
			}
			$('#count').val($('#table tr').length-1);
		});
	}
	
	jQuery(document).ready(function($){
		$("#table tbody").tableDnD({
			onDragClass: "dnd_drag",
		    onDragStart: function(table, row) {
		        console.log("start drag");
		    },
		    onDrop: function(table, row) {
		        console.log($.tableDnD.serializeTable(table));
		        var len = $('#workplaceList tr').length;
				for(var a=0; a<=len; a++){
					$("#workplaceList tr:eq("+a+") td:eq(0) span").text(a+1);
					$("#workplaceList tr:eq("+a+") td:eq(0) input").attr("name", "teamNum").val(a+1);
					$("#workplaceList tr:eq("+a+") td:eq(1) input").attr("name", "teamName");
					$("#workplaceList tr:eq("+a+") td:eq(2) input").attr("name", "fh_order");
					$("#workplaceList tr:eq("+a+") td:eq(3) input").attr("name", "fh_sale");
					$("#workplaceList tr:eq("+a+") td:eq(4) input").attr("name", "sh_order");
					$("#workplaceList tr:eq("+a+") td:eq(5) input").attr("name", "sh_sale");
				}
		    }
		});
	});
</script>
</head>
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
		<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion toggled" id="accordionSidebar">
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
			<li class="nav-item"><a class="nav-link"
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
			<li class="nav-item active"><a class="nav-link"
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



						<!-- Nav Item - User Information -->
						<li class="nav-item dropdown no-arrow"><a
							class="nav-link dropdown-toggle" href="#" id="userDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <span
								class="mr-2 d-none d-lg-inline text-gray-600 small"><%=sessionName%></span>
								<i class="fas fa-info-circle"></i>
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

					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary" id="view_btn">팀 관리 페이지
								<select id="selYear" name="selYear" onchange="loadYear()">
				         			<%for(int i=0; i<yearCount; i++){%>
									<option value='<%=maxYear-i%>'><%=maxYear-i%></option>
									<%}%>
				         		</select>
							</h6>
							<div style="margin-top: 5px;">
								<button class="btn btn-primary" onClick="location.href='manager.jsp'" style="font-size:small; margin-right:5px;">관리자 메인</button>
								<button class="btn btn-primary" onclick="location.href ='workPlace_manage.jsp'" style="font-size:small; margin-right:5px;">근무지 관리</button>
				         		<button class="btn btn-primary" style="font-size:small; background-color: #364d91;" onclick="location.href='team_nextCopy.jsp?year=<%=year+1%>'"><%=year+1 %>년 팀 생성</button>
							</div>
						</div>
						<form method="post" action="teamSetPro.jsp">
						<div class="table-responsive" style="padding: 20px">
						<input id="count" type="hidden" name="count">
						<input id="nowYear" type="hidden" name="nowYear" value="<%=nowYear%>">
						<p style="caption-side: top; color:red; font-size:small; font-weight: bold;">
							우선순위 0은 항상 실로 고정
							<br>팀 삭제 시 요약(수입, 지출), 수익 지표, 조직도, 스케줄(엔지니어, 프로젝트)에서 해당 팀 안보임
						</p>
						<table class="wpTable" id="table">
							<thead>
								<tr>
									<th class="num">우선순위</th>
									<th class="team">팀</th>
									<th class="fh_order">상반기<br>목표수주</th>
									<th class="fh_sale">상반기<br>목표매출</th>
									<th class="sh_order">하반기<br>목표수주</th>
									<th class="sh_sale">하반기<br>목표매출</th>
									<th class="button_width"><input type="button" value="+"  class="btn btn-primary" onclick="rowAdd();"></th>
									<th>순서변경</th>
								</tr>
							</thead>
								<tr>
									<td><input class="num_width" name="teamNum" value="0" type="hidden"><span>0</span></td>
									<td><input class="team_width" name="teamName" value="<%=teamList.get(0) %>"></td>
									<td><input class="goal" name="fh_order" value="<%=teamData.get(teamList.get(0)).getFH_targetOrder()%>"></td>
									<td><input class="goal" name="fh_sale" value="<%=teamData.get(teamList.get(0)).getFH_targetSales()%>"></td>
									<td><input class="goal" name="sh_order" value="<%=teamData.get(teamList.get(0)).getSH_targetOrder()%>"></td>
									<td><input class="goal" name="sh_sale" value="<%=teamData.get(teamList.get(0)).getSH_targetSales()%>"></td>
									<td class="button_width"></td>
									<td></td>
								</tr>
							<tbody id="workplaceList">
								<%for(int teamNum : teamList.keySet()){ 
									if(teamNum!=0){%>
									<tr class="changeRow" id="<%=teamNum%>">
										<td><input class="num_width" name="teamNum" value="<%=teamNum %>" type="hidden"><span><%=teamNum %></span></td>
										<td><input class="team_width" name="teamName" value="<%=teamList.get(teamNum) %>" ></td>
										<td><input class="goal" name="fh_order" value="<%=teamData.get(teamList.get(teamNum)).getFH_targetOrder()%>"></td>
										<td><input class="goal" name="fh_sale" value="<%=teamData.get(teamList.get(teamNum)).getFH_targetSales()%>"></td>
										<td><input class="goal" name="sh_order" value="<%=teamData.get(teamList.get(teamNum)).getSH_targetOrder()%>"></td>
										<td><input class="goal" name="sh_sale" value="<%=teamData.get(teamList.get(teamNum)).getSH_targetSales()%>"></td>
										<td class="button_width"><input class="deleteNP" type="button" onclick="deleteNP()" value="삭제"></td>
										<td>=</td>
									</tr>
								<%}} %>
							</tbody>
						</table>
						</div>

						<!-- /.container-fluid -->

						<div id="manager_btn">
							<input type="submit" value="저장" class="btn btn-primary">
						</div>
						</form>
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
