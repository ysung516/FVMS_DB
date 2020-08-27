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
	
	int permission = Integer.parseInt(session.getAttribute("permission").toString());
	if(permission > 2){
		script.print("<script> alert('접근 권한이 없습니다.'); history.back(); </script>");
	}

	String sessionID = session.getAttribute("sessionID").toString();
	String sessionName = session.getAttribute("sessionName").toString();
	session.setMaxInactiveInterval(60*60);
	
	ProjectDAO projectDao = new ProjectDAO();
	MemberDAO memberDao = new MemberDAO();
	ArrayList<ProjectBean> projectList = projectDao.getProjectList();
	ArrayList<MemberBean> memberList = memberDao.getMemberData(); 
	MemberBean myInfo = memberDao.returnMember(sessionID);
	
	ArrayList<String[]> workerIdList = new ArrayList<String[]>();
	ArrayList<String> PMnameList = new ArrayList<String>();
	String[] workerIdArray = {};
	String pmInfo="";
	
	// 투입명단 id >> 이름으로 변경
	for(int i=0; i<projectList.size();i++){
		if(projectList.get(i).getWORKER_LIST() != null){
			workerIdArray =  projectList.get(i).getWORKER_LIST().split(" ");
			for(int a=0; a<workerIdArray.length; a++){
				for(int b=0; b<memberList.size(); b++){
					if(workerIdArray[a].equals(memberList.get(b).getID())){
						workerIdArray[a] = memberList.get(b).getNAME();
					}
				}
			}
			workerIdList.add(workerIdArray);
		}
	}
	
	// PM ID >> 이름 변경
	for(int i=0; i<projectList.size();i++){
		if(projectList.get(i).getWORKER_LIST() != null){
			pmInfo =  projectList.get(i).getPROJECT_MANAGER();
			for(int b=0; b<memberList.size(); b++){
				if(pmInfo.equals(memberList.get(b).getID())){
					pmInfo = memberList.get(b).getNAME();
				}
			}
			PMnameList.add(pmInfo);
		}
	}
	
	

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
	.cb{
    height: 18px;
    width: 18px;
    vertical-align: baseline;
	}
	.check_div{
    border: 1px solid black;
    padding: 5px;
    width: fit-content;
    margin-bottom: 5px;
    border-radius: 6px;
    font-weight:bold;
    color:black;
}
	.check_table{
		display:none;
	}


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
	.table { border:1px solid; border-collapse: collapse; white-space: nowrap; }
    .table td, .test-table th { border: 1px solid;width: 80px; }
    .table thead th { position:sticky; top: 0; background-color: white; border:1px solid; }
    .table-responsive { width: 100%; height: 780px; overflow: auto; }
</style>

<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>

 
    <script>
    function cbLoad(){
    	$('td:nth-child(6)').hide();
		$('th:nth-child(6)').hide();
    	for(var a=8;a<29;a++){
    		$('td:nth-child('+a+')').hide();
			$('th:nth-child('+a+')').hide()
    	}
    }
    
    function cbSlow(){
    	$( '.cb' ).click( function() {
    		var clickId = $(this).attr('id');
    		if(clickId == 'cb1'){
    			if($("#cb1").prop("checked")){
    				$('th:nth-child(6)').show();
    				$('td:nth-child(6)').show();
    				$('th:nth-child(8)').show();
    				$('td:nth-child(8)').show();
    				$('th:nth-child(9)').show();
    				$('td:nth-child(9)').show();
    				$('th:nth-child(10)').show();
    				$('td:nth-child(10)').show();
    				$('th:nth-child(21)').show();
    				$('td:nth-child(21)').show();
    				$('th:nth-child(22)').show();
    				$('td:nth-child(22)').show();
    				$('th:nth-child(23)').show();
    				$('td:nth-child(23)').show();
    			} else{
    				$('th:nth-child(6)').hide();
    				$('td:nth-child(6)').hide();
    				$('th:nth-child(8)').hide();
    				$('td:nth-child(8)').hide();
    				$('th:nth-child(9)').hide();
    				$('td:nth-child(9)').hide();
    				$('th:nth-child(10)').hide();
    				$('td:nth-child(10)').hide();
    				$('th:nth-child(21)').hide();
    				$('td:nth-child(21)').hide();
    				$('th:nth-child(22)').hide();
    				$('td:nth-child(22)').hide();
    				$('th:nth-child(23)').hide();
    				$('td:nth-child(23)').hide();
    			}
    		} else if(clickId == 'cb2'){
    			if($("#cb2").prop("checked")){
    				$('th:nth-child(11)').show();
    				$('td:nth-child(11)').show();
    				$('th:nth-child(12)').show();
    				$('td:nth-child(12)').show();
    				$('th:nth-child(13)').show();
    				$('td:nth-child(13)').show();
    				$('th:nth-child(14)').show();
    				$('td:nth-child(14)').show();
    			} else{
    				$('th:nth-child(11)').hide();
    				$('td:nth-child(11)').hide();
    				$('th:nth-child(12)').hide();
    				$('td:nth-child(12)').hide();
    				$('th:nth-child(13)').hide();
    				$('td:nth-child(13)').hide();
    				$('th:nth-child(14)').hide();
    				$('td:nth-child(14)').hide();
    			}
    		} else if(clickId == 'cb3'){
    			if($("#cb3").prop("checked")){
        			$('th:nth-child(15)').show();
    				$('td:nth-child(15)').show();
    				$('th:nth-child(16)').show();
    				$('td:nth-child(16)').show();
    				$('th:nth-child(17)').show();
    				$('td:nth-child(17)').show();
    				$('th:nth-child(18)').show();
    				$('td:nth-child(18)').show();	
    			} else{
        			$('th:nth-child(15)').hide();
    				$('td:nth-child(15)').hide();
    				$('th:nth-child(16)').hide();
    				$('td:nth-child(16)').hide();
    				$('th:nth-child(17)').hide();
    				$('td:nth-child(17)').hide();
    				$('th:nth-child(18)').hide();
    				$('td:nth-child(18)').hide();
        		}
    		} else if(clickId == 'cb4'){
    			if($("#cb4").prop("checked")){
        			$('th:nth-child(19)').show();
    				$('td:nth-child(19)').show();
    				$('th:nth-child(20)').show();
    				$('td:nth-child(20)').show();
    			} else{
    				$('th:nth-child(19)').hide();
    				$('td:nth-child(19)').hide();
    				$('th:nth-child(20)').hide();
    				$('td:nth-child(20)').hide();
        		}
    		} else if(clickId == 'cb5'){
    			if($("#cb5").prop("checked")){
        			$('th:nth-child(24)').show();
    				$('td:nth-child(24)').show();
    				$('th:nth-child(25)').show();
    				$('td:nth-child(25)').show();
    				$('th:nth-child(27)').show();
    				$('td:nth-child(27)').show();
    				$('th:nth-child(28)').show();
    				$('td:nth-child(28)').show();
    			} else{
    				$('th:nth-child(24)').hide();
    				$('td:nth-child(24)').hide();
    				$('th:nth-child(25)').hide();
    				$('td:nth-child(25)').hide();
    				$('th:nth-child(27)').hide();
    				$('td:nth-child(27)').hide();
    				$('th:nth-child(28)').hide();
    				$('td:nth-child(28)').hide();
        		}
    		} else if(clickId == 'cb6'){
    			if($("#cb6").prop("checked")){
        			$('th:nth-child(26)').show();
    				$('td:nth-child(26)').show();
    			} else{
    				$('th:nth-child(26)').hide();
    				$('td:nth-child(26)').hide();
        		}
    		} 
    		
    		

        });
    }
    
    function cbCloseAllClose(){
    	$( '.cb' ).click( function() {
    		if($(this).is(":checked") == false){
    			$("input:checkbox[id='checkall']").prop("checked", false);
    		}
        });
    }
    
    function cbAll(){
    	$("#checkall").click(function(){
            //클릭되었으면
            if($("#checkall").prop("checked")){
           	 	$( ".td" ).show();
           		$( ".th" ).show();
                //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
                $("input[name=cb]").prop("checked",true);
            //클릭이 안되있으면
            }else{
            	$( ".td" ).hide();
            	$( ".th" ).hide();
                //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
                $("input[name=cb]").prop("checked",false);
         		
                }    
        });
    }
    
    function stateColor(){
    	var str;
    	for(var i=0;i<=<%=projectList.size()%>;i++){
    		//var tr = $('#dataTable tr:eq('+i+')');
    		//var td = tr.children();
    		str = $('#dataTable tr:eq('+i+') td:eq(4)').text();
    		if(str.indexOf('1')!=-1){
    			$('#dataTable tr:eq('+i+')').css("background-color", "#A9E2F3");
    		}else if(str.indexOf('2')!=-1){
    			$('#dataTable tr:eq('+i+')').css("background-color", "#A9E2F3");
    		}else if(str.indexOf('3')!=-1){
    			$('#dataTable tr:eq('+i+')').css("background-color", "#A9E2F3");
    		}else if(str.indexOf('4')!=-1){
    			$('#dataTable tr:eq('+i+')').css("background-color", "#F6CEE3");
    		}else if(str.indexOf('5')!=-1){
    			$('#dataTable tr:eq('+i+')').css("background-color", "#F6CEE3");
    		}else if(str.indexOf('6')!=-1){
    			$('#dataTable tr:eq('+i+')').css("background-color", "#FFFFFF");
    		}else if(str.indexOf('7')!=-1){
    			$('#dataTable tr:eq('+i+')').css("background-color", "#E6E6E6");
    		}else if(str.indexOf('8')!=-1){
    			$('#dataTable tr:eq('+i+')').css("background-color", "#A4A4A4");
    		}
    	}
    }

    function check_box(){
    	   $(".check_div").click(function(e){
           	if($(".check_table").css('display')=='none'){
            $(".check_table").show();
           	}
           	else  
            $(".check_table").hide();
           });
           
           $("body").click( function(e){
               if(e.target.className !== "check_div" && e.target.className !== "cb"){
                 $(".check_table").hide();    
                 $(".check_div").show();
               }
             });
    }
    
    $(document).ready(function(){
        //최상단 체크박스 클릭
        cbLoad();
        cbAll();
        cbSlow();
        cbCloseAllClose();
        stateColor();
        check_box();
    });
    
    //table sorting
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
<script type="text/javascript">
	
	<!-- 로딩화면 -->
	window.onbeforeunload = function () { $('.loading').show(); }  //현재 페이지에서 다른 페이지로 넘어갈 때 표시해주는 기능
	$(window).load(function () {          //페이지가 로드 되면 로딩 화면을 없애주는 것
	    $('.loading').hide();
	}); 
	
	
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
            <div class="card-body" style="margin-bottom: 40px;">
            	
            	<div class="check_div" >체크박스</div>
              	<!--  <label><input type="checkbox" id="check_team"> 팀</label>
      			 <label><input type="checkbox" id="check_projectcode"> 프로젝트 코드</label>
      			 <label><input type="checkbox" id="check_projectname"> 프로젝트 명</label> -->
      			 <table class="check_table">
      			 	 <tr>
		      			 <td>
		      			 	<label><input type="checkbox" id="checkall" class="cb"> 모두보기</label>
		      			  </td>
	      			  </tr>
	      			 <tr>
		      			 <td>
		      			 	<label><input type="checkbox" id="cb1" name="cb" class="cb"> 개요(실, 고객부서, M/M, 프로젝트 계약 금액, 고객담당자, 근무지, 업무)</label>
		      			  </td>
	      			  </tr>
	      			 <tr>
		      			 <td>
		      			 	<label><input type="checkbox" id="cb2" name="cb" class="cb"> 상반기 실적(상반기 예상수주, 상반기 수주, 상반기 예상매출, 하반기 매출)</label>
		      			 </td>
	      			 </tr>
	      			 <tr>
		      			 <td>
		      			 	<label><input type="checkbox" id="cb3" name="cb" class="cb"> 하반기 실적(하반기 예상수주, 하반기 수주, 하반기 예상매출, 하반기 매출)</label>
		      			 </td>
	      			 </tr>
	      			 <tr>
		      			 <td>
		      			 	<label><input type="checkbox" id="cb4" name="cb" class="cb"> 일정(착수, 종료)</label>
		      			 </td>
	      			 </tr>
	      			 <tr>
		      			 <td>
		      				<label><input type="checkbox" id="cb5" name="cb" class="cb"> 인원	(PM, 투입명단, 채용수요, 외주수요)</label>
		      			 </td>
	      			 </tr>
	      			 <tr>
		      			 <td>
		      			 	<label><input type="checkbox" id="cb6" name="cb" class="cb"> 평가	(상반기 평가유형, 하반기 평가유형)</label>
		      			 </td>
	      			  </tr>
      			 </table>
      			
      			
             
              <div class="table-responsive">
                <table class="table" id="dataTable" style="white-space: nowrap;font-size:small;width:0%;">
                  <thead>
                    <tr class="m-0 text-primary">
	                    <th>팀(수주)
	                    	<button class="sortBTN" onclick="sortTD (0)">▲</button>
						 	<button class="sortBTN" onclick="reverseTD (0)">▼</button>
	                    </th>
	                    <th>팀(매출)
	                    	<button class="sortBTN" onclick="sortTD (1)">▲</button>
						 	<button class="sortBTN" onclick="reverseTD (1)">▼</button>
	                    </th>
	                    <th>프로젝트 코드</th>
	                    <th>프로젝트 명</th>
	                    <th>상태
						 	<button class="sortBTN" onclick="sortTD (4)">▲</button>
						 	<button class="sortBTN" onclick="reverseTD (4)">▼</button>
	                    </th>
	                    <th class="th">실</th>
	                    <th>고객사
	                    	<button class="sortBTN" onclick="sortTD (6)">▲</button>
						 	<button class="sortBTN" onclick="reverseTD (6)">▼</button>
	                    </th>
	                    <th class="th">고객부서</th>
	                    <th class="th">M/M</th>
						<th class="th">프로젝트계약금액</th> 
						<th class="th">상반기예상수주</th>  
						<th class="th">상반기수주</th>  
						<th class="th">상반기예상매출</th> 
						<th class="th">상반기매출 </th>
						<th class="th">하반기예상수주</th>  
						<th class="th">하반기수주 </th>
						<th class="th">하반기예상매출 </th>
						<th class="th">하반기매출 </th>
						<th class="th">착수
					 	<button class="sortBTN" onclick="sortTD (18)">▲</button>
					 	<button class="sortBTN" onclick="reverseTD (18)">▼</button>
	                    </th>
						<th class="th">종료
							<button class="sortBTN" onclick="sortTD (19)">▲</button>
						 	<button class="sortBTN" onclick="reverseTD (19)">▼</button>
						</th> 
						<th class="th">고객담당자</th> 
						<th class="th">근무지</th> 
						<th class="th">업무</th> 
						<th class="th">PM</th> 
						<th class="th">투입 명단</th> 
						<th class="th">2020(상)평가유형</th> 
						<th class="th">채용수요</th> 
						<th class="th">외주수요</th>  
                    </tr>
                </thead>
                <tbody> 
                  <%
                  	for(int i=0; i<projectList.size(); i++){
                  		%>
                  		 <tr>
                  		  <td><div><%=projectList.get(i).getTEAM_ORDER()%></div></td>
	                      <td><div><%=projectList.get(i).getTEAM_SALES()%></div></td>                     
	                      <td><div><%=projectList.get(i).getPROJECT_CODE()%></div></td>
	                      
	                      <!-- 권한에 따라 수정페이지 접근 가능 -->
	                      <%if((permission==1 && projectList.get(i).getTEAM_ORDER().equals(myInfo.getTEAM())) || (permission==1 && projectList.get(i).getTEAM_SALES().equals(myInfo.getTEAM())) || permission==0){%>
	                      		<td><a href="project_update.jsp?no=<%=projectList.get(i).getNO()%>"><%=projectList.get(i).getPROJECT_NAME()%></a></td>
	                      <%}else{%>
	                      <td><%=projectList.get(i).getPROJECT_NAME()%></td><%}%>
	                      <td id="state<%=projectList.get(i).getNO()%>"><div><%=projectList.get(i).getSTATE()%></div></td>
	                      <td class="td"><%=projectList.get(i).getPART()%></td>
	                      <td><%=projectList.get(i).getCLIENT()%></td>
	                      <td class="td"><%=projectList.get(i).getClIENT_PART()%></td>
	                      <td class="td"><%=projectList.get(i).getMAN_MONTH()%></td>
	                      <td class="td"><%=projectList.get(i).getPROJECT_DESOPIT()%></td>
	                      <td class="td"><%=projectList.get(i).getFH_ORDER_PROJECTIONS()%></td>
	                      <td class="td"><%=projectList.get(i).getFH_ORDER()%></td>
	                      <td class="td"><%=projectList.get(i).getFH_SALES_PROJECTIONS()%></td>
	                      <td class="td"><%=projectList.get(i).getFH_SALES()%></td>
	                      <td class="td"><%=projectList.get(i).getSH_ORDER_PROJECTIONS()%></td>
	                      <td class="td"><%=projectList.get(i).getSH_ORDER()%></td>
	                      <td class="td"><%=projectList.get(i).getSH_SALES_PROJECTIONS()%></td>
	                      <td class="td"><%=projectList.get(i).getSH_SALES()%></td>
	                      <td class="td"><%=projectList.get(i).getPROJECT_START()%></td>
	                      <td class="td"><%=projectList.get(i).getPROJECT_END()%></td>
	                      <td class="td"><%=projectList.get(i).getCLIENT_PTB()%></td>
	                      <td class="td"><%=projectList.get(i).getWORK_PLACE()%></td>
	                      <td class="td"><%=projectList.get(i).getWORK()%></td>
	                      <td class="td">
	                      <%
	                      	if(i<PMnameList.size()){
	                      		out.print(PMnameList.get(i));
	                      	}
	                      %></td>
	                      <td class="td">
	                      <%
	                      	if(i<workerIdList.size()){ 
	                      		for(int a=0;a<workerIdList.get(i).length;a++){%>
	                      			<%=workerIdList.get(i)[a]%> <%}} %></td>
	                      <td class="td"><%=projectList.get(i).getASSESSMENT_TYPE()%></td>
	                      <td class="td"><%=projectList.get(i).getEMPLOY_DEMAND()%></td>
	                      <td class="td"><%=projectList.get(i).getOUTSOURCE_DEMAND()%></td>
                    	</tr>
                  		<%
                  	}
                  %>
                  </tbody>                            
                </table>
                <script type="text/javascript">
			       var myTable = document.getElementById( "dataTable" ); 
			       var replace = replacement( myTable ); 
			       function sortTD( index ){replace.ascending( index ); } 
			       function reverseTD( index ){replace.descending( index );} 
			       </script>
              </div>   
              </div>     
              <%
	          	if (permission <= 1){
	        		%><div id="project_btn">
	                	 <a href="project_make.jsp" class="btn btn-primary">프로젝트 생성</a>
	              </div><%
        	} %>
   				
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
