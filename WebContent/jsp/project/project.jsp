<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.io.PrintWriter"
    import = "jsp.Bean.model.*"
    import = "jsp.DB.method.*"
    import = "java.util.ArrayList"
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
	
	ProjectDAO projectDao = new ProjectDAO();
	ArrayList<ProjectBean> projectList = new ArrayList<ProjectBean>();
	projectList = projectDao.getProjectList();
	
%>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Sure FVMS - Project</title>

  <!-- Custom fonts for this template-->
  <link href="../../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="../../https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="../../css/sb-admin-2.min.css" rel="stylesheet">

</head>
<style>

	#project_btn{
		position: fixed;
		bottom: 0;
		padding: 10px;
		width: 100%;
		text-align: center;
		background-color: #fff;
		border-top: 1px solid;
	}
	
	.td{
		display:none;
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
</style>

<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
 <script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
    <script>
    $(document).ready(function(){
        //최상단 체크박스 클릭
        $("#checkall").click(function(){
        	 $( ".td" ).toggle( 'slow' );
            //클릭되었으면
            if($("#checkall").prop("checked")){
                //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
                $("input[name=cb]").prop("checked",true);
                
                //클릭이 안되있으면
            }else{
                //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
                $("input[name=cb]").prop("checked",false);
                
            }
        })
    })


    출처: https://hellogk.tistory.com/5 [IT Code Storage]
    
      $(document).ready( function() {
       /*  $( '#check_team' ).click( function() {
          $( 'td:first-child' ).toggle( 'slow' );
        });
        $( '#check_projectcode' ).click( function() {
            $( 'td:nth-child(2)' ).toggle( 'slow' );
          });
        $( '#cb3' ).click( function() {
            $( 'td:nth-child(3)' ).toggle( 'slow' );
          }); */
        $( '#cb4' ).click( function() {
            $( 'td:nth-child(4)' ).toggle( 'slow' );
          });
        $( '#cb5' ).click( function() {
            $( 'td:nth-child(5)' ).toggle( 'slow' );
          });
        $( '#cb6' ).click( function() {
            $( 'td:nth-child(6)' ).toggle( 'slow' );
          });
        $( '#cb7' ).click( function() {
            $( 'td:nth-child(7)' ).toggle( 'slow' );
          });
        $( '#cb8' ).click( function() {
            $( 'td:nth-child(8)' ).toggle( 'slow' );
          });
        $( '#cb9' ).click( function() {
            $( 'td:nth-child(9)' ).toggle( 'slow' );
          });
        $( '#cb10' ).click( function() {
            $( 'td:nth-child(10)' ).toggle( 'slow' );
          });
        $( '#cb11' ).click( function() {
            $( 'td:nth-child(11)' ).toggle( 'slow' );
          });
        $( '#cb12' ).click( function() {
            $( 'td:nth-child(12)' ).toggle( 'slow' );
          });
        $( '#cb13' ).click( function() {
            $( 'td:nth-child(13)' ).toggle( 'slow' );
          });
        $( '#cb14' ).click( function() {
            $( 'td:nth-child(14)' ).toggle( 'slow' );
          });
        $( '#cb15' ).click( function() {
            $( 'td:nth-child(15)' ).toggle( 'slow' );
          });
        $( '#cb16' ).click( function() {
            $( 'td:nth-child(16)' ).toggle( 'slow' );
          });
        $( '#cb17' ).click( function() {
            $( 'td:nth-child(17)' ).toggle( 'slow' );
          });
        $( '#cb18' ).click( function() {
            $( 'td:nth-child(18)' ).toggle( 'slow' );
          });
        $( '#cb19' ).click( function() {
            $( 'td:nth-child(19)' ).toggle( 'slow' );
          });
        $( '#cb20' ).click( function() {
            $( 'td:nth-child(20)' ).toggle( 'slow' );
          });
      $( '#cb21' ).click( function() {
          $( 'td:nth-child(21)' ).toggle( 'slow' );
        });
      $( '#cb22' ).click( function() {
          $( 'td:nth-child(22)' ).toggle( 'slow' );
        });
      $( '#cb23' ).click( function() {
          $( 'td:nth-child(23)' ).toggle( 'slow' );
        });
      $( '#cb24' ).click( function() {
          $( 'td:nth-child(24)' ).toggle( 'slow' );
        });
      $( '#cb25' ).click( function() {
          $( 'td:nth-child(25)' ).toggle( 'slow' );
        });
      });
    </script>
<script type="text/javascript">

// display 속성을 이용하면 손쉽게 어떠한 블럭을 보이거나 안보이게 할 수 있습니다.
// 대부분의 태그에 적용할 수 있으며 속성은
// 'none'과 'block'을 사용합니다.
// none - 안보이게 함
// block - 보이게 함
//function onShow(i){
//testObj[i].style.display=(testObj[i].style.display=='none')?'block':'none';
//}


// $(document).ready(function(){
//    $(document).on("click","#TEAM",function(event){
      // 동적으로 여러 태그가 생성된 경우라면 이런식으로 클릭된 객체를 this 키워드를 이용해서 잡아올 수 있다.  
 //    $("#TEAM2").attr('style',"display:none;");
      
//    });
// }); 

	/* 
	<!-- 로딩화면 -->
	window.onbeforeunload = function () { $('.loading').show(); }  //현재 페이지에서 다른 페이지로 넘어갈 때 표시해주는 기능
	$(window).load(function () {          //페이지가 로드 되면 로딩 화면을 없애주는 것
	    $('.loading').hide();
	}); */
</script>
<body id="page-top">
	 <!--  로딩화면  시작  
				  <div class="loading">
				  <div id="load">
				<i class="fas fa-spinner fa-10x fa-spin"></i>
			  </div>
				  </div>
		  로딩화면  끝  -->
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
      		<li class="nav-item active">
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
     	<%if(sessionID.equals("ymyou")){ %>
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
<!--프로젝트 조회 테이블 시작 *********************************************************** -->
          <!-- DataTales Example -->
          <div class="card shadow mb-4">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">프로젝트 목록</h6>
            </div>
            <div class="card-body">
              <div style="position:sticky;">
              	<!--  <label><input type="checkbox" id="check_team"> 팀</label>
      			 <label><input type="checkbox" id="check_projectcode"> 프로젝트 코드</label>
      			 <label><input type="checkbox" id="check_projectname"> 프로젝트 명</label> -->
      			 <label></label><input type="checkbox" id="checkall">모두보기</label>
      			 <label><input type="checkbox" id="cb4" name="cb"> 상태</label>
      			 <label><input type="checkbox" id="cb5" name="cb"> 실</label>
      			 <label><input type="checkbox" id="cb6" name="cb"> 고객사</label>
      			 <label><input type="checkbox" id="cb7" name="cb"> 고객부서</label>
      			 <label><input type="checkbox" id="cb8" name="cb"> M/M</label>
      			 <label><input type="checkbox" id="cb9" name="cb"> 프로젝트계약금액</label>
      			 <label><input type="checkbox" id="cb10" name="cb"> 상반기 수주</label>
      			 <label><input type="checkbox" id="cb11" name="cb"> 상반기예상매출</label>
      			 <label><input type="checkbox" id="cb12" name="cb"> 상반기매출</label>
      			 <label><input type="checkbox" id="cb13" name="cb"> 하반기수주</label>
      			 <label><input type="checkbox" id="cb14" name="cb"> 하반기예상매출</label>
      			 <label><input type="checkbox" id="cb15" name="cb"> 하반기매출</label>
      			 <label><input type="checkbox" id="cb16" name="cb"> 착수</label>
      			 <label><input type="checkbox" id="cb17" name="cb"> 종료</label>
      			 <label><input type="checkbox" id="cb18" name="cb"> 고객담당자</label>
      			 <label><input type="checkbox" id="cb19" name="cb"> 근무지</label>
      			 <label><input type="checkbox" id="cb20" name="cb"> 업무</label>
      			 <label><input type="checkbox" id="cb21" name="cb"> PM</label>
      			 <label><input type="checkbox" id="cb22" name="cb"> 투입명단</label>
      			 <label><input type="checkbox" id="cb23" name="cb"> 2020(상)평가유형</label>
      			 <label><input type="checkbox" id="cb24" name="cb"> 채용수요</label>
      			 <label><input type="checkbox" id="cb25" name="cb"> 외주수요</label>
              </div>
              <div class="table-responsive" style="overflow:overlay;">
            
                <table class="table table-bordered" id="dataTable" style="white-space: nowrap;">
                  
                    <tr class="m-0 text-primary">
	                    <td>팀</td>
	                    <td >프로젝트 코드</td>
	                    <td >프로젝트 명</td>
	                    <td class="td">상태</td>
	                    <td class="td">실</td>
	                    <td class="td">고객사</td>
	                    <td class="td">고객부서</td>
	                    <td class="td">M/M</td>
						<td class="td">프로젝트계약금액</td> 
						<td class="td">상반기수주</td>  
						<td class="td">상반기예상매출</td> 
						<td class="td">상반기매출 </td>
						<td class="td">하반기수주 </td>
						<td class="td">하반기예상매출 </td>
						<td class="td">하반기매출 </td>
						<td class="td">착수</td> 
						<td class="td">종료</td> 
						<td class="td">고객담당자</td> 
						<td class="td">근무지</td> 
						<td class="td">업무</td> 
						<td class="td">PM</td> 
						<td class="td">투입 명단</td> 
						<td class="td">2020(상)평가유형</td> 
						<td class="td">채용수요</td> 
						<td class="td">외주수요</td>  
                    </tr>
                
                 
                  <%
                  	for(int i=0; i<projectList.size(); i++){
                  		%>
                  		 <tr>
	                      <td><div><%=projectList.get(i).getTEAM()%></div></td>
	                      <td><div><%=projectList.get(i).getPROJECT_CODE()%></div></td>
	                      <!-- 권한에 따라 수정페이지 접근 가능 -->
	                      <%if(sessionID.equals("hlshin") || sessionID.equals("ysung516") || sessionID.equals("hykim") || sessionID.equals("swlee")){%>
	                      <td><a href="project_update.jsp?code=<%=projectList.get(i).getPROJECT_CODE()%>"><%=projectList.get(i).getPROJECT_NAME()%></a></td>
	                      <%}else{%>
	                      <td><%=projectList.get(i).getPROJECT_NAME()%><%} %></td>
	                      <td class="td"><div><%=projectList.get(i).getSTATE()%></div></td>
	                      <td class="td"><div><%=projectList.get(i).getPART()%></div></td>
	                      <td class="td"><div><%=projectList.get(i).getCLIENT()%></div></td>
	                      <td class="td"><div><%=projectList.get(i).getClIENT_PART()%></div></td>
	                      <td class="td"><div><%=projectList.get(i).getMAN_MONTH()%></div></td>
	                      <td class="td"><div><%=projectList.get(i).getPROJECT_DESOPIT()%></div></td>
	                      <td class="td"><div><%=projectList.get(i).getFH_ORDER()%></div></td>
	                      <td class="td"><div><%=projectList.get(i).getFH_SALES_PROJECTIONS()%></div></td>
	                      <td class="td"><div><%=projectList.get(i).getFH_SALES()%></div></td>
	                      <td class="td"><div><%=projectList.get(i).getSH_ORDER()%></div></td>
	                      <td class="td"><div><%=projectList.get(i).getSH_SALES_PROJECTIONS()%></div></td>
	                      <td class="td"><div><%=projectList.get(i).getSH_SALES()%></div></td>
	                      <td class="td"><div><%=projectList.get(i).getPROJECT_START()%></div></td>
	                      <td class="td"><div><%=projectList.get(i).getPROJECT_END()%></div></td>
	                      <td class="td"><div><%=projectList.get(i).getCLIENT_PTB()%></div></td>
	                      <td class="td"><div><%=projectList.get(i).getWORK_PLACE()%></div></td>
	                      <td class="td"><div><%=projectList.get(i).getWORK()%></div></td>
	                      <td class="td"><div><%=projectList.get(i).getPROJECT_MANAGER()%></div></td>
	                      <td class="td"><div><%=projectList.get(i).getWORKER_LIST()%></div></td>
	                      <td class="td"><div><%=projectList.get(i).getASSESSMENT_TYPE()%></div></td>
	                      <td class="td"><div><%=projectList.get(i).getEMPLOY_DEMAND()%></div></td>
	                      <td class="td"><div><%=projectList.get(i).getOUTSOURCE_DEMAND()%></div></td>
                    	</tr>
                  		<%	
                  	}
                  %>
                                              
                </table>
              </div>   
              </div>     
   				<div id="project_btn">
            
                	 <a href="project_make.jsp" class="btn btn-primary">프로젝트 생성</a>
              </div>
         </div>
        <!-- /.container-fluid -->
<!--프로젝트 조회 테이블 끝        *********************************************************** -->

      <!-- End of Main Content -->

    </div>
    <!-- End of Content Wrapper -->

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
