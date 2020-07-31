<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.io.PrintWriter"
    import = "jsp.sheet.method.*"
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
	
%>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Sure FVMS - Manager_Schedule_Update</title>

  <!-- Custom fonts for this template-->
  <link href="../../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="../../https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="../../css/sb-admin-2.min.css" rel="stylesheet">

</head>
<style>
	
	#table_td{
		padding-left: 10px;
		padding-top: 10px;
		display:grid !important;
		padding-bottom: 10px;
	}
	
	details p{
    padding-left:12px !important;
    margin:3px 0px !important;
	}
	summary{
    border: 1px solid black;
    border-radius: 5px;
    padding: 6px;
	}
	.m-0.font-weight-bold.text-primary{
		display:inline-block;
		padding-left: 17px;
		vertical-align: middle;
	}
              
	#holiday_body{
		text-align: center;
		position: absolute;
		top: -36px;
		left: 50%;
		transform: translateX(-50%);
	}

	#Delete{
		float:right;
		width: 50px;
		height: 30px;
	}
	
	#Update{
		position: absolute;
		left:42%;
		transform: translateX(-50%);
	}
	
	#cancel_btn{
		position: absolute;
		left:45%;
		transform: translateX(-50%);
		margin-left:55px;
	}
	
	#holiday{
		color:white; 
		border:0px solid;
		border-radius: 6px;
		height:52px;
		font-weight: 700;
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
	
	@media(max-width:800px){
		.container-fluid{
			padding: 0;
		}
		.card-header:first-child{
			padding: 0;
		}
		#Delete{
		margin-right: 15px;
		}
}
</style>
<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript">
var array=["linear-gradient(to right,#8766b0eb 100%,#5d9cb1)","linear-gradient(to right,#8766b0eb 49%,#5d9cb1)",
	  "linear-gradient(to right,#8766b0eb 34%,#5d9cb1","linear-gradient(to right,#8766b0,#5d9cb1)",
	   "linear-gradient(to right,#8766b0eb -22%,#5d9cb1)","linear-gradient(to right,#8766b0eb -52%,#5d9cb1)"];
	 var cnt=0;
	 function ff(){
	  if(cnt==6) cnt=0;
	  holiday.style.background=array[cnt++];
	  setTimeout("ff()",200);
	 }

	 
	 function AMfocus(){
	  document.getElementById('AMradio').checked=true;
	 }
	 function PMfocus(){
	  document.getElementById('PMradio').checked=true;
	 }
	 
	 
	<!-- 로딩화면 -->
	 window.onbeforeunload = function () { $('.loading').show(); }  //현재 페이지에서 다른 페이지로 넘어갈 때 표시해주는 기능
	 $(window).load(function () {          //페이지가 로드 되면 로딩 화면을 없애주는 것
	     $('.loading').hide();
	     ff();
	 });

		$(function(){
			$("#amselboxDirect").hide();
			var se = document.getElementById("amPlaceSel");
			if(se.options[se.selectedIndex].value == "기타"){
					$("#amselboxDirect").show();
			}else{
				$("#amselboxDirect").hide();
			}
			$("#amPlaceSel").change(function() {
					if($("#amPlaceSel").val() == "기타") {
						$("#amselboxDirect").show();
					}  else {
						$("#amselboxDirect").hide();
					}
			})
		});
		
		$(function(){
			var se = document.getElementById("pmPlaceSel");
			if(se.options[se.selectedIndex].value == "기타"){
				$("#pmselboxDirect").show();
			}else{
				$("#pmselboxDirect").hide();
			}
			$("#pmPlaceSel").change(function() {
					if($("#pmPlaceSel").val() == "기타") {
						$("#pmselboxDirect").show();
					}  else {
						$("#pmselboxDirect").hide();
					}
			})
		});

		function amChangeSel() {
			var se = document.getElementById("amPlaceSel");
			if(se.options[se.selectedIndex].value != "기타"){
				$("#amselboxDirect").val("");
			}
		}
		function pmChangeSel() {
			var se = document.getElementById("pmPlaceSel");
			if(se.options[se.selectedIndex].value != "기타"){
				$("#pmselboxDirect").val("");
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
	<%
		request.setCharacterEncoding("UTF-8");
		String num = request.getParameter("num");
		String setDate = request.getParameter("date");
		String setAm = request.getParameter("amPlace");
		String setPm = request.getParameter("pmPlace");
		
		
	%>
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
	          <a class="nav-link" href="../mypage/mypage.jsp">
	          <i class="fas fa-fw fa-table"></i>
	          <span>마이페이지</span></a>
	     	</li>
	     	
			<!-- Nav Item - summary -->
		    <li class="nav-item">
	          <a class="nav-link" href="../summary/summary.jsp">
	          <i class="fas fa-fw fa-table"></i>
	          <span>요약정보</span></a>
	     	</li>
      
       		<!-- Nav Item - project -->
      		<li class="nav-item">
     	     <a class="nav-link" href="../project/project.jsp">
             <i class="fas fa-fw fa-clipboard-list"></i>
             <span>프로젝트</span></a>
     	    </li>
      
		    <!-- Nav Item - rowdata -->
		    <li class="nav-item">
		      <a class="nav-link" href="../rowdata/rowdata.jsp">
		      <i class="fas fa-fw fa-chart-area"></i>
		      <span>멤버</span></a>
     		</li>
     		
	      <!-- Nav Item - schedule -->
	      <li class="nav-item ">
	        <a class="nav-link" href="../schedule/schedule.jsp">
	        <i class="fas fa-fw fa-calendar"></i>
	        <span>스케줄</span></a>
	      </li>
	      
	      <!-- Nav Item - manager schedule -->
	      <li class="nav-item active">
	        <a class="nav-link" href="../manager_schedule/manager_schedule.jsp">
	        <i class="fas fa-fw fa-calendar"></i>
	        <span>관리자 스케줄</span></a>
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
                
                  <h6 class="m-0 font-weight-bold text-primary"><%=sessionName%> 일정수정</h6>
                  <form method="post" action="manager_schedule_deletePro.jsp" style="display: inline !important;">
				 	<input type="hidden" name = "num" value="<%=num%>">
				 	<input id="Delete" type="submit" name="Delete" value=삭제 class="btn btn-secondary btn-icon-split">
				 </form>
                </div>
               <div class="card-body" style="margin-bottom:52px;">
	  		<div class="table-responsive"> 

	
   <form method ="post" action = "manager_schedule_updatePro.jsp?" style="display: inline;"> 
   <table style="white-space: nowrap; overflow:hidden;width:100%;">
     <tr>
      <td class="m-0 text-primary" align="center">날짜 </td>
      <td style="padding: 15px 0;"><input type="date" name="DATE" style=width:100%; maxlength="50" value ="<%=setDate%>"></td>
     </tr>
     <tr height="1" bgcolor="#fff"><td colspan="2"></td></tr>
     <tr height="1" bgcolor="#82B5DF"><td colspan="2"></td></tr>
     <tr>
      <td class="m-0 text-primary" align="center" style="white-space: nowrap;">오전장소 </td>
     <td id="table_td">
    	<select id="amPlaceSel" name="amPlaceSel"  onchange="amChangeSel()">
  				<option value="슈어(본사,삼성)"
					<% if(setAm.equals("슈어(본사,삼성)")){%>selected="selected"<%}%>>슈어(본사,삼성)</option>
  				<option value="슈어(남양사무실)"
					<% if(setAm.equals("슈어(남양사무실)")){%>selected="selected"<%}%>>슈어(남양사무실)</option>
 				<option value="슈어(대전사무실)"
					<% if(setAm.equals("슈어(대전사무실)")){%>selected="selected"<%}%>>슈어(대전사무실)</option>
 				<option value="HMC(남양연구소)"
					<% if(setAm.equals("HMC(남양연구소)")){%>selected="selected"<%}%>>HMC(남양연구소)</option>
 				<option value="오트론(삼성)"
					<% if(setAm.equals("오트론(삼성)")){%>selected="selected"<%}%>>오트론(삼성)</option>
 				<option value="모비스(의왕)"
					<% if(setAm.equals("모비스(의왕)")){%>selected="selected"<%}%>>모비스(의왕)</option>
 				<option value="모비스(마북)"
					<% if(setAm.equals("모비스(마북)")){%>selected="selected"<%}%>>모비스(마북)</option>
 				<option value="엠엔소프트(용산)"
					<% if(setAm.equals("엠엔소프트(용산)")){%>selected="selected"<%}%>>엠엔소프트(용산)</option>
 				<option value="트랜시스(남양)"
					<% if(setAm.equals("트랜시스(남양)")){%>selected="selected"<%}%>>트랜시스(남양)</option>
 				<option value="휴가"
					<% if(setAm.equals("휴가")){%>selected="selected"<%}%>>휴가</option>
 				<option value="기타" 
					<% if(!(setAm.equals("슈어(본사,삼성)") || setAm.equals("슈어(남양사무실)") || setAm.equals("슈어(대전사무실)") || setAm.equals("HMC(남양연구소)") || setAm.equals("오트론(삼성)")
    					|| setAm.equals("모비스(의왕)") || setAm.equals("모비스(마북)") || setAm.equals("엠엔소프트(용산)") || setAm.equals("휴가") || setAm.equals("트랜시스(남양)")))
    					{%>selected="selected"<%}%>>기타</option>
			</select>
			<input type="text" id="amselboxDirect" name="amselboxDirect" <% if(!(setAm.equals("슈어(본사,삼성)") || setAm.equals("슈어(남양사무실)") || setAm.equals("슈어(대전사무실)") || setAm.equals("HMC(남양연구소)") || setAm.equals("오트론(삼성)")
    					|| setAm.equals("모비스(의왕)") || setAm.equals("모비스(마북)") || setAm.equals("엠엔소프트(용산)") || setAm.equals("휴가") || setAm.equals("트랜시스(남양)")))
    					{%>value = "<%=setAm%>"<%}%>/>
      </td>
     </tr>
       <tr height="1" bgcolor="#82B5DF"><td colspan="2"></td></tr>
      <tr>
      <td class="m-0 text-primary" align="center" style="white-space: nowrap;">오후장소</td>
      <td id="table_td">
      	<select id="pmPlaceSel" name="pmPlaceSel" onchange="pmChangeSel()">
  				<option value="슈어(본사,삼성)" 
					<% if(setPm.equals("슈어(본사,삼성)")){%>selected="selected"<%}%>>슈어(본사,삼성)</option>
  				<option value="슈어(남양사무실)"
					<% if(setPm.equals("슈어(남양사무실)")){%>selected="selected"<%}%>>슈어(남양사무실)</option>
 				<option value="슈어(대전사무실)"
					<% if(setPm.equals("슈어(대전사무실)")){%>selected="selected"<%}%>>슈어(대전사무실)</option>
 				<option value="HMC(남양연구소)"
					<% if(setPm.equals("HMC(남양연구소)")){%>selected="selected"<%}%>>HMC(남양연구소)</option>
 				<option value="오트론(삼성)"
					<% if(setPm.equals("오트론(삼성)")){%>selected="selected"<%}%>>오트론(삼성)</option>
 				<option value="모비스(의왕)"
					<% if(setPm.equals("모비스(의왕)")){%>selected="selected"<%}%>>모비스(의왕)</option>
 				<option value="모비스(마북)"
					<% if(setPm.equals("모비스(마북)")){%>selected="selected"<%}%>>모비스(마북)</option>
 				<option value="엠엔소프트(용산)"
					<% if(setPm.equals("엠엔소프트(용산)")){%>selected="selected"<%}%>>엠엔소프트(용산)</option>
 				<option value="트랜시스(남양)"
					<% if(setPm.equals("트랜시스(남양)")){%>selected="selected"<%}%>>트랜시스(남양)</option>
 				<option value="휴가"
					<% if(setPm.equals("휴가")){%>selected="selected"<%}%>>휴가</option>
 				<option value="기타" 
					<% if(!(setPm.equals("슈어(본사,삼성)") || setPm.equals("슈어(남양사무실)") || setPm.equals("슈어(대전사무실)") || setPm.equals("HMC(남양연구소)") || setPm.equals("오트론(삼성)")
    					|| setPm.equals("모비스(의왕)") || setPm.equals("모비스(마북)") || setPm.equals("엠엔소프트(용산)") || setPm.equals("휴가") || setPm.equals("트랜시스(남양)")))
    					{%>selected="selected"<%}%>>기타</option>
			</select>
			<input type="text" id="pmselboxDirect" name="pmselboxDirect" <% if(!(setPm.equals("슈어(본사,삼성)") || setPm.equals("슈어(남양사무실)") || setPm.equals("슈어(대전사무실)") || setPm.equals("HMC(남양연구소)") || setPm.equals("오트론(삼성)")
    					|| setPm.equals("모비스(의왕)") || setPm.equals("모비스(마북)") || setPm.equals("엠엔소프트(용산)") || setPm.equals("휴가") || setPm.equals("트랜시스(남양)")))
    					{%>value = "<%=setPm%>"<%}%>/>
      </td>
     </tr>
     <tr height="1" bgcolor="#fff"><td colspan="2"></td></tr>
     </table>
     
 	<input type="hidden" name = "num" value="<%=num%>">
   	<input id="Update" type="submit" name="COMPLETE" value="수정" class="btn btn-primary" >
</form>

	 
       <a href="manager_schedule.jsp" class="btn btn-primary" id="cancel_btn">취소</a>
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

