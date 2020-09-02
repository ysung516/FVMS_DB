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
		script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../../html/login.html' </script>");
	}
	int permission = Integer.parseInt(session.getAttribute("permission").toString());
	if(permission != 0){
		script.print("<script> alert('접근 권한이 없습니다.'); history.back(); </script>");
	}
	
	String sessionID = session.getAttribute("sessionID").toString();
	String sessionName = session.getAttribute("sessionName").toString();
	session.setMaxInactiveInterval(60*60);
	
	MemberDAO memberDao = new MemberDAO();
	ArrayList<MemberBean> memberList = memberDao.getMemberData();

%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Sure FVMS - Schedule</title>

<!-- Custom fonts for this template-->
<link href="../../vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="../../https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="../../css/sb-admin-2.min.css" rel="stylesheet">

<!-- gantt차트 css -->
<link href="jsgantt.css" rel="stylesheet" type="text/css" />

</head>
<style>
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
</style>



<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script src="jsgantt.js" type="text/javascript"></script>
<script>
	function drawSch(){
		var g = new JSGantt.GanttChart(document.getElementById('GanttChartDIV'), 'day');	
		//var g = new JSGantt.GanttChart('g',document.getElementById('GanttChartDIV'), 'day');

		  출처: https://lahuman.jabsiri.co.kr/77 [lahuman & jabsiri 노트]
		g.setOptions({
		  vCaptionType: 'Complete',  // Set to Show Caption : None,Caption,Resource,Duration,Complete,
		  vQuarterColWidth: 36,
		  vDateTaskDisplayFormat: 'yyyy-mm-dd', // Shown in tool tip box
		  vDayMajorDateDisplayFormat: 'mon yyyy - Week ww',// Set format to dates in the "Major" header of the "Day" view
		  vWeekMinorDateDisplayFormat: 'dd mon', // Set format to display dates in the "Minor" header of the "Week" view
		  vLang: 'en',
		  vShowTaskInfoLink: 1, // 툴팁에 링크 표시(0/1)
		  vShowEndWeekDate: 0,  // 일별 머리글에 요일의 마지막 날짜 표시/숨기기
		  vUseSingleCell: 10000, // 테이블 행당 임계값 셀 설정(대량 데이터에 대한 성능 지원)
		  vFormatArr: ['Day', 'Week', 'Month'], // Even with setUseSingleCell using Hour format on such a large chart can cause issues in some browsers,
		
		});
		
		// Load from a Json url
		JSGantt.parseJSON('./fixes/data.json', g);
		
		// Or Adding  Manually
		g.AddTaskItemObject({
		  pID: 1,
		  pName: "갈비찜을 밥 위에 얹어주세용",
		  pStart: "2017-05-17",
		  pEnd: "2017-07-30",
		  pClass: "ggroupblack",
		  pLink: "",
		  pMile: 0,
		  pRes: "냠냠",
		  pGroup: 1,
		  pParent: 0,
		  pOpen: 1,
		  pDepend: "",
		  pCaption: "",
		  pCost: 1000,
		  pNotes: "Some Notes text",
		  category: "My Category",
		  sector: "Finance"
		});
		g.AddTaskItemObject({
		  pID: 2,
		  pName: "내가 제일 좋아하는 갈비찜 덮밥",
		  pStart: "2017-03-17",
		  pEnd: "2017-03-30",
		  pClass: "ggroupblack",
		  pLink: "",
		  pMile: 0,
		  pRes: "냠냠",
		  pGroup: 0,
		  pParent: 0,
		  pOpen: 1,
		  pDepend: "",
		  pCaption: "",
		  pCost: 1000,
		  pNotes: "Some Notes text",
		  category: "My Category",
		  sector: "Finance"
		});
		
		<%
			for(int i=0; i<memberList.size(); i++){ %>
				g.AddTaskItemObject({
					  pID: "<%=memberList.get(i).getID()%>",
					  pName: "<%=memberList.get(i).getNAME()%>",
					  pStart: "2017-03-17",
					  pEnd: "2017-03-30",
					  pClass: "ggroupblack",
					  pLink: "",
					  pMile: 0,
					  pRes: "냠냠",
					  pGroup: 0,
					  pParent: 0,
					  pOpen: 1,
					  pDepend: "",
					  pCaption: "",
					  pCost: 1000,
					  pNotes: "Some Notes text",
					  category: "My Category",
					  sector: "Finance"
					});
	
			<%}
		%>
	
		g.Draw();
	}

		<!-- 로딩화면 -->
		
		window.onbeforeunload = function () { $('.loading').show(); }  //현재 페이지에서 다른 페이지로 넘어갈 때 표시해주는 기능
		$(window).load(function () {          //페이지가 로드 되면 로딩 화면을 없애주는 것
		    $('.loading').hide();
		});
		
		// 페이지 시작시 호출 함수
		$(function(){
			drawSch();	
		});
		
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
			<a
				class="sidebar-brand d-flex align-items-center justify-content-center"
				href="../summary/summary.jsp">
				<div class="sidebar-brand-icon rotate-n-15">
					<i class="fas fa-laugh-wink"></i>
				</div>
				<div class="sidebar-brand-text mx-3">Sure FVMS</div>
			</a>

			<!-- Divider -->
			<hr class="sidebar-divider my-0">


			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../mypage/mypage.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>마이페이지</span></a></li>

			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../summary/summary.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>요약정보</span></a></li>

			<!-- Nav Item - project -->
			<li class="nav-item"><a class="nav-link"
				href="../project/project.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>프로젝트</span></a></li>

			<!-- Nav Item - schedule -->
			<li class="nav-item active"><a class="nav-link"
				href="../schedule/schedule.jsp"> <i
					class="fas fa-fw fa-calendar"></i> <span>스케줄</span></a></li>

			<!-- Nav Item - manager schedule -->
			<li class="nav-item"><a class="nav-link"
				href="../manager_schedule/manager_schedule.jsp"> <i
					class="fas fa-fw fa-calendar"></i> <span>관리자 스케줄</span></a></li>

			<!-- Nav Item - report -->
			<li class="nav-item"><a class="nav-link"
				href="../report/report.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>주간보고서</span></a></li>

			<!-- Nav Item - meeting -->
			<li class="nav-item"><a class="nav-link"
				href="../meeting/meeting.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>회의록</span></a></li>

			<!-- Nav Item - manager page -->
			<%if(permission == 0){ %>
			<li class="nav-item"><a class="nav-link"
				href="../manager/manager.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>관리자 페이지</span></a></li>
			<% }%>


			<!-- Divider -->
			<hr class="sidebar-divider d-none d-md-block">

			<!-- Sidebar Toggler (Sidebar) -->
			<div class="text-center d-none d-md-inline">
				<button class="rounded-circle border-0" id="sidebarToggle"></button>
			</div>

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
							<h6 class="m-0 font-weight-bold text-primary">Schedule</h6>
						</div>
						<div class="card-body">

							<div style="position: relative" class="gantt" id="GanttChartDIV"></div>
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
