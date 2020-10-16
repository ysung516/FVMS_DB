<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.io.PrintWriter"
    import = "java.util.ArrayList"
    import = "jsp.DB.method.*"
    import = "jsp.Bean.model.*"
    %>
<!DOCTYPE html>
<html lang="en">

<head>

<%
	PrintWriter script =  response.getWriter();
	if (session.getAttribute("sessionID") == null){
		script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
	}
	int permission = Integer.parseInt(session.getAttribute("permission").toString());
	if(permission > 2){
		script.print("<script> alert('접근 권한이 없습니다.'); history.back(); </script>");
	}
	session.setMaxInactiveInterval(60*60);
	String sessionID = session.getAttribute("sessionID").toString();
	String sessionName = session.getAttribute("sessionName").toString();
	
	ReportDAO reportDao = new ReportDAO();
	ArrayList<ReportBean> reportList = reportDao.loadData();
	ProjectDAO projectDao = new ProjectDAO();
	int no = Integer.parseInt(request.getParameter("no"));
	int projectNo = Integer.parseInt(request.getParameter("projectNo"));
	ReportBean report = reportDao.getReportBean(no);
	ProjectBean project = projectDao.getProjectBean_no(projectNo);
	String str = "";
	
	ReportBean backupReport = reportDao.getReportBackUp(projectNo);
	
	if(!(project.getWORKER_LIST().contains(sessionID) || project.getPROJECT_MANAGER().equals(sessionID))){
		script.print("<script> alert('해당 프로젝트 관계자가 아닙니다.'); history.back(); </script>");
	}
	
	String [] line;
	
%>
<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript">
	function loadData(){
		$('#PreWeekPlan').val('');
		$('#PreWeekPro').val('');
		$('#PreNextPlan').val('');
		$('#Prespecialty').val('');
		$('#Prenote').val('');

		<%for(int a=0; a<backupReport.getP_weekPlan().length; a++){
			str = backupReport.getP_weekPlan()[a].replaceAll("\\s+$","");
			if(str.contains("\"")){
				str = str.replaceAll("\"", "\'");
			}
			if (str.contains("\'")){%>
				var str = "<%=str%>";
				var str_ch = str.replace("'", "\'");
			<%}else{%>
				var str_ch = "<%=str%>";
			<%}%>
			document.getElementById('PreWeekPlan').value += str_ch + '\n';
		<%}
		for(int b=0; b<backupReport.getP_weekPro().length; b++){
			str = backupReport.getP_weekPro()[b].replaceAll("\\s+$","");
			if(str.contains("\"")){
				str = str.replaceAll("\"", "\'");
			}
			if (str.contains("\'")){%>
				var str = "<%=str%>";
				var str_ch = str.replace("'", "\'");
			<%}else{%>
				var str_ch = "<%=str%>";
			<%}%>
			document.getElementById('PreWeekPro').value += str_ch + '\n';
		<%}		
		for(int c=0; c<backupReport.getP_nextPlan().length; c++){
			str = backupReport.getP_nextPlan()[c].replaceAll("\\s+$","");
			if(str.contains("\"")){
				str = str.replaceAll("\"", "\'");
			}
			if (str.contains("\'")){%>
				var str = "<%=str%>";
				var str_ch = str.replace("'", "\'");
			<%}else{%>
				var str_ch = "<%=str%>";
			<%}%>
			document.getElementById('PreNextPlan').value += str_ch + '\n';
		<%}
		for(int d=0; d<backupReport.getP_specialty().length; d++){
			str = backupReport.getP_specialty()[d].replaceAll("\\s+$","");
			if(str.contains("\"")){
				str = str.replaceAll("\"", "\'");
			}
			if (str.contains("\'")){%>
				var str = "<%=str%>";
				var str_ch = str.replace("'", "\'");
			<%}else{%>
				var str_ch = "<%=str%>";
			<%}%>
			document.getElementById('Prespecialty').value += str_ch + '\n';
		<%}
		for(int e=0; e<backupReport.getP_note().length; e++){
			str = backupReport.getP_note()[e].replaceAll("\\s+$","");
			if(str.contains("\"")){
				str = str.replaceAll("\"", "\'");
			}
			if (str.contains("\'")){%>
				var str = "<%=str%>";
				var str_ch = str.replace("'", "\'");
			<%}else{%>
				var str_ch = "<%=str%>";
			<%}%>
			document.getElementById('Prenote').value += str_ch + '\n';
		<%}%>
		}
	
	$(window).load(function () {          //페이지가 로드 되면 로딩 화면을 없애주는 것
	    $('.loading').hide();
		loadData();
	});
		
</script>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Sure FVMS - Report_update</title>

  <!-- Custom fonts for this template-->
  <link href="../../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="../../https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="../../css/sb-admin-2.min.css" rel="stylesheet">

</head>
<style>
.sidebar{
		position:fixed;
		z-index:9999;
	}
	#content{
		margin-left:90px;
	}
	.m-0 .text-primary{
		vertical-align:middle;
		text-align:center;
	}
	select{
		width:100%;
	}
	#name{
		width:100%;
	}
	
	textarea{
		width:100%;
	}
	.loading{
		position:fixed;
		text-align: center;
		width:100%;
		height:100%;
		top:0;
		left:0;
		font-size:8px;
		background-color: #4e73df6b;
  	  	background-image: linear-gradient(181deg,#3d5482 16%,#6023b654 106%);
  	  	background-size: cover;
        z-index:1000;
        color:#ffffffc4;
	}
	.loading #load{
		position:fixed;
		top:50%;
		left: 50%;
		transform:translate(-50%, -50%);
	}
	@media(max-width:765px){
		.card-header{
		margin-top:4.75rem;
	}
	.topbar{
		z-index:999;
		position:fixed;
		width:100%;
		}
	#content{
		margin-left:0px;
	}
		.container-fluid{
			padding: 0;
		}
		.card-header:first-child{
			padding: 0;
		}
		
		body{
		font-size:small;}
}

 fieldset{
	  border: 3px inset;
	  border-color: #5d7ace;  
	  margin-bottom: 15px;        	
  }
  
  legend{
  	color:#1b3787!important;
  	font-size: 18px;
  	font-weight: 600;
  	width: auto;
  	padding: 5px;
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
			<li class="nav-item active"><a class="nav-link"
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

			

		</ul>
		<!-- End of Sidebar -->
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

          <!-- Sidebar Toggle (Topbar) -->
          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>

         

          <!-- Topbar Navbar -->
          <ul class="navbar-nav ml-auto">

        

            <div class="topbar-divider d-none d-sm-block"></div>

            <!-- Nav Item - User Information -->
            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small"><%=sessionName%></span>
                <i class="fas fa-info-circle"></i>
              </a>
              <!-- Dropdown - User Information -->
              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                  <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                  Logout
                </a>
              </div>
            </li>

          </ul>

        </nav>
        <!-- End of Topbar -->

        <!-- Begin Page Content -->
        <div class="container-fluid">

	   <div class="card shadow mb-4">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary" style="padding-left: 17px;">주간보고서 수정</h6>
                </div>
                 <div class="card-body">
           
                 <div class="table-responsive">
		<form method = "post" action = "report_updatePro.jsp">
		    <input type="hidden" name="no" value="<%=no%>">
		   <table class="table table-bordered" id="dataTable">
		     <tr>
		      <td class="m-0 text-primary" align="center" style="word-break: keep-all;">프로젝트</td>
		      <td name="projectName"><%=report.getTitle()%></td>
		     </tr>

		    <tr>
		      <td class="m-0 text-primary" align="center">작성자</td>
		      <td name="writer"><%=report.getName()%></td>
		     </tr>  
		     
		    <tr>
		    <td colspan="1" class="m-0 text-primary"><h6>(전)금주계획</h6> 
		    <textarea id="PreWeekPlan" rows="10" readonly></textarea></td>
		    
		      <td colspan="2" class="m-0 text-primary"><h6>금주계획</h6>
		      <textarea name="WeekPlan" rows="10"><%
		      	 line = report.getP_weekPlan();
		      	 for(String li : line){
						%><%=li%><%
					}%></textarea></td>
		     </tr>
		      <tr>
		      <td colspan="1" class="m-0 text-primary"><h6>(전)금주진행</h6> 
		      <textarea id="PreWeekPro" rows="25" readonly></textarea></td>
		      
		      <td colspan="2" class="m-0 text-primary"><h6>금주진행</h6>
		      <textarea name="WeekPro" rows="25"><%
		      	 line = report.getP_weekPro();
		      	 for(String li : line){
						%><%=li%><%
					}%></textarea></td>
		     </tr>
		      <tr>
		      <td colspan="1" class="m-0 text-primary"><h6>(전)차주계획</h6> 
		      <textarea id="PreNextPlan" rows="10" readonly></textarea></td>
		      
		      <td colspan="2" class="m-0 text-primary"><h6>차주계획</h6>
		      <textarea name="NextPlan" rows="10" wrap="hard"><%
		      	 line = report.getP_nextPlan();
		      	 for(String li : line){
						%><%=li%><%
					}%></textarea></td>
		     </tr>
		      <tr>
		      <td colspan="1" class="m-0 text-primary"><h6>(전)특이사항</h6> 
		      <textarea id="Prespecialty" rows="10" readonly></textarea></td>
		      
		      <td colspan="2" class="m-0 text-primary"><h6>특이사항</h6>
		      <textarea name="specialty" rows="10"><%
		      	 line = report.getP_specialty();
		      	 for(String li : line){
						%><%=li%><%
					}%></textarea></td>
		     </tr>
		      <tr>
		      <td colspan="1" class="m-0 text-primary"><h6>(전)비고</h6> 
		      <textarea id="Prenote" rows="5" readonly></textarea></td>
		      
		      <td colspan="2" class="m-0 text-primary"><h6>비고</h6>
		      <textarea name="note" rows="5"><%
		      	 line = report.getP_note();
		      	 for(String li : line){
						%><%=li%><%
					}%></textarea></td>
		     </tr>
		
		     <tr align="center">
		      <td colspan="2"> 
		      <input id="COMPLETE" type="submit" name="COMPLETE" value="완료"  class="btn btn-primary" >
		       <a href="report.jsp" class="btn btn-primary">취소</a>
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
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

<!-- Logout Modal-->
 <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
   <div class="modal-content">
    <div class="modal-header">
     <h5 class="modal-title" id="exampleModalLabel">로그아웃 하시겠습니까?</h5>
     <button class="close" type="button" data-dismiss="modal" aria-label="Close">
      <span aria-hidden="true">×</span>
     </button>
    </div>
    <div class="modal-body">확인버튼을 누를 시 로그아웃 됩니다.</div>
    <div class="modal-footer">
     <button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
    <form method = "post" action = "../LogoutPro.jsp">
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
