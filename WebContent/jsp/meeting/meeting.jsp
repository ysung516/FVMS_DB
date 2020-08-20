<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.io.PrintWriter"
    import = "jsp.DB.method.*"
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
	int permission = Integer.parseInt(session.getAttribute("permission").toString());
	if(permission > 2){
		script.print("<script> alert('접근 권한이 없습니다.'); history.back(); </script>");
	}
	
	String sessionID = session.getAttribute("sessionID").toString();
	String sessionName = session.getAttribute("sessionName").toString();
	session.setMaxInactiveInterval(15*60);
	MeetingDAO meetDao = new MeetingDAO();
	
	ArrayList<MeetBean> list = meetDao.getMeetBean();
	
 %>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Sure FVMS - meeting</title>

  <!-- Custom fonts for this template-->
  <link href="../../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="../../https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="../../css/sb-admin-2.min.css" rel="stylesheet">

</head>
<style>
	
	#meeting_btn{
		position: fixed;
		bottom: 0;
		padding: 10px;
		width: 100%;
		text-align: center;
		background-color: #fff;
		border-top: 1px solid;
	}

	#meetingTable tr{
	 	border-bottom: 1px solid #d1d3e2;
		text-align:center;
	}
	
	#meetingTable{
		white-space: nowrap;
		overflow:auto;
		width:100%; 
		margin-top:10px;
	}
	
	#meetingList td{
		border-right: 1px solid #b7b9cc;
		padding:6px;
	}
	
	#meetingList td:last-child{
		border:0px;
	}
	summary:focus { outline:none; }
	
	p:last-child{
		border-bottom: 1px solid black !important;
		border-bottom-right-radius:5px;
		border-bottom-left-radius:5px;
	}
	tr:last-child{
		border-bottom:1px solid #fff !important;
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
	
	button:focus {
	outline:none;
	}
	.projectList{
		margin: 0;
	}
</style>
<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript">

function sortingNumber( a , b ){  
    if ( typeof a == "number" && typeof b == "number" ) return a - b; 
    // 천단위 쉼표와 공백문자만 삭제하기.  
    var a = ( a + "" ).replace( /[,\s\xA0]+/g , "" ); 
    var b = ( b + "" ).replace( /[,\s\xA0]+/g , "" ); 
    var numA = parseFloat( a ) + ""; 
    var numB = parseFloat( b ) + ""; 
    if ( numA == "NaN" || numB == "NaN" || a != numA || b != numB ) return false; 
    return parseFloat( a ) - parseFloat( b ); 
} 
/* changeForSorting() : 문자열 바꾸기. */ 
function changeForSorting( first , second ){  
    // 문자열의 복사본 만들기. 
    var a = first.toString().replace( /[\s\xA0]+/g , " " ); 
    var b = second.toString().replace( /[\s\xA0]+/g , " " ); 
    var change = { first : a, second : b }; 
    if ( a.search( /\d/ ) < 0 || b.search( /\d/ ) < 0 || a.length == 0 || b.length == 0 ) return change; 
    var regExp = /(\d),(\d)/g; // 천단위 쉼표를 찾기 위한 정규식. 
    a = a.replace( regExp , "$1" + "$2" ); 
    b = b.replace( regExp , "$1" + "$2" ); 
    var unit = 0; 
    var aNb = a + " " + b; 
    var numbers = aNb.match( /\d+/g ); // 문자열에 들어있는 숫자 찾기 
    for ( var x = 0; x < numbers.length; x++ ){ 
            var length = numbers[ x ].length; 
            if ( unit < length ) unit = length; 
    } 
    var addZero = function( string ){ // 숫자들의 단위 맞추기 
            var match = string.match( /^0+/ ); 
            if ( string.length == unit ) return ( match == null ) ? string : match + string; 
            var zero = "0"; 
            for ( var x = string.length; x < unit; x++ ) string = zero + string; 
            return ( match == null ) ? string : match + string; 
    }; 
    change.first = a.replace( /\d+/g, addZero ); 
    change.second = b.replace( /\d+/g, addZero ); 
    return change; 
} 
/* byLocale() */ 
function byLocale(){ 
    var compare = function( a , b ){ 
            var sorting = sortingNumber( a , b ); 
            if ( typeof sorting == "number" ) return sorting; 
            var change = changeForSorting( a , b ); 
            var a = change.first; 
            var b = change.second; 
            return a.localeCompare( b ); 
    }; 
    var ascendingOrder = function( a , b ){  return compare( a , b );  }; 
    var descendingOrder = function( a , b ){  return compare( b , a );  }; 
    return { ascending : ascendingOrder, descending : descendingOrder }; 
} 
/* replacement() */ 

function replacement( parent ){  
    var tagName = parent.tagName.toLowerCase(); 
    if ( tagName == "table" ) parent = parent.tBodies[ 0 ]; 
    tagName = parent.tagName.toLowerCase(); 
    if ( tagName == "tbody" ) var children = parent.rows; 
    else var children = parent.getElementsByTagName( "li" ); 
    var replace = { 
            order : byLocale(), 
            index : false, 
            array : function(){ 
                    var array = [ ]; 
                    for ( var x = 0; x < children.length; x++ ) array[ x ] = children[ x ]; 
                    return array; 
            }(), 
            checkIndex : function( index ){ 
                    if ( index ) this.index = parseInt( index, 10 ); 
                    var tagName = parent.tagName.toLowerCase(); 
                    if ( tagName == "tbody" && ! index ) this.index = 0; 
            }, 
            getText : function( child ){ 
                    if ( this.index ) child = child.cells[ this.index ]; 
                    return getTextByClone( child ); 
            }, 
            setChildren : function(){ 
                    var array = this.array; 
                    while ( parent.hasChildNodes() ) parent.removeChild( parent.firstChild ); 
                    for ( var x = 0; x < array.length; x++ ) parent.appendChild( array[ x ] ); 
            }, 
            ascending : function( index ){ // 오름차순 
                    this.checkIndex( index ); 
                    var _self = this; 
                    var order = this.order; 
                    var ascending = function( a, b ){ 
                            var a = _self.getText( a ); 
                            var b = _self.getText( b ); 
                            return order.ascending( a, b ); 
                    }; 
                    this.array.sort( ascending ); 
                    this.setChildren(); 
            }, 
            descending : function( index ){ // 내림차순
                    this.checkIndex( index ); 
                    var _self = this; 
                    var order = this.order; 
                    var descending = function( a, b ){ 
                            var a = _self.getText( a ); 
                            var b = _self.getText( b ); 
                            return order.descending( a, b ); 
                    }; 
                    this.array.sort( descending ); 
                    this.setChildren(); 
            } 
    }; 
    return replace; 
} 
function getTextByClone( tag ){  
    var clone = tag.cloneNode( true ); // 태그의 복사본 만들기. 
    var br = clone.getElementsByTagName( "br" ); 
    while ( br[0] ){ 
            var blank = document.createTextNode( " " ); 
            clone.insertBefore( blank , br[0] ); 
            clone.removeChild( br[0] ); 
    } 
    var isBlock = function( tag ){ 
            var display = ""; 
            if ( window.getComputedStyle ) display = window.getComputedStyle ( tag, "" )[ "display" ]; 
            else display = tag.currentStyle[ "display" ]; 
            return ( display == "block" ) ? true : false; 
    }; 
    var children = clone.getElementsByTagName( "*" ); 
    for ( var x = 0; x < children.length; x++){ 
            var child = children[ x ]; 
            if ( ! ("value" in child) && isBlock(child) ) child.innerHTML = child.innerHTML + " "; 
    } 
    var textContent = ( "textContent" in clone ) ? clone.textContent : clone.innerText; 
    return textContent; 
} 

<!-- 로딩화면 -->
window.onbeforeunload = function () { $('.loading').show(); }  //현재 페이지에서 다른 페이지로 넘어갈 때 표시해주는 기능
$(window).load(function () {          //페이지가 로드 되면 로딩 화면을 없애주는 것
    $('.loading').hide();
});
</script>

<body id="page-top" style="color:#4c5280 !important">

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
		    <li class="nav-item active">
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
        <div class="container-fluid" style="padding-bottom: 50px;">
         
              <div class="card shadow mb-4">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary" style="padding-left:17px;display:inline !important">회의록 목록</h6>
                  </div>
         
	<table id ="meetingTable">
		<thead>
		 <tr>
		   <th>회의명</th>
		   <th>회의 장소 
			   	<input type="button" value="▲" onclick="sortTD (1)">
			   	<input type="button" value="▼" onclick="reverseTD (1)">
		   	</th>
		   <th>회의 일시
			   <input type="button" value="▲" onclick="sortTD (2)">
			   <input type="button" value="▼" onclick="reverseTD (2)"> 
		   </th>
		   <th>작성 일시
			   <input type="button" value="▲" onclick="sortTD (3)">
			   <input type="button" value="▼" onclick="reverseTD (3)">
		   </th>
		   <th>작성자
			   <input type="button" value="▲" onclick="sortTD (4)">
			   <input type="button" value="▼" onclick="reverseTD (4)">
		   </th>
		   </tr>
		  
		  </thead>  
		  <tbody id ="meetingList" name="meetingList" class="meetingList" style="white-space: initial;">

	  		<%
	  			
	  			if(list != null){
	  				for(int i=list.size()-1; i>=0; i--){
	  					%>
	  						<tr style="text-align:center; border-bottom: 1px solid #d1d3e2;">
								
								<td><a href="meeting_view.jsp?no=<%=list.get(i).getNo()%>"><%=list.get(i).getMeetName()%></a></td>
								<td><%=list.get(i).getMeetPlace()%></td>
								<td><%=list.get(i).getMeetDate()%></td>
								<td><%=list.get(i).getDate()%></td>
								<td><%=list.get(i).getWriter()%></td>
							</tr>
						<%
	  				}
	  			}
	  		
	  			%>
		  		
					 
		  </tbody>
		 </table>	
		 
		<script type="text/javascript">
			var myTable = document.getElementById( "meetingTable" ); 
			var replace = replacement( myTable ); 
			function sortTD( index ){replace.ascending( index ); } 
			function reverseTD( index ){replace.descending( index );} 
		</script>
	<!-- /.container-fluid -->
      </div>
     		
     		 <div id="meeting_btn">
                 <a href="meeting_write.jsp" class="btn btn-primary">회의록 작성</a>
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
