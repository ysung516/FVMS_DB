<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.io.PrintWriter"
    import = "jsp.sheet.method.*"
    import = "jsp.Bean.model.*"
    import = "java.util.ArrayList"
    import = "java.util.List"
    %>
<!DOCTYPE html>
<html lang="en">

<head>
	<%
		PrintWriter script =  response.getWriter();
		if (session.getAttribute("sessionID") == null){
			script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../../html/login.html' </script>");
		}
	
		String sessionID = session.getAttribute("sessionID").toString();
		String sessionName = session.getAttribute("sessionName").toString();
		session.setMaxInactiveInterval(15*60);
		String NO = request.getParameter("no");
		sheetMethod method = new sheetMethod();
		BoardBean board = method.get_DayBoard(NO);
		
		// 출력
		String [] line;
		
	%>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Sure FVMS - Report_view</title>

  <!-- Custom fonts for this template-->
  <link href="../../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="../../https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="../../css/sb-admin-2.min.css" rel="stylesheet">

</head>
<style>
	@media(max-width:800px){
		.container-fluid{
			padding: 0;
		}
		.card-header:first-child{
			padding: 0;
		}
}
</style>

<body id="page-top">

  <!-- Page Wrapper -->
  <div id="wrapper">

    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion toggled" id="accordionSidebar">

      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="../summary/summary.jsp">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Sure FVMS</div>
      </a>

    <!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - summary -->
		    <li class="nav-item">
	          <a class="nav-link" href="../summary/summary.jsp">
	          <i class="fas fa-fw fa-table"></i>
	          <span>요약정보</span></a>
	     	</li>
      
       		<!-- Nav Item - project -->
      		<li class="nav-item ">
     	     <a class="nav-link" href="../project/project.jsp">
             <i class="fas fa-fw fa-clipboard-list"></i>
             <span>프로젝트</span></a>
     	    </li>
      
		    <!-- Nav Item - rowdata -->
		    <li class="nav-item">
		      <a class="nav-link" href="../rowdata/rowdata.jsp">
		      <i class="fas fa-fw fa-chart-area"></i>
		      <span>인력</span></a>
     		</li>
     		
	      <!-- Nav Item - schedule -->
	      <li class="nav-item">
	        <a class="nav-link" href="../schedule/schedule.jsp">
	        <i class="fas fa-fw fa-calendar"></i>
	        <span>스케줄</span></a>
	      </li>
		
		 <!-- Nav Item - manager schedule -->
	      <li class="nav-item">
	        <a class="nav-link" href="../manager_schedule/manager_schedule.jsp">
	        <i class="fas fa-fw fa-calendar"></i>
	        <span>관리자 스케줄</span></a>
	      </li>
		<!-- Nav Item - dayreport -->
			<li class="nav-item active">
			  <a class="nav-link" href="../day_report/day_report.jsp">
			  <i class="fas fa-fw fa-clipboard-list"></i> 
			  <span>일간보고서</span></a>
			</li>
			
		  <!-- Nav Item - report -->
			<li class="nav-item">
			  <a class="nav-link" href="../report/report.jsp">
			  <i class="fas fa-fw fa-clipboard-list"></i> 
			  <span>주간보고서</span></a>
			</li>
			
			<!-- Nav Item - meeting -->
			<li class="nav-item">
			  <a class="nav-link" href="../meeting/meeting.jsp">
			  <i class="fas fa-fw fa-clipboard-list"></i> 
			  <span>회의록</span></a>
			</li>
      
      
     

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
	         <h6 class="m-0 font-weight-bold text-primary" style="padding-left: 17px;">일간보고서 조회</h6>
	        </div>
	        <div class="card-body">
 		<div class="table-responsive">
   			<table style="/* white-space: nowrap; */width:100%;word-break: keep-all;margin-bottom: 10px;">
		     <tr>
		      <td class="m-0 text-primary" align="center">제목</td>
		      <td style="padding: 15px;"><%=board.getTitle() %></td>
		     </tr>
		     <tr height="1" bgcolor="#82B5DF"><td colspan="2" ></td>
		     </tr>
		  
		   <tr height="1" border-top-color="#82B5DF">
		      <td class="m-0 text-primary" align="center">작성자</td>
		      <td style="padding: 15px;"><%=board.getName()%></td>
		     </tr>
		     
		    <tr height="1" border-top-color="#82B5DF">
		      <td class="m-0 text-primary" align="center">작성일</td>
		      <td style="padding: 15px;"><%=board.getDate()%></td>
		     </tr>
		     
		     <tr height="1" bgcolor="#82B5DF"><td colspan="2"></td></tr>
		     
		     <tr>
		      <td class="m-0 text-primary" align="center">금일계획</td>
		      <td style="padding: 15px;"><%
		      	line = board.getP_weekPlan();
		      	for(String li : line){
		      		%><p><%=li%></p><%
		      	}
		      %></td>
		     </tr>
		      <tr height="1" bgcolor="#82B5DF"><td colspan="2"></td></tr>
		      <tr>
		   
		      <td class="m-0 text-primary" align="center">금일진행</td>
		      <td style="padding: 15px;"><%
		      	line = board.getP_weekPro();
		      	for(String li : line){
		      		%><p><%=li%></p><%
		      	}
		      %></td>
		
		     </tr>
		      <tr height="1" bgcolor="#82B5DF"><td colspan="2"></td></tr>
		      <tr>
		      <td class="m-0 text-primary" align="center";>차일계획</td>
		      <td style="padding: 15px;"><%
		      	line = board.getP_nextPlan();
		      	for(String li : line){
		      		%><p><%=li%></p><%
		      	} 
		      %></td>
		     
		     </tr>  
		     <tr height="1" bgcolor="#82B5DF"><td colspan="2"></td></tr>
		    </table>
		    </div>
		     <table style="margin: 0 auto;">
		     <tr>
		     <td colspan="2">
		     <input id="Delete" type="button" name="Delete" value="삭제"  class="btn btn-primary" >
		       <a href="day_report.jsp" class="btn btn-primary">목록</a>
		       </td>
		     </tr>
		   
		       </table>
     </div>
             <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

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
     <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
     <button class="close" type="button" data-dismiss="modal" aria-label="Close">
      <span aria-hidden="true">×</span>
     </button>
    </div>
    <div class="modal-body">Select "Logout" below if you are ready  to end your current session.</div>
    <div class="modal-footer">
     <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
    <form method = "post" action = "../LogoutPro.jsp">
     	  <input type="submit" class="btn btn-primary" value="Logout" />
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
