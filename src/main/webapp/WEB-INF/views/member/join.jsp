<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>TradeLog - 회원가입</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
      rel="stylesheet">
<!-- TradeLog 공통 CSS -->
<link href="<c:url value='/resources/css/common.css' />"
      rel="stylesheet">
<!-- 회원 관련 CSS -->
<link href="<c:url value='/resources/css/member.css' />"
      rel="stylesheet">
      
</head>

<body>
<!-- URL 생성 -->
<c:url var="registerUrl" value="/member/register" />
<c:url var="loginUrl" value="/" />

<div class="container">
    <div class="member-container mx-auto">
        <!-- 서비스 이름 -->
        <div class="text-center mt-5 mb-4">
            <h2 class="brand">TradeLog</h2>
			<p class="brand-description">
			    나의 매매를 기록하고 분석해보세요.
			</p>
        </div>

        <!-- 회원가입 카드 -->
        <div class="card member-card">
            <div class="card-body p-4">
                <h4 class="member-title mb-4">
				    회원가입
				</h4>

                <!-- 서버에서 전달받은 에러 메시지 -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        <c:out value="${error}" />
                    </div>
                </c:if>

                <!-- 회원가입 Form -->
                <form id="registerForm" action="${registerUrl}" method="post">
                    <!-- 아이디 -->
                    <div class="mb-3">
                        <label for="loginId" class="form-label">아이디</label>
                        <input type="text" class="form-control" id="loginId" name="loginId" value="<c:out value='${member.loginId}' />" placeholder="아이디를 입력하세요" autocomplete="username" required>
                        <div id="loginIdMessage" class="form-text">4자 이상 입력해주세요.</div>
                    </div>

                    <!-- 비밀번호 -->
                    <div class="mb-4">
                        <label for="password" class="form-label">비밀번호</label>
                        <input type="password" class="form-control" id="password" name="password" 
                        		placeholder="비밀번호를 입력하세요" autocomplete="new-password" required>
                        <div id="passwordMessage" class="form-text">4자 이상 입력해주세요.</div>
                    </div>

                    <!-- 회원가입 버튼 -->
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary btn-member">
						    회원가입
						</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- 로그인 이동 -->
        <div class="text-center mt-3">
            <span class="text-secondary"> 이미 계정이 있으신가요? </span>
            <a href="${loginUrl}" class="member-link text-decoration-none">
			    로그인
			</a>
        </div>
    </div>
</div>


<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

<!-- 회원가입 검증 -->
<script>

    const registerForm = document.querySelector("#registerForm");
    const loginId = document.querySelector("#loginId");
    const password = document.querySelector("#password");

    registerForm.addEventListener("submit", function(event) {

        // 앞뒤 공백 제거
        const loginIdValue = loginId.value.trim();
        const passwordValue = password.value.trim();


        // 아이디 길이 검증
        if (loginIdValue.length < 4) {
            alert("아이디는 4자 이상 입력해주세요.");
            loginId.focus();
            event.preventDefault();
            return;
        }


        // 비밀번호 길이 검증
        if (passwordValue.length < 4) {
            alert("비밀번호는 4자 이상 입력해주세요.");
            password.focus();
            event.preventDefault();
            return;
        }
    });

</script>

</body>
</html>
