<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@include file="../../includes/nav.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table class="table table-striped">
    <thead>
        <tr>
            <th>사용자</th>
            <th>권한</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="user" items="${ users }">
            <tr>
                <td>${ user.mem_id }</td>
                <td>
                    <c:forEach var="authority" items="${ user.authList }">
                        ${ authority.auth }<br>
                    </c:forEach>
                </td>
                <td>
                    <p>
                        <c:url var="changeRolePath" value="/admin/admin/role/${ user.mem_id }" />
                        <a href="${ changeRolePath }/admin" class="btn btn-default <c:if test="${ user.hasRole('ADMIN') }">btn-primary</c:if>">관리자</a>
                        <a href="${ changeRolePath }/manager" class="btn btn-default <c:if test="${ user.hasRole('MANAGER') }">btn-primary</c:if>">매니저</a>
                        <a href="${ changeRolePath }/user" class="btn btn-default <c:if test="${ user.hasRole('USER') }">btn-primary</c:if>">사용자</a>
                    </p>

                </td>
            </tr>
        </c:forEach>
    </tbody>
<%@include file="../../includes/footer.jsp"%>
