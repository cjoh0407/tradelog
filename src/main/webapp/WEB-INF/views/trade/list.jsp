<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt"
           uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">

    <title>매매일지 관리 | TradeLog</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- 공통 CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/common.css">

    <!-- 매매 관리 CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/trade.css">
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

        <div class="trade-container">

            <!-- 페이지 상단 -->
            <div class="d-flex justify-content-between align-items-center mb-4">

                <div>

                    <h1 class="trade-title mb-1">
                        매매일지 관리
                    </h1>

                    <p class="text-secondary mb-0">
                        나의 매매 기록을 확인하고 복기해보세요.
                    </p>

                </div>

                <a href="${pageContext.request.contextPath}/trade/register"
                   class="btn btn-primary">
                    + 매매 기록 등록
                </a>

            </div>


            <!-- =========================
                 검색 / 기간 / 정렬
            ========================== -->
            <div class="mb-4">

                <form id="searchForm"
                      action="${pageContext.request.contextPath}/trade/list"
                      method="get"
                      class="d-flex align-items-center gap-2 flex-wrap">

                    <!-- 종목명 -->
                    <input type="text"
                           class="form-control trade-search-input"
                           name="keyword"
                           value="<c:out value='${keyword}' />"
                           placeholder="종목명을 입력하세요">


                    <!-- 시작일 -->
                    <input type="date"
                           class="form-control trade-date-input"
                           name="startDate"
                           value="${startDate}">

                    <span class="text-secondary">
                        ~
                    </span>


                    <!-- 종료일 -->
                    <input type="date"
                           class="form-control trade-date-input"
                           name="endDate"
                           value="${endDate}">


                    <!-- 정렬 -->
                    <select name="sort"
                            class="form-select trade-sort-select">

                        <option value=""
                                ${empty sort ? 'selected' : ''}>
                            최신순
                        </option>

                        <option value="oldest"
                                ${sort eq 'oldest' ? 'selected' : ''}>
                            오래된순
                        </option>

                        <option value="returnDesc"
                                ${sort eq 'returnDesc' ? 'selected' : ''}>
                            수익률 높은순
                        </option>

                        <option value="returnAsc"
                                ${sort eq 'returnAsc' ? 'selected' : ''}>
                            수익률 낮은순
                        </option>

                    </select>


                    <!-- 검색 -->
                    <button type="submit"
                            class="btn btn-dark">
                        검색
                    </button>


                    <!-- 초기화 -->
                    <c:if test="${not empty keyword
                               or not empty startDate
                               or not empty endDate
                               or not empty sort}">

                        <a href="${pageContext.request.contextPath}/trade/list"
                           class="btn btn-outline-secondary">
                            초기화
                        </a>

                    </c:if>

                </form>

            </div>


            <!-- =========================
                 매매 기록이 없는 경우
            ========================== -->
            <c:if test="${empty list}">

                <div class="trade-card card">

                    <div class="card-body text-center py-5">

                        <h5 class="mb-2">
                            조회된 매매 기록이 없습니다.
                        </h5>

                        <p class="text-secondary mb-0">
                            검색 조건을 변경하거나 새로운 매매 기록을 등록해보세요.
                        </p>

                    </div>

                </div>

            </c:if>


            <!-- =========================
                 매매 기록이 있는 경우
            ========================== -->
            <c:if test="${not empty list}">

                <div class="trade-card card">

                    <div class="card-body p-0">

                        <div class="table-responsive">

                            <table class="table table-hover align-middle mb-0">

                                <thead>

                                    <tr>
                                        <th>번호</th>
                                        <th>종목명</th>
                                        <th>매수일</th>
                                        <th>매도일</th>
                                        <th>매수가</th>
                                        <th>매도가</th>
                                        <th>수량</th>
                                        <th>실현손익</th>
                                        <th>수익률</th>
                                    </tr>

                                </thead>

                                <tbody>

									<c:forEach var="trade"
									           items="${list}"
									           varStatus="status">

                                        <tr class="trade-row"
                                            onclick="location.href='${pageContext.request.contextPath}/trade/detail?tradeId=${trade.tradeId}'">


											<!-- 번호 -->
											<td>
											    ${(page - 1) * 10 + status.index + 1}
											</td>


                                            <!-- 종목명 -->
                                            <td class="fw-semibold">
                                                <c:out value="${trade.stockName}" />
                                            </td>


                                            <!-- 매수일 -->
                                            <td>
                                                ${trade.buyDate}
                                            </td>


                                            <!-- 매도일 -->
                                            <td>
                                                ${trade.sellDate}
                                            </td>


                                            <!-- 매수가 -->
                                            <td>

                                                <fmt:formatNumber
                                                    value="${trade.buyPrice}"
                                                    pattern="#,##0.##" />원

                                            </td>


                                            <!-- 매도가 -->
                                            <td>

                                                <fmt:formatNumber
                                                    value="${trade.sellPrice}"
                                                    pattern="#,##0.##" />원

                                            </td>


                                            <!-- 수량 -->
                                            <td>

                                                <fmt:formatNumber
                                                    value="${trade.quantity}"
                                                    pattern="#,##0.####" />개

                                            </td>


                                            <!-- 실현손익 -->
                                            <td>

                                                <c:choose>

                                                    <c:when test="${trade.realizedProfit > 0}">

                                                        <span class="price-up">

                                                            +<fmt:formatNumber
                                                                value="${trade.realizedProfit}"
                                                                pattern="#,##0.##" />원

                                                        </span>

                                                    </c:when>


                                                    <c:when test="${trade.realizedProfit < 0}">

                                                        <span class="price-down">

                                                            <fmt:formatNumber
                                                                value="${trade.realizedProfit}"
                                                                pattern="#,##0.##" />원

                                                        </span>

                                                    </c:when>


                                                    <c:otherwise>

                                                        <span class="price-flat">

                                                            <fmt:formatNumber
                                                                value="${trade.realizedProfit}"
                                                                pattern="#,##0.##" />원

                                                        </span>

                                                    </c:otherwise>

                                                </c:choose>

                                            </td>


                                            <!-- 수익률 -->
                                            <td>

                                                <c:choose>

                                                    <c:when test="${trade.returnRate > 0}">

                                                        <span class="price-up">

                                                            +<fmt:formatNumber
                                                                value="${trade.returnRate}"
                                                                pattern="#,##0.00" />%

                                                        </span>

                                                    </c:when>


                                                    <c:when test="${trade.returnRate < 0}">

                                                        <span class="price-down">

                                                            <fmt:formatNumber
                                                                value="${trade.returnRate}"
                                                                pattern="#,##0.00" />%

                                                        </span>

                                                    </c:when>


                                                    <c:otherwise>

                                                        <span class="price-flat">

                                                            <fmt:formatNumber
                                                                value="${trade.returnRate}"
                                                                pattern="#,##0.00" />%

                                                        </span>

                                                    </c:otherwise>

                                                </c:choose>

                                            </td>

                                        </tr>

                                    </c:forEach>

                                </tbody>

                            </table>

                        </div>

                    </div>

                </div>


                <!-- =========================
                     페이징
                ========================== -->
               <c:if test="${totalPages > 1}">
				    <nav class="mt-4">
				        <ul class="pagination justify-content-center">
				
				            <!-- 이전 -->
				            <li class="page-item ${startPage == 1 ? 'disabled' : ''}">
				                <a class="page-link"
				                   href="${pageContext.request.contextPath}/trade/list?page=${startPage - 1}&keyword=${keyword}&startDate=${startDate}&endDate=${endDate}&sort=${sort}">
				                    이전
				                </a>
				            </li>
				
				            <!-- 페이지 번호 -->
				            <c:forEach var="pageNumber"
				                       begin="${startPage}"
				                       end="${endPage}">
				
				                <li class="page-item ${page == pageNumber ? 'active' : ''}">
				                    <a class="page-link"
				                       href="${pageContext.request.contextPath}/trade/list?page=${pageNumber}&keyword=${keyword}&startDate=${startDate}&endDate=${endDate}&sort=${sort}">
				                        ${pageNumber}
				                    </a>
				                </li>
				
				            </c:forEach>
				
				            <!-- 다음 -->
				            <li class="page-item ${endPage == totalPages ? 'disabled' : ''}">
				                <a class="page-link"
				                   href="${pageContext.request.contextPath}/trade/list?page=${endPage + 1}&keyword=${keyword}&startDate=${startDate}&endDate=${endDate}&sort=${sort}">
				                    다음
				                </a>
				            </li>
				
				        </ul>
				    </nav>
				</c:if>
            </c:if>

        </div>

    </main>

</div>


<!-- =========================
     기간 검색 검증
========================== -->
<script>

    const searchForm =
            document.getElementById("searchForm");

    searchForm.addEventListener("submit", function(event) {

        const startDate =
                document.querySelector("[name='startDate']").value;

        const endDate =
                document.querySelector("[name='endDate']").value;


        if (startDate && endDate && startDate > endDate) {

            alert("종료일은 시작일보다 빠를 수 없습니다.");

            event.preventDefault();
        }

    });

</script>

</body>

</html>
