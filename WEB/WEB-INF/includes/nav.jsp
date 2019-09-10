<!-- 라이브러리 추가 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<title>Guard OWL</title>

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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>

	<div id="navbar-full">
		<nav class="navbar navbar-ct-blue">

			<div class="container">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle">
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
				<div class="collapse navbar-collapse">
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
								<li><a href="/android/Video">Q/A</a></li>
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
							<a href="#" class="btn btn-round btn-default" onclick="document.getElementById('logout-form').submit();">로그아웃</a>
							<form id="logout-form" action='<c:url value='/customLogout'/>'
								method="POST">
								<input name="${_csrf.parameterName}" type="hidden"
									value="${_csrf.token}" />
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

	<div class="main">
		<div class="container tim-container">

			