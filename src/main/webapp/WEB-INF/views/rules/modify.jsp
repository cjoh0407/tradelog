<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>TradeLog - 매매 원칙 수정</title>

    <!-- Bootstrap CSS -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- TradeLog 공통 CSS -->
    <link href="<c:url value='/resources/css/common.css' />"
          rel="stylesheet">

    <!-- Rules CSS -->
    <link href="<c:url value='/resources/css/rules.css' />"
          rel="stylesheet">
</head>

<body>

<div class="app-layout">

    <!-- =========================
         왼쪽 Sidebar
    ========================== -->
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />


    <!-- =========================
         오른쪽 Main
    ========================== -->
    <main class="main-content">

        <!-- 페이지 제목 -->
        <div class="mb-4">

            <h2 class="rules-title">
                매매 원칙 수정
            </h2>

            <p class="text-secondary mb-0">
                등록한 매매 원칙의 내용을 수정합니다.
            </p>

        </div>


        <!-- 수정 폼 -->
        <div class="rule-form-card">

            <form action="${pageContext.request.contextPath}/rules/modify"
                  method="post">

                <input type="hidden"
                       name="ruleId"
                       value="${rule.ruleId}">

                <div class="rule-form-group">

                    <label for="ruleContent">
                        매매 원칙
                    </label>

                    <textarea id="ruleContent"
                              name="ruleContent"
                              rows="6"
                              maxlength="500"
                              placeholder="매매 원칙을 입력하세요."
                              required><c:out value="${rule.ruleContent}" /></textarea>

                    <div class="rule-form-help">
                        실제 매매에서 확인하기 쉽도록 구체적인 원칙을 작성해보세요.
                    </div>

                </div>


                <div class="rule-form-actions">

                    <a href="${pageContext.request.contextPath}/rules"
                       class="rule-cancel-btn">
                        취소
                    </a>

                    <button type="submit"
                            class="rule-submit-btn">
                        수정 완료
                    </button>

                </div>

            </form>

        </div>

    </main>

</div>


<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js">
</script>

</body>
</html>