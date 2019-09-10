<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8" />
<link rel="apple-touch-icon" sizes="76x76"
	href="<c:url value="/mainresources/assets/img/apple-icon.png"/>">
<link rel="icon" type="image/png"
	href="<c:url value="/mainresources/assets/img/favicon.png"/>">

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>Guardian OWL</title>

<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'
	name='viewport' />
<meta name="viewport" content="width=device-width" />

<link href="/mainresources/bootstrap3/css/bootstrap.css"
	rel="stylesheet" />
<link href="/mainresources/assets/css/gsdk.css" rel="stylesheet" />
<link href="/mainresources/assets/css/demo.css" rel="stylesheet" />

<!--     Font Awesome     -->
<link href="/mainresources/bootstrap3/css/font-awesome.css"
	rel="stylesheet">
<link href='http://fonts.googleapis.com/css?family=Grand+Hotel'
	rel='stylesheet' type='text/css'>
</head>
<body>
	<!-- 회원가입 체크  -->
	<script type="text/javascript">
		/*  $(function(){
			if('${msg}' == null){
				alert('${msg}');	
			};
		 }); */

		function registerCheckFunction() {
			var member_id = $('#member_id').val();
			$.ajax({
				type : 'POST',
				url : '/userRegisterCheck',
				data : {
					userID : userID
				},
				success : function(result) {
					if (result == 1) {
						$('#checkMessage').html('사용할 수 있는 아이디입니다.');
						$('#checkType').attr('class',
								'modal-content panel-success');
					} else {
						$('#checkMessage').html('사용할 수 없는 아이디입니다.');
						$('#checkType').attr('class',
								'modal-content panel-warning');
					}
					$('#checkModal').modal("show");
				}
			});
		}

		function passwordCheckFunction() {
			var userPassword = $('#mem_pwd').val();
			var userPassword2 = $('#mem_pwd2').val();

			if (userPassword != userPassword2) {
				$('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');
			} else {
				$('#passwordCheckMessage').html('비밀번호가 서로 일치 합니다..');
			}
		}
	</script>

	<div id="navbar-full">
		<div class="container">
			<nav
				class="navbar navbar-ct-blue navbar-transparent navbar-fixed-top"
				role="navigation">

				<div class="container">
					<!-- Brand and toggle get grouped for better mobile display -->
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse"
							data-target="#bs-example-navbar-collapse-1">
							<span class="sr-only">Toggle navigation</span> <span
								class="icon-bar"></span> <span class="icon-bar"></span> <span
								class="icon-bar"></span>
						</button>
						<a href="/mainPage">
							<div class="logo-container">
								<div class="logo">
									<img src="<c:url value="/mainresources/assets/img/logo.png"/>">
								</div>
								<div class="brand">GOWL</div>
							</div>
						</a>
					</div>

					<!-- Collect the nav links, forms, and other content for toggling -->
					<div class="collapse navbar-collapse"
						id="bs-example-navbar-collapse-1">
						<ul class="nav navbar-nav"> 
							<li class="active"><a href="/chest/chestMain">금고</a></li>
						<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')">
 	                    <li class="active"><a href="/request/page">승인</a></li>
 	                    </sec:authorize>
							<li class="dropdown"><a href="#gsdk" class="dropdown-toggle"
								data-toggle="dropdown">게시판 <b class="caret"></b></a>
								<ul class="dropdown-menu">
									<li><a href="/board/list_N">공지사항</a></li>
									<li><a href="/board/list">자유게시판</a></li>
									<li><a href="/board/list_Q">Q/A</a></li>
									<li class="divider"></li>
									<li><a href="/android/ArduinoImage">동영상 메뉴</a></li>
								</ul></li>
							<li><a href="javascript:void(0);" data-toggle="search"
								class="hidden-xs"><i class="fa fa-search"></i></a></li>
						</ul>
						<form class="navbar-form navbar-left navbar-search-form"
							role="search">
							<div class="form-group">
								<input type="text" value="" class="form-control"
									placeholder="Search...">
							</div>
						</form>

						<ul class="nav navbar-nav navbar-right">
							<sec:authorize access="hasRole('ROLE_ADMIN')">
								<li><button class="btn btn-simple btn-default"
										data-toggle="modal" onclick="location.href='/admin/admin'">관리자</button></li>
							</sec:authorize>

							<sec:authorize access="isAuthenticated()">
								<li><button class="btn btn-simple btn-default"
										onclick="location.href='/userEdit'">정보수정</button></li>
								<li>
									<form role="form" method="post" action="/customLogout">
										<fieldset>
											<a href="index.html"
												class="btn btn-round btn-default btn-logout">로그아웃</a>
										</fieldset>
										<input type="hidden" name="${_csrf.parameterName }"
											value="${_csrf.token }" />
									</form>
								</li>
							</sec:authorize>

							<sec:authorize access="isAnonymous()">
								<li><button class="btn btn-simple btn-default"
										onclick="location.href='/signUp'">회원가입</button></li>
								<li><button class="btn btn-round btn-default"
										onclick="location.href='/customLogin'">로그인</button></li>
							</sec:authorize>
						</ul>

					</div>
					<!-- /.navbar-collapse -->
				</div>
				<!-- /.container-fluid -->
			</nav>
		</div>
	</div>
	<!--  end container-->

	<div class='blurred-container'>
		<div class="motto">
			<div>Guard</div>
			<div class="border no-right-border">금</div>
			<div class="border">고</div>
			<div>OWL</div>
		</div>
		<div class="img-src"
			style="background-image: url('${pageContext.request.contextPath}/mainresources/assets/img/back.jpg')"></div>
		<div class='img-src blur'
			style="background-image: url('${pageContext.request.contextPath}/mainresources/assets/img/back_blur.png')"></div>
	</div>

	<div class="main">
		<div class="container tim-container">

			<div class="tim-title">
				<h2>
					프로젝트 소개 <small>사용기술</small>
				</h2>
			</div>

			<div class="row">
				<div class="col-md-4">
					<h3>WEB</h3>

					<img src="<c:url value="/mainresources/assets/img/WEB.png"/>"
						style="width: 300px; height: 267px;">


				</div>
				<div class="col-md-4">
					<h3>APP</h3>
					<img src="<c:url value="/mainresources/assets/img/app.png"/>"
						style="width: 300px; height: 267px;">

				</div>
				<div class="col-md-4">
					<h3>아두이노/NFC</h3>
					<img src="<c:url value="/mainresources/assets/img/nfc.PNG"/>"
						style="width: 400px; height: 267px;">
				</div>
			</div>
			<br> <br>
			<div class="tim-title">
				<h2>
					프로젝트 소개 <small>구성도</small>
				</h2>
			</div>

			<div class="row">
				<div class="col-md-7 col-md-offset-0 col-sm-10 col-sm-offset-1">
					<div class="text-center">
						<img src="<c:url value="/mainresources/assets/img/project.PNG"/>"
							alt="Rounded Image" class="img-rounded img-responsive img-dog">
					</div>
				</div>
				<div class="col-md-5 col-sm-12">
					<h1 class="text-center">
						금고 프로젝트 <small class="subtitle">GUARD OWL</small>
					</h1>				
					<hr>
					<p>
						<br> 공용 보관함의 위치적 한계와 개별 보관 시스템을 제공하는 <br> 서비스의 부재로 독자적인
						보관함 서비스를 제공하며 <br> 개폐장치 이외의 보안 장치가 없는 기존의 보관함과 보관함 자체를 탈취하는
						것에 대한 위험을 <br> Arduino와 NFC를 통해 <br> 2중보안이 가능하도록 설계한
						프로젝트입니다.
					</p>
				</div>
			</div>
		</div>
		<!--     end extras -->
	</div>
	<!-- end container -->
	<div class="space-30"></div>
	<!-- end container -->
	<div class="space-30"></div>
	</div>

	<footer style="background-color: #000000; color: #ffffff">
		<div class="row">
			<div class="col-sm-3" style="text-align: center;">
				<img src="<c:url value="/mainresources/assets/img/logob.png"/>"
					style="width: 66px; height: 66px;">
			</div>
			<div class="col-sm-6" style="text-align: center;">
				<h5>Copyright &copy; 2O18</h5>
				<h5>Guardian Owl</h5>
			</div>
			<div class="col-sm-3" style="text-align: center;">
				<img src="<c:url value="/mainresources/assets/img/logob.png"/>"
					style="width: 66px; height: 66px;">
			</div>
		</div>
	</footer>



	</div>
</body>
<script src="<c:url value="/mainresources/jquery/jquery-1.10.2.js"/>"
	type="text/javascript"></script>
<script
	src="<c:url value="/mainresources/assets/js/jquery-ui-1.10.4.custom.min.js"/>"
	type="text/javascript"></script>

<script src="<c:url value="/mainresources/bootstrap3/js/bootstrap.js"/>"
	type="text/javascript"></script>
<script src="<c:url value="/mainresources/assets/js/gsdk-checkbox.js"/>"></script>
<script src="<c:url value="/mainresources/assets/js/gsdk-radio.js"/>"></script>
<script
	src="<c:url value="/mainresources/assets/js/gsdk-bootstrapswitch.js"/>"></script>
<script src="<c:url value="/mainresources/assets/js/get-shit-done.js"/>"></script>
<script src="<c:url value="/mainresources/assets/js/custom.js"/>"></script>
<script type="text/javascript">

var passwordMsg = '${passwordMsg}'; 
	$(function(){
		if(${passwordMsg != null }){
			alert(passwordMsg);
		};
	})
</script>


<script>
	$(".btn-logout").on("click", function(e) {
		e.preventDefault();
		$("form").submit();
	});
</script>

<script type="text/javascript">
	$('.btn-tooltip').tooltip();
	$('.label-tooltip').tooltip();
	$('.pick-class-label').click(function() {
		var new_class = $(this).attr('new-class');
		var old_class = $('#display-buttons').attr('data-class');
		var display_div = $('#display-buttons');
		if (display_div.length) {
			var display_buttons = display_div.find('.btn');
			display_buttons.removeClass(old_class);
			display_buttons.addClass(new_class);
			display_div.attr('data-class', new_class);
		}
	});
	$("#slider-range").slider({
		range : true,
		min : 0,
		max : 500,
		values : [ 75, 300 ],
	});
	$("#slider-default").slider({
		value : 70,
		orientation : "horizontal",
		range : "min",
		animate : true
	});
	$('.carousel').carousel({
		interval : 4000
	});
</script>
</html>