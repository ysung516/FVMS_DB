<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.io.PrintWriter"
    import = "java.util.ArrayList"
    import = "jsp.Bean.model.*"
    import = "jsp.DB.method.*"
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
	session.setMaxInactiveInterval(60*60);
	ProjectDAO projectDao = new ProjectDAO();
	ArrayList<String> teamList = projectDao.getTeamData();
	MemberDAO memberDao = new MemberDAO();
	int permission = Integer.parseInt(session.getAttribute("permission").toString());
	ArrayList<MemberBean> memberList = new ArrayList<MemberBean>();
	memberList = memberDao.getMemberData();
	
%>
<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript">
	$(window).load(function () {
		$('.loading').hide();
	});
	
	
	var idList = new Array();
	<%
		for(int i=0; i<memberList.size(); i++){
			%>idList[<%=i%>] = '<%=memberList.get(i).getID()%>';<%
		}%>
	
	
	var count = 0;
	//ID 중복확인 버튼클릭 시
	function button_onclick(){
		for(var a=0; a<idList.length; a++){
			if($('#id').val().length < 3){
				count = -1;
				break;
			}
			if($('#id').val() == idList[a]){
				count = 0;
				break;
			} else{
				count = 1;
			}
		}
		if(count == 0){
			alert("이 아이디는 사용하실 수 없습니다.")
		} else if (count == 1){
			alert("사용가능한 아이디 입니다.")
		} else if(count == -1){
			alert("아이디 최소길이가 3글자 이상이여야 합니다.")
		}
	}
	// 정보등록 확인 버튼 클릭 시 
	function button_onclick2(){
		if(count != 1){
			
			alert("ID중복체크를 해주세요");	
		}
		else if(count == 1){
			console.log(count);
			document.addPro.submit();
		}
	}
	
	function btn_insert(){
		var copyID = sessionStorage.getItem("copyID");
		var member_ID = new Array();
		var member_team = new Array();
		var member_rank = new Array();
		var member_position = new Array();
		var member_permission = new Array();
		
		var cnt = -1;
		<%
			for(int z=0; z<memberList.size(); z++){
				%>member_ID[<%=z%>] = '<%=memberList.get(z).getID()%>'
				  member_team[<%=z%>] = '<%=memberList.get(z).getTEAM()%>'
				  member_rank[<%=z%>] = '<%=memberList.get(z).getRANK()%>'
				  member_position[<%=z%>] = '<%=memberList.get(z).getPosition()%>'
				  member_permission[<%=z%>] = '<%=memberList.get(z).getPermission()%>'
		<%}%>
		
		for(var a=0; a<member_ID.length; a++){
			if(member_ID[a] == copyID){
				cnt = a;
			}
		}
		
		if(cnt != -1){
			console.log(member_rank[cnt]);
			$('#team').val(member_team[cnt]);
			$('#rank').val(member_rank[cnt]);
			$('#position').val(member_position[cnt]);
			$('#permission').val(member_permission[cnt]);
		}

	}
	
</script>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Sure FVMS - manager_add</title>

  <!-- Custom fonts for this template-->
  <link href="../../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="../../https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="../../css/sb-admin-2.min.css" rel="stylesheet">

</head>
<style>

	.btn_group{
		right: 0;
		margin-right: 24px; 
		display: inline-block; 
		position: absolute; 
		top: 9px;
	}
	.add_input{
		width:100%;
	}
	input{
    border: 1px solid #d1d3e2;
    border-radius: 4px;
	}
	textarea{
    border: 1px solid #d1d3e2;
    border-radius: 4px;
	}
	#dataTable td:nth-child(odd){
    text-align: center;
    vertical-align: middle;
    word-break:keep-all;
    width:20%;
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
        	<!-- Nav Item - manager page -->
     	<%if(permission == 0){ %>
			<li class="nav-item">
			  <a class="nav-link" href="../manager/manager.jsp">
			  <i class="fas fa-fw fa-clipboard-list"></i> 
			  <span>관리자 페이지</span></a>
			</li>
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
                  <h6 class="m-0 font-weight-bold text-primary" style="padding-left: 17px;">정보 등록</h6>
                  <div class="btn_group">
                  <input id="insert" type="button" value="붙여넣기"  class="btn btn-primary" onclick="btn_insert()" >
                </div>
                </div>
                 <div class="card-body">
           
                 <div class="table-responsive">
          <form id="addPro" name="addPro" method="post" action="manager_addPro.jsp">       
			  <table class="table table-bordered" id="dataTable">
				 <tr>
				      <td class="m-0 text-primary" align="center" style="word-break: keep-all;">이름 *</td>
				      <td colspan="3"><input class="add_input" name="name"></td>
			     </tr>
			     
			     <tr>
				      <td class="m-0 text-primary" align="center">ID *</td>
				       <td colspan="3" style="white-space: nowrap;">
				       <input id ="id" name="id" style="width:80%;">
				       <input type="button" class="btn btn-info btn-icon-split btn-sm" value=" 확인 " onclick=button_onclick()></td>
			     </tr>
			     <tr>
				      <td class="m-0 text-primary" align="center">PW *</td>
				      <td colspan="3"><input value="12345" class="add_input" name="pw"></td>
			     </tr>
			     <tr>
				      <td class="m-0 text-primary" align="center">소속</td>
				      <td colspan="3"><input class="add_input" name="part" value="슈어소프트테크"></td>
			     </tr>
			     <tr>
				      <td class="m-0 text-primary" align="center">팀</td>
				      <td colspan="3"><select id="team" name="team">
                      	<%
                      		for(int i=0; i<teamList.size(); i++){
                      			%><option value='<%=teamList.get(i)%>'><%=teamList.get(i)%></option><%
                      		}
                      	%>
                      	</select></td>
			     </tr>
			     
			       <tr>
				      <td class="m-0 text-primary" align="center">직급</td>
				      <td colspan="3">
				      <select id="rank" name="rank">
				      	<option value="수석">수석</option>
				      	<option value="책임">책임</option>
				      	<option value="선임">선임</option>
				      	<option value="전임">전임</option>
				      	<option value="인턴">인턴</option>
				      </select>
				      </td>
			     </tr>
			     
			     <tr>
				      <td class="m-0 text-primary" align="center">직책</td>
				      <td colspan="3">
				      <select id="position" name="position">
				      	<option value="실장">실장</option>
				      	<option value="팀장">팀장</option>
				      	<option value="-">-</option>
				      </select>
				      </td>
			     </tr>
			      <tr>
				      <td class="m-0 text-primary" align="center">권한</td>
				      <td>
				      <select id="permission" name="permission">
				      	<option value="0">마스터</option>
				      	<option value="1">관리자</option>
				      	<option value="2">일반</option>
				      	<option value="3" selected="selected">게스트 </option>
				      </select></td></tr>
			     
			     <tr align="center">
			      <td colspan="4"> 
			      <input id="COMPLETE" type="button" name="COMPLETE" value="완료"  class="btn btn-primary" onclick=button_onclick2()>
			       <a href="manager.jsp" class="btn btn-primary">취소</a>
			       </td>
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