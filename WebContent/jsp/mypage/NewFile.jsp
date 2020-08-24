<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="tabWrap">
	<ul class="tab_Menu">
		<li class="tabMenu current">
			<a href="#tabContent01" >Tab 1</a>
		</li>
		<li class="tabMenu">
			<a href="#tabContent02" >Tab 2</a>
		</li>
		<li class="tabMenu">
			<a href="#tabContent03" >Tab 3</a>
		</li>
	</ul>
	<div class="tab_Content_Wrap">
		<div id="tabContent01" class="tabPage">
			<table id ="meetingTable">
		<thead>
		 <tr style="white-space:nowrap;">
		   <th>회의명</th>
		   <th>회의 장소 
		   <br>
			   	<input type="button" value="▲" onclick="sortTD (1)">
			   	<input type="button" value="▼" onclick="reverseTD (1)">
		   	</th>
		   <th>회의 일시
		   <br>
			   <input type="button" value="▲" onclick="sortTD (2)">
			   <input type="button" value="▼" onclick="reverseTD (2)"> 
		   </th>
		   <th>작성 일시
		   <br>
			   <input type="button" value="▲" onclick="sortTD (3)">
			   <input type="button" value="▼" onclick="reverseTD (3)">
		   </th>
		   <th>작성자
		   <br>
			   <input type="button" value="▲" onclick="sortTD (4)">
			   <input type="button" value="▼" onclick="reverseTD (4)">
		   </th>
		   </tr>
		  
		  </thead>  
		  </table>
		</div>
		<div id="tabContent02" class="tabPage">
			<div class="container">

    <!-- Outer Row -->
    <div class="row justify-content-center">
		<div class="col-xl-10 col-lg-12 col-md-9">
      <div>
        <div class="card o-hidden border-0 my-5">
          <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row" style="background-color:#4e73df;">
              <div class="d-none d-lg-block"></div>
              <div class="card col-lg-6" style="margin: 0 auto; background-color:#fff;">
                <div class="p-5">
                  <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-4">로그인</h1>
                  </div>
	 	<form class="user" method = "post" action = "../jsp/LoginPro.jsp">
                    <div class="form-group">
                      <input type="text" class="form-control form-control-user" name = "ID" id="ID" aria-describedby="emailHelp" placeholder="ID">
                    </div>
                    <div class="form-group">
                      <input type="password" class="form-control form-control-user" name="PW" id="PW" placeholder="Password" >
                    </div>
                    <!-- <div class="form-group">
                      <div class="custom-control custom-checkbox small">
                        <input type="checkbox" class="custom-control-input" id="customCheck">
                        <label class="custom-control-label" for="customCheck">자동로그인</label>
                      </div>
                    </div> -->
                    <div>
                    <input id="login" type="submit" name="login" value="Login" class="btn btn-primary btn-user btn-block">
                    </div>
                     
                  </form>
                  <hr>
                  <div class="text-center">
                    <a class="small" href="../jsp/release.html">FVMS_2.4_2020-08-20: 17:30</a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
 </div>

  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sb-admin-2.min.js"></script>

		</div>
		<div id="tabContent03" class="tabPage">
			Tab3 Content
		</div>
	</div>
</div>




<style>
	.tabWrap { width: 900px; height: 500px; }
	.tab_Menu { margin: 0px; padding: 0px; list-style: none; }
	.tabMenu { width: 150px; margin: 0px; text-align: center; 
			   padding-top: 10px; padding-bottom: 10px; float: left; }
		.tabMenu a { color: #000000; font-weight: bold; text-decoration: none; }
	.current { background-color: #FFFFFF; 
			   border: 1px solid blue; border-bottom:hidden; }
	.tabPage { width: 900px; height: 470px; float: left; 
			   border: 1px solid blue; }
</style>


<!-- include application-chart.min.css -->
<link rel="stylesheet" type="text/css" href="bower_components/tui-chart/dist/chart.min.css" />

<!-- include libraries -->
<script src="bower_components/tui-code-snippet/code-snippet.min.js"></script>
<script src="bower_components/tui-component-effects/effects.min.js"></script>
<script src="bower_components/raphael/raphael-min.js"></script>
<!-- include chart.min.js -->
<script src="bower_components/tui-chart/dist/chart.min.js"></script>


<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.0.min.js" ></script>
<script type="text/javascript">
	function tabSetting() {
		// 탭 컨텐츠 hide 후 현재 탭메뉴 페이지만 show
		$('.tabPage').hide();
		$($('.current').find('a').attr('href')).show();

		// Tab 메뉴 클릭 이벤트 생성
		$('li').click(function (event) {
			var tagName = event.target.tagName; // 현재 선택된 태그네임
			var selectedLiTag = (tagName.toString() == 'A') ? $(event.target).parent('li') : $(event.target); // A태그일 경우 상위 Li태그 선택, Li태그일 경우 그대로 태그 객체
			var currentLiTag = $('li[class~=current]'); // 현재 current 클래그를 가진 탭
			var isCurrent = false;  
			
			// 현재 클릭된 탭이 current를 가졌는지 확인
			isCurrent = $(selectedLiTag).hasClass('current');
			
			// current를 가지지 않았을 경우만 실행
			if (!isCurrent) {
				$($(currentLiTag).find('a').attr('href')).hide();
				$(currentLiTag).removeClass('current');

				$(selectedLiTag).addClass('current');
				$($(selectedLiTag).find('a').attr('href')).show();
			}

			return false;
		});
	}

	$(function () {
		// 탭 초기화 및 설정
		tabSetting();
	});
</script>