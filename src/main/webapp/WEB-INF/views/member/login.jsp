<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>TradeLog - 로그인</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	  rel="stylesheet">
		
<!--  TradeLog 공통 CSS -->
<link href="<c:url value='/resources/css/common.css' />"
	  rel="stylesheet">
		
<!-- 회원 관련 CSS -->
<link href="<c:url value='/resources/css/member.css' />"
      rel="stylesheet">

</head>
<body>

<!-- URL 생성 -->
<c:url var="loginUrl" value="/member/login" />
<c:url var="registerUrl" value="/member/register" />

<div class="container">
	<div class="member-container mx-auto">
		
		<div class="text-center mt-5 mb-4">
			<h2 class="brand">TradeLog</h2>
			<p class="brand-description">
				나의 매매를 기록하고 분석해보세요.
			</p>
		</div>
		
		<!-- 로그인 실패 메시지 -->
		<div class="card member-card">
		
			<div class="card-body p-4">
				<h4 class="member-title mb-4">로그인</h4>
				<c:if test="${not empty error}">
					<div class="alert alert-danger" role="alert"><c:out value="${error}" /></div>
				</c:if>
			
		
			<form id="loginForm" action="${loginUrl}" method="post">
				<div class="mb-3">
					<label for="loginId" class="form-label">아이디</label>
					<input type="text" class="form-control" id="loginId" name="loginId" 
						placeholder="아이디를 입력하세요" autocomplete="username" required>
				</div>
				<div class="mb-4">
					<label for="password" class="form-label">비밀번호</label>
					<input type="password" class="form-control" id="password" name="password" 
						placeholder="비밀번호를 입력하세요" autocomplete="current-password" required>
				</div>
				<div class="d-grid">
					<button type="submit" class="btn btn-primary btn-member">로그인</button>
				</div>
			</form>
			</div>
		</div>
		<div class="text-center mt-3">
			<span class="text-secondary">아직 계정이 없으신가요?</span>
			<a href="${registerUrl}" class="member-link text-decoration-none">회원가입</a>
		</div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<script>
	const loginForm = document.querySelector("#loginForm");
	const loginId = document.querySelector("#loginId");
	const password = document.querySelector("#password");
	
	loginForm.addEventListener("submit", function(event){
		const loginIdValue = loginId.value.trim();
		const passwordValue = password.value.trim();
		
		if(loginIdValue.length === 0){
			alert("아이디를 입력해주세요.");
			loginId.focus();
			event.preventDefault();
			return;
		}
		
		if(passwordValue.length === 0){
			alert("비밀번호를 입력해주세요.");
			password.focus();
			event.preventDefault();
			return;
		}
	});
</script>

</body>


</html>
