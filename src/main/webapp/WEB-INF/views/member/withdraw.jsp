<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">

<title>회원 탈퇴 | TradeLog</title>

<!-- Bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- 공통 CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/common.css">

</head>

<body>

	<div class="app-layout">
		<!-- Sidebar -->
		<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />

		<!-- Main -->
		<main class="main-content">
			<div class="container py-5">
				<div class="row justify-content-center">
					<div class="col-lg-6 col-md-8">
					
						<!-- 제목 -->
						<div class="mb-4">
							<h1 class="fw-bold mb-2">회원 탈퇴</h1>
							<p class="text-secondary mb-0">TradeLog 회원 탈퇴를 진행합니다.</p>
						</div>

						<!-- 주의사항 -->
						<div class="alert alert-danger mb-4">
							<h5 class="alert-heading fw-bold">탈퇴 전 확인해주세요.</h5>
							<p class="mb-2">회원 탈퇴 시 회원 정보와 함께 저장된 매매 기록 및 매매 원칙이 모두 삭제됩니다.</p>
							<p class="mb-0">삭제된 데이터는 복구할 수 없습니다.</p>
						</div>

						<!-- 탈퇴 카드 -->
						<div class="card shadow-sm">
							<div class="card-body p-4">
								<h5 class="fw-bold mb-3">비밀번호 확인</h5>
								<p class="text-secondary small mb-4">본인 확인을 위해 현재 비밀번호를 입력해주세요.</p>

								<form action="${pageContext.request.contextPath}/member/withdraw" method="post" id="withdrawForm">
									<!-- 비밀번호 -->
									<div class="mb-3">
										<label for="password" class="form-label"> 비밀번호 </label> 
										<input type="password" class="form-control" id="password"
												name="password" placeholder="현재 비밀번호를 입력하세요"
												autocomplete="current-password" required>
									</div>

									<!-- 서버에서 비밀번호 오류가 발생한 경우 -->
									<c:if test="${not empty error}">
										<div class="alert alert-danger py-2">
											<c:out value="${error}" />
										</div>
									</c:if>

									<!-- 버튼 -->
									<div class="d-flex justify-content-end gap-2 mt-4">
										<a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-secondary"> 취소 </a>
										<button type="submit" class="btn btn-danger">회원 탈퇴</button>
									</div>
								</form>

							</div>
						</div>
					</div>
				</div>
			</div>
		</main>
	</div>

<script>
    const withdrawForm = document.getElementById("withdrawForm");

    withdrawForm.addEventListener("submit", function(event) {
        const confirmed = confirm(
                "정말 회원 탈퇴하시겠습니까?\n\n" +
                "회원 정보와 모든 매매 데이터가 삭제되며 복구할 수 없습니다.");

        if (!confirmed) {
            event.preventDefault();
        }
    });

</script>
</body>
</html>