<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<div class="timeline-footer text-center">한국어© 2023 Instagram from
	Meta</div>
<div class="text-center">

	<%-- 로그인 되어있을 때만 노출 --%>
	<c:if test="${not empty userId}">
		<a href="/user/sign_out"
				class="text-primary font-weight-bold"> 로그아웃</a>
				
			<%-- 내 개인 화면으로 이동 --%>
			<a href="#"><b class="login-id">${loginId}</b></a>
	</c:if>
	
	<%-- 로그아웃 되어있을 때만 노출 --%>
	<c:if test="${empty userId}">
		<a href="/user/sign_in_view"
			class="text-primary font-weight-bold"> 로그인하기</a>
	</c:if>
</div>