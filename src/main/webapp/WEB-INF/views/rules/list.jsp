<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>TradeLog - 매매 원칙</title>

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

        <!-- 상단 -->
        <div class="rules-header">

            <div>

                <h2 class="rules-title">
                    매매 원칙
                </h2>

                <p class="text-secondary mb-0">
                    나만의 매매 원칙을 등록하고 관리합니다.
                </p>

            </div>

            <a href="${pageContext.request.contextPath}/rules/register"
               class="rule-register-btn">
                + 원칙 등록
            </a>

        </div>


        <!-- =========================
             원칙 목록
        ========================== -->
        <div class="rules-list">

            <c:choose>

                <%-- 등록된 원칙이 없는 경우 --%>
                <c:when test="${empty rules}">

                    <div class="rules-empty">

                        <p>
                            등록된 매매 원칙이 없습니다.
                        </p>

                        <a href="${pageContext.request.contextPath}/rules/register">
                            첫 번째 매매 원칙 등록하기
                        </a>

                    </div>

                </c:when>


                <%-- 등록된 원칙이 있는 경우 --%>
                <c:otherwise>

                    <c:forEach var="rule"
                               items="${rules}"
                               varStatus="status">

                        <div class="rule-card">

                            <!-- 카드 상단 -->
                            <div class="rule-card-header">

                                <!-- 화면 표시용 번호 -->
                                <span class="rule-number">
                                    원칙 #${status.index + 1}
                                </span>


                                <!-- 수정 / 삭제 -->
                                <div class="rule-actions">

                                    <!-- 수정 -->
                                    <a href="${pageContext.request.contextPath}/rules/modify?ruleId=${rule.ruleId}"
                                       class="rule-modify-btn">
                                        수정
                                    </a>


                                    <!-- 삭제 -->
                                    <form action="${pageContext.request.contextPath}/rules/delete"
                                          method="post"
                                          class="rule-delete-form"
                                          onsubmit="return confirm('이 매매 원칙을 삭제하시겠습니까?');">

                                        <input type="hidden"
                                               name="ruleId"
                                               value="${rule.ruleId}">

                                        <button type="submit"
                                                class="rule-delete-btn">
                                            삭제
                                        </button>

                                    </form>

                                </div>

                            </div>


                            <!-- 원칙 내용 -->
                            <div class="rule-content">
                                <c:out value="${rule.ruleContent}" />
                            </div>


                            <!-- 등록일 -->
                            <div class="rule-created-at">
                                등록일 ${rule.createdAt.toLocalDate()}
                            </div>

                        </div>

                    </c:forEach>

                </c:otherwise>

            </c:choose>

        </div>

    </main>

</div>


<!-- Bootstrap JS -->
<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js">
</script>

</body>
</html>