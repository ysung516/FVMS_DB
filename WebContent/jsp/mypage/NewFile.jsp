bower install tui-chart
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
			
		</div>
		<div id="tabContent02" class="tabPage">
			Tab2 Content
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