<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.DB.method.*" import="jsp.Bean.model.*"
	import="java.util.ArrayList" import="java.util.List"
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
		session.setMaxInactiveInterval(60*60);
		MemberDAO memberDao = new MemberDAO();
		int permission = Integer.parseInt(session.getAttribute("permission").toString());
		ArrayList<MemberBean> memberList = memberDao.getMemberData();
		
		Date nowDate = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy");
		int nowYear = Integer.parseInt(sf.format(nowDate));
		int wyear = 0;
		int comYear = nowYear;
	%>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Sure FVMS - Manger</title>

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
	window.onbeforeunload = function () { $('.loading').show(); }  //현재 페이지에서 다른 페이지로 넘어갈 때 표시해주는 기능
	$(window).load(function () {          //페이지가 로드 되면 로딩 화면을 없애주는 것
	    $('.loading').hide();
	});
</script>

<style>
	#sidebarToggle{
		display:none;
	}
	.sortBTN{
	font-size:5px;
	}
	.sidebar{
		position:fixed;
		z-index:9999;
	}
	#content{
		margin-left:90px;
	}
	
.table-responsive {
	width: 70%;
	margin-left:5%;
}

#manager_List {
	white-space: initial;
}

#manager_List td {
	border-right: 1px solid #b7b9cc;
	padding: 6px;
}

#manager_List td:last-child {
	border: 0px;
}

p:last-child {
	border-bottom: 1px solid black !important;
	border-bottom-right-radius: 5px;
	border-bottom-left-radius: 5px;
}

tr:last-child {
	border-bottom: 1px solid #fff !important;
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

#managerTable tr {
	border-bottom: 1px solid #d1d3e2;
	
}

#managerTable {
	white-space: nowrap;
	overflow: auto;
	width: 100%;
	margin-top: 10px;
}

.m-0 .text-primary {
	vertical-align: middle;
	text-align: center;
}

#view_btn {
	vertical-align: middle;
	padding-left: 17px;
	display: inline;
}

#Delete {
	right: 0;
	margin-right: 24px;
	display: inline-block;
	position: absolute;
	top: 9px;
}

#dataTable td:nth-child(odd) {
	
	vertical-align: middle;
	word-break: keep-all;
	width: 10%;
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

	#sidebarToggle{
		display:block;
	}
	.extra{
		display:none;
	}
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
	.container-fluid {
		padding: 0;
	}
	.card-header:first-child {
		padding: 0;
	}
	.table-responsive {
		width: 100%;
		margin-left:0;
	}
	body {
		font-size: small;
	}
}

.sortDIV {
	display: inline;
}
</style>

<!-- sorting table -->
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
							<h6 class="m-0 font-weight-bold text-primary" id="view_btn">관리자
								페이지</h6>
						</div>

						<div class="table-responsive" style="margin-bottom: 40px;">
							<table id="managerTable">
								<thead>
									<tr>
										<th>팀
											<button class="sortBTN" onclick="sort_team()">▼</button>
										</th>
										<th>소속
											<button class="sortBTN" onclick="sort_part()">▼</button>
										</th>
										<th>이름
											<button class="sortBTN" onclick="sortTD (2)">▲</button>
											<button class="sortBTN" onclick="reverseTD (2)">▼</button>
										</th>
										<th>직급
											<button class="sortBTN" onclick="sort_rank()">▼</button>
										</th>
										<th>권한
											<button class="sortBTN" onclick="sortTD (4)">▲</button>
											<button class="sortBTN" onclick="reverseTD (4)">▼</button>
										</th>
										<th class="extra">거주지</th>
										<th class="extra">mobile</th>
										<th class="extra">연차</th>
										<th class="extra">프로젝트 수행 이력</th>
										

									</tr>
								</thead>
								<tbody id="manager_List">
									<%
		  	for(int i=0; i<memberList.size(); i++){
		  		if(memberList.get(i).getComDate().contains("-") && memberList.get(i).getComDate().matches(".*[0-9].*")){
		  			comYear = Integer.parseInt(memberList.get(i).getComDate().split("-")[0]);
		  			wyear = nowYear -  comYear + 1;
		  		}else{
		  			wyear = 0;
		  		}
		  		%><tr style="text-align: left;">
										<td><%=memberList.get(i).getTEAM()%></td>

										<td><%=memberList.get(i).getPART()%></td>

										<td><a
											href="manager_view.jsp?id=<%=memberList.get(i).getID()%>"><%=memberList.get(i).getNAME() %></a></td>

										<td><%=memberList.get(i).getRANK()%></td>

										<td><%=memberList.get(i).getPermission() %></td>
										<td class="extra"><%=memberList.get(i).getADDRESS() %></td>
										<td class="extra"><%=memberList.get(i).getMOBILE() %></td>
										<td class="extra"><%=wyear %></td>
										<td class="extra">수행프로젝트이력 채우기</td>
										
										
									</tr>
									<%	
		  	}
		  %>

								</tbody>
							</table>
							<script type="text/javascript">
			       var myTable = document.getElementById( "managerTable" ); 
			       var replace = replacement( myTable ); 
			       function sortTD( index ){replace.ascending( index ); } 
			       function reverseTD( index ){replace.descending( index );} 
			       

				   	function sort_team(){
				   		var html = '';
				   		<%memberList = memberDao.getMemberData();
				   		for (int i=0; i<memberList.size() ; i++){
					  		if(memberList.get(i).getComDate().contains("-") && memberList.get(i).getComDate().matches(".*[0-9].*")){
					  			comYear = Integer.parseInt(memberList.get(i).getComDate().split("-")[0]);
					  			wyear = nowYear -  comYear + 1;
					  		}else{
					  			wyear = 0;
					  		}%>
				   		html += '<tr>';
				   		html += '<td>' + '<%=memberList.get(i).getTEAM()%>' + '</td>';
				   		html += '<td>' + '<%=memberList.get(i).getPART()%>' + '</td>';
				   		html += '<td><a href="manager_view.jsp?id='+'<%=memberList.get(i).getID()%>'+'">' + '<%=memberList.get(i).getNAME()%>' + '</td>';
				   		html += '<td>' + '<%=memberList.get(i).getRANK()%>' + '</td>';
				   		html += '<td>' + '<%=memberList.get(i).getPermission()%>' + '</td>';
				   		html += '<td class="extra">'+'<%=memberList.get(i).getADDRESS() %>'+'</td>';
				   		html += '<td class="extra">'+'<%=memberList.get(i).getMOBILE() %>'+'</td>';
				   		html += '<td class="extra">'+'<%=wyear %>'+'</td>';
				   		html += '<td class="extra">'+'수행프로젝트이력 채우기'+'</td>';
				   		html += '</tr>';
				   		<%}%>
				   		$("#manager_List").empty();
				   		$("#manager_List").append(html);
				   	}
				   	
				   	function sort_part(){
				   		var html = '';
				   		<%memberList = memberDao.getMemberData_part();
				   		for (int i=0; i<memberList.size() ; i++){
					  		if(memberList.get(i).getComDate().contains("-") && memberList.get(i).getComDate().matches(".*[0-9].*")){
					  			comYear = Integer.parseInt(memberList.get(i).getComDate().split("-")[0]);
					  			wyear = nowYear -  comYear + 1;
					  		}else{
					  			wyear = 0;
					  		}%>
				   		html += '<tr>';
				   		html += '<td>' + '<%=memberList.get(i).getTEAM()%>' + '</td>';
				   		html += '<td>' + '<%=memberList.get(i).getPART()%>' + '</td>';
				   		html += '<td><a href="manager_view.jsp?id='+'<%=memberList.get(i).getID()%>'+'">' + '<%=memberList.get(i).getNAME()%>' + '</td>';
				   		html += '<td>' + '<%=memberList.get(i).getRANK()%>' + '</td>';
				   		html += '<td>' + '<%=memberList.get(i).getPermission()%>' + '</td>';
				   		html += '<td class="extra">'+'<%=memberList.get(i).getADDRESS() %>'+'</td>';
				   		html += '<td class="extra">'+'<%=memberList.get(i).getMOBILE() %>'+'</td>';
				   		html += '<td class="extra">'+'<%=wyear %>'+'</td>';
				   		html += '<td class="extra">'+'수행프로젝트이력 채우기'+'</td>';
				   		html += '</tr>';
				   		<%}%>
				   		$("#manager_List").empty();
				   		$("#manager_List").append(html);
				   	}
				   	
				   	function sort_rank(){
				   		var html = '';
				   		<%memberList = memberDao.getMemberData_rank();
				   		for (int i=0; i<memberList.size() ; i++){
					  		if(memberList.get(i).getComDate().contains("-") && memberList.get(i).getComDate().matches(".*[0-9].*")){
					  			comYear = Integer.parseInt(memberList.get(i).getComDate().split("-")[0]);
					  			wyear = nowYear -  comYear + 1;
					  		}else{
					  			wyear = 0;
							}%>
				   		html += '<tr>';
				   		html += '<td>' + '<%=memberList.get(i).getTEAM()%>' + '</td>';
				   		html += '<td>' + '<%=memberList.get(i).getPART()%>' + '</td>';
				   		html += '<td><a href="manager_view.jsp?id='+'<%=memberList.get(i).getID()%>'+'">' + '<%=memberList.get(i).getNAME()%>' + '</td>';
				   		html += '<td>' + '<%=memberList.get(i).getRANK()%>' + '</td>';
				   		html += '<td>' + '<%=memberList.get(i).getPermission()%>' + '</td>';
				   		html += '<td class="extra">'+'<%=memberList.get(i).getADDRESS() %>'+'</td>';
				   		html += '<td class="extra">'+'<%=memberList.get(i).getMOBILE() %>'+'</td>';
				   		html += '<td class="extra">'+'<%=wyear %>'+'</td>';
				   		html += '<td class="extra">'+'수행프로젝트이력 채우기'+'</td>';
				   		html += '</tr>';
				   		<%}%>
				   		$("#manager_List").empty();
				   		$("#manager_List").append(html);
				   	}
			       </script>
						</div>

						<!-- /.container-fluid -->

						<div id="manager_btn">
							<a href="manager_add.jsp" class="btn btn-primary">추가</a>
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
