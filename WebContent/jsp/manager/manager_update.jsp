<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="java.util.ArrayList" import="jsp.Bean.model.*"
	import="jsp.DB.method.*"%>
<!DOCTYPE html>
<html lang="en">

<head>
<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript">


$(window).load(function () {          //페이지가 로드 되면 로딩 화면을 없애주는 것
    $('.loading').hide();
});
</script>
<%
	PrintWriter script =  response.getWriter();
	if (session.getAttribute("sessionID") == null){
		script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
	}
	
	String sessionID = session.getAttribute("sessionID").toString();
	String sessionName = session.getAttribute("sessionName").toString();
	session.setMaxInactiveInterval(60*60);
	String id = request.getParameter("id");
	MemberDAO memberDao = new MemberDAO();
	int permission = Integer.parseInt(session.getAttribute("permission").toString());
	ProjectDAO projectDao = new ProjectDAO();
	ArrayList<String> teamList = projectDao.getTeamData();
	MemberBean member = memberDao.returnMember(id);
	
%>

<script>
	$(document).ready(function(){
		$("#team").val("<%=member.getTEAM()%>").prop("selected", true);		
		$("#permission").val("<%=member.getPermission()%>").prop("selected", true);
	});
	
</script>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Sure FVMS - manager_Update</title>

<!-- Custom fonts for this template-->
<link href="../../vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="../../https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="../../css/sb-admin-2.min.css" rel="stylesheet">

</head>
<style>
.sidebar{
		position:fixed;
		z-index:9999;
	}
.update_input {
	width: 100%;
}
.container-fluid{
	margin-right:0;
	width:94%;
}
input {
	border: 1px solid #d1d3e2;
	border-radius: 4px;
}

textarea {
	border: 1px solid #d1d3e2;
	border-radius: 4px;
}

#dataTable td:nth-child(odd) {
	text-align: center;
	vertical-align: middle;
	word-break: keep-all;
	width: 20%;
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
	.card-header{
		margin-top:4.75rem;
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
	body {
		font-size: small;
	}
}
</style>
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
			
			<button id="sidebarToggle" class="rounded-circle border-0" style="margin-left:30px; margin-top:10px">
						
					</button>
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
			<li class="nav-item"><a class="nav-link"
				href="../schedule/schedule.jsp"> <i
					class="fas fa-fw fa-calendar"></i> <span>엔지니어 스케줄</span></a></li>

			<li class="nav-item"><a class="nav-link"
				href="../project_schedule/project_schedule.jsp"> <i
					class="fas fa-fw fa-calendar"></i> <span>프로젝트 스케줄</span></a></li>
					
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
							<h6 class="m-0 font-weight-bold text-primary"
								style="padding-left: 17px;"><%=member.getNAME()%>
								정보 수정
							</h6>
						</div>
						<div class="card-body">

							<div class="table-responsive">
								<form method="post" action="manager_updatePro.jsp">
									<input type="hidden" name="id" value="<%=id%>">
									<table class="table table-bordered" id="dataTable">
										<tr>
											<td class="m-0 text-primary" align="center">소속</td>
											<td colspan="3"><input name="part"
												value="<%=member.getPART()%>" class="update_input"></td>
										</tr>

										<tr>
											<td class="m-0 text-primary" align="center">팀</td>
											<td colspan="3"><select id="team" name="team">
													<%
                      		for(int i=0; i<teamList.size(); i++){
                      			%><option value="<%=teamList.get(i)%>"><%=teamList.get(i)%></option>
													<%
                      		}
                      	%>
											</select></td>
										</tr>
										<tr>
											<td class="m-0 text-primary" align="center">권한</td>
											<td colspan="3"><select id="permission"
												name="permission">
													<option value="0">마스터</option>
													<option value="1">관리자</option>
													<option value="2">일반</option>
													<option value="3">게스트</option>
											</select></td>
										</tr>
										<tr>
											<td class="m-0 text-primary" align="center">직급</td>
											<td colspan="3"><input name="rank"
												value="<%=member.getRANK()%>" class="update_input"></td>
										</tr>
										<tr>
											<td class="m-0 text-primary" align="center">직책</td>
											<td colspan="3"><input name="position"
												value="<%=member.getPosition()%>" class="update_input"></td>
										</tr>
										<tr>
											<td class="m-0 text-primary" align="center">moblie</td>
											<td colspan="3"><input name="mobile"
												value="<%=member.getMOBILE()%>" class="update_input"></td>
										</tr>
										<tr>
											<td class="m-0 text-primary" align="center">gmail</td>
											<td colspan="3"><input name="gmail"
												value="<%=member.getGMAIL()%>" class="update_input"></td>
										</tr>
										<tr>
											<td class="m-0 text-primary" align="center">거주지</td>
											<td colspan="3"><input name="address"
												value="<%=member.getADDRESS()%>" class="update_input"></td>
										</tr>
										<tr>
											<td class="m-0 text-primary" align="center"
												style="word-break: keep-all;">입사일</td>
											<td colspan="3"><input name="comDate"
												value="<%=member.getComDate()%>" class="update_input"></td>
										</tr>
										<tr>
											<td class="m-0 text-primary" align="center"
												style="word-break: keep-all;">연차</td>
											<td colspan="3"><input name="wyear"
												value="<%=member.getWyear()%>" class="update_input"></td>
										</tr>
										<tr>
											<td class="m-0 text-primary" align="center"
												style="vertical-align: middle;">프로젝트 수행 이력</td>
											<td colspan="3"><input name="career"
												value="<%=member.getCareer()%>" class="update_input"></td>
										</tr>
										<tr align="center">
											<td colspan="4"><input id="COMPLETE" type="submit"
												name="COMPLETE" value="완료" class="btn btn-primary">
												<a href="manager.jsp" class="btn btn-primary">취소</a></td>
										</tr>
									</table>
								</form>
							</div>
							<!-- /.container-fluid -->

						</div>
						<!-- End of Main Content -->
					</div>

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