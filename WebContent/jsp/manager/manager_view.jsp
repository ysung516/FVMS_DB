<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.Bean.model.*" import="java.util.ArrayList"
	import="java.util.List" import="jsp.DB.method.*"
	import="java.text.SimpleDateFormat" import="java.util.Date"%>
<!DOCTYPE html>
<html lang="en">

<head>
<%
		PrintWriter script =  response.getWriter();
		if (session.getAttribute("sessionID") == null){
			script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
		}
		
		String sessionID = session.getAttribute("sessionID").toString();
		String sessionName = session.getAttribute("sessionName").toString();
		
		MemberDAO memberDao = new MemberDAO();
		int permission = Integer.parseInt(session.getAttribute("permission").toString());
		String id = request.getParameter("id");
		MemberBean member = memberDao.returnMember(id);
		
		String [] line;
		
		Date nowDate = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy");
		int nowYear = Integer.parseInt(sf.format(nowDate));
		String wyear = "";
		
		if(member.getComDate().contains("-") && member.getComDate().matches(".*[0-9].*")){
  			int comYear = Integer.parseInt(member.getComDate().split("-")[0]);
  			wyear = Integer.toString(nowYear -  comYear + 1 + member.getWorkEx());
  		}else{
  			wyear = "입사일을 올바르게 입력하세요.";
  		}
	%>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Sure FVMS - Manager_view</title>

<!-- Custom fonts for this template-->
<link href="../../vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="../../https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="../../css/sb-admin-2.min.css" rel="stylesheet">

</head>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<script>

	function btn_copy(){
		sessionStorage.removeItem("copyID");
		sessionStorage.setItem("copyID","<%=id%>");
		alert('복사되었습니다.')
	}

	function btn_event(){
		
	}

	function pwd_submit(){
		if (confirm("비밀번호를 초기화합니다.") == true){
			return true;
		}else{
			return false;
		}
	}
	window.onbeforeunload = function () { $('.loading').show(); }  //현재 페이지에서 다른 페이지로 넘어갈 때 표시해주는 기능
	$(window).load(function () {          //페이지가 로드 되면 로딩 화면을 없애주는 것
	    $('.loading').hide();
	});

</script>
<style>
.card {
	width: 80%;
}

.sidebar .nav-item {
	word-break: keep-all;
}

#sidebarToggle {
	display: none;
}

.container-fluid {
	margin-right: 0;
}

.sidebar {
	position: relative;
	z-index: 997;
}

.btn_group {
	right: 0;
	margin-right: 24px;
	display: inline-block;
	position: absolute;
	top: 9px;
}

#dataTable th {
	text-align: center;
	vertical-align: middle;
	word-break: keep-all;
	width: 150px;
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
	.card {
		width: 100%;
	}
	#sidebarToggle {
		display: block;
	}
	.card-header {
		margin-top: 4.75rem;
	}
	.sidebar .nav-item {
		white-space: nowrap !important;
		font-size: x-large !important;
	}
	.topbar {
		z-index: 999;
		position: fixed;
		width: 100%;
	}
	#accordionSidebar {
		width: 100%;
		height: 100%;
		text-align: center;
		display: inline;
		padding-top: 60px;
		position: fixed;
		z-index: 998;
	}
	#content {
		margin-left: 0;
	}
	.nav-item {
		position: absolute;
		display: inline-block;
		padding-top: 20px;
	}
	.topbar .dropdown {
		padding-top: 0px;
	}
	.card-header:first-child {
		padding: 0;
	}
	body {
		font-size: small;
	}
}
</style>

<body id="page-top">

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
					<span>수익성 분석</span></a></li>
					
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
							<h6 class="m-0 font-weight-bold text-primary" style="padding-left: 17px;"><%=member.getNAME()%> 정보 조회</h6>
							<div class="btn_group">
								<form method="post" action="manager_deletePro.jsp">
									<input type="hidden" name="id" value="<%=id%>"> 
									<input id="personal" type="button" style="font-size: small;" value="인사 관리" class="btn btn-primary" onclick="location.href='personalManage.jsp?id=<%=id%>'">
									<input id="Delete" type="submit" style="font-size: small;" name="Delete" value="삭제" class="btn btn-primary"> 
									<input id="copy" type="button" style="font-size: small;" value="복사" class="btn btn-primary" onclick="btn_copy()">
								</form>
							</div>
						</div>

						<div class="card-body">
							<div class="table-responsive">
								<form method="post" action="reset_pwdPro.jsp"
									onsubmit='return pwd_submit();'>
									<input type="hidden" name="id" value="<%=id%>">
									<table class="table table-bordered" id="dataTable">
										<tr>
											<th>팀</th>
											<td><%=member.getTEAM()%></td>
										</tr>
										<tr>
											<th>이름</th>
											<td><%=member.getNAME()%></td>
										</tr>
										<tr>
											<th>권한</th>
											<td><%=member.getPermission()%></td>
										</tr>
										<tr>
											<th>소속</th>
											<td><%=member.getPART()%></td>
										</tr>
										<tr>
											<th>직급</th>
											<td><%=member.getRANK()%></td>
										</tr>
										<tr>
											<th>직책</th>
											<td><%=member.getPosition()%></td>
										</tr>
										<tr>
											<th>mobile</th>
											<td><%=member.getMOBILE()%></td>
										</tr>
										<tr>
											<th>gmail</th>
											<td><%=member.getGMAIL()%></td>
										</tr>
										<tr>
											<th>거주지</th>
											<td><%=member.getADDRESS()%></td>
										</tr>
										<tr>
											<th>입사일</th>
											<td><%=member.getComDate()%></td>
										</tr>
										<tr>
											<th>경력</th>
											<td><%=member.getWorkEx()%></td>
										</tr>
										<tr>
											<th>연차</th>
											<td><%=wyear %></td>
										</tr>
										<tr>
											<th>프로젝트<br>수행 이력</th>
											<td>
											<%
									      	line = member.getP_career();
									      	for(String li : line){
									      		%><p style="white-space: break-spaces;"><%=li%></p> <%
									      	}
									     	 %>
											</td>
										</tr>
										<tr>
											<th>ID</th>
											<td><%=member.getID()%></td>
										</tr>



										<tr>
											<th colspan="2"><a href="manager_update.jsp?id=<%=id%>"
												class="btn btn-primary">수정</a> <a href="manager.jsp"
												class="btn btn-primary">목록</a> <input id="reset"
												type="submit" value="비밀번호 초기화" class="btn btn-primary">
											</th>
										</tr>

									</table>
								</form>
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