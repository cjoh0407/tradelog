<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>TradeLog - 대시보드</title>

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- TradeLog 공통 CSS -->
<link href="<c:url value='/resources/css/common.css' />"
	rel="stylesheet">

<!-- Dashboard CSS -->
<link href="<c:url value='/resources/css/dashboard.css' />"
	rel="stylesheet">

</head>

<body>

	<!-- URL 생성 -->
	<c:url var="tradeListUrl" value="/trade/list" />
	<c:url var="tradeRegisterUrl" value="/trade/register" />


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

				<h2 class="dashboard-title">대시보드</h2>

				<p class="text-secondary mb-0">나의 매매 기록과 투자 성과를 확인해보세요.</p>

			</div>


			<!-- =========================
             요약 카드
        ========================== -->
			<div class="row row-cols-1 row-cols-md-2 row-cols-xl-5 g-3 mb-5">

				<!-- 총 매매 -->
				<div class="col">

					<div class="card dashboard-card">

						<div class="card-body">

							<span class="dashboard-label"> 총 매매 </span>

							<h3 class="dashboard-value">
								<fmt:formatNumber value="${totalCount}" pattern="#,##0" />
								건
							</h3>

						</div>

					</div>

				</div>


				<!-- 총 손익 -->
				<div class="col">

					<div class="card dashboard-card">

						<div class="card-body">

							<span class="dashboard-label"> 총 손익 </span>

							<c:choose>

								<c:when test="${totalProfit > 0}">
									<h3 class="dashboard-value price-up">
										+
										<fmt:formatNumber value="${totalProfit}" pattern="#,##0.##" />
										원
									</h3>
								</c:when>

								<c:when test="${totalProfit < 0}">
									<h3 class="dashboard-value price-down">
										<fmt:formatNumber value="${totalProfit}" pattern="#,##0.##" />
										원
									</h3>
								</c:when>

								<c:otherwise>
									<h3 class="dashboard-value price-flat">
										<fmt:formatNumber value="${totalProfit}" pattern="#,##0.##" />
										원
									</h3>
								</c:otherwise>

							</c:choose>

						</div>

					</div>

				</div>


				<!-- 평균 수익률 -->
				<div class="col">

					<div class="card dashboard-card">

						<div class="card-body">

							<span class="dashboard-label"> 평균 수익률 </span>

							<c:choose>

								<c:when test="${averageReturnRate > 0}">
									<h3 class="dashboard-value price-up">
										+
										<fmt:formatNumber value="${averageReturnRate}"
											pattern="#,##0.00" />
										%
									</h3>
								</c:when>

								<c:when test="${averageReturnRate < 0}">
									<h3 class="dashboard-value price-down">
										<fmt:formatNumber value="${averageReturnRate}"
											pattern="#,##0.00" />
										%
									</h3>
								</c:when>

								<c:otherwise>
									<h3 class="dashboard-value price-flat">
										<fmt:formatNumber value="${averageReturnRate}"
											pattern="#,##0.00" />
										%
									</h3>
								</c:otherwise>

							</c:choose>

						</div>

					</div>

				</div>


				<!-- 매매 원칙 준수율 -->
				<div class="col">

					<div class="card dashboard-card">

						<div class="card-body">

							<span class="dashboard-label"> 매매 원칙 준수율 </span>

							<h3 class="dashboard-value">
								<fmt:formatNumber value="${ruleComplianceRate}"
									pattern="#,##0.00" />
								%
							</h3>

						</div>

					</div>

				</div>

				<!-- 승률 -->
				<div class="col">

					<div class="card dashboard-card">

						<div class="card-body">

							<span class="dashboard-label"> 승률 </span>

							<h3 class="dashboard-value">
								<fmt:formatNumber value="${winRate}" pattern="#,##0.00" />
								%
							</h3>

						</div>

					</div>

				</div>

			</div>


			<!-- =========================
             최근 매매
        ========================== -->
			<div class="card dashboard-card">

				<div class="card-body">

					<div
						class="d-flex justify-content-between
                            align-items-center mb-4">

						<div>

							<h5 class="mb-1">최근 매매 기록</h5>

							<span class="text-secondary small"> 최근 등록한 매매를 확인할 수 있습니다.
							</span>

						</div>


						<a href="${tradeRegisterUrl}" class="btn btn-primary"> + 매매
							기록하기 </a>

					</div>


					<!-- 최근 매매가 없는 경우 -->
					<c:if test="${empty recentTrades}">
						<div class="empty-trade text-center">

							<p class="mb-2">아직 등록된 매매 기록이 없습니다.</p>

							<span class="text-secondary small"> 첫 매매 기록을 등록해보세요. </span>

						</div>
					</c:if>

					<!-- 최근 매매가 있을 경우 -->
					<c:if test="${not empty recentTrades}">
						<div class="table-responsive">
							<table class="table table-hover align-middle">
								<thead>
									<tr>
										<th>종목명</th>
										<th>매수일</th>
										<th>매도일</th>
										<th>실현손익</th>
										<th>수익률</th>
										<th>원칙준수</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="trade" items="${recentTrades}">
										<tr class="trade-row"
											onclick="location.href='${pageContext.request.contextPath}/trade/detail?tradeId=${trade.tradeId}'">
											<td class="fw-semibold">${trade.stockName}</td>
											<td>${trade.buyDate}</td>
											<td>${trade.sellDate}</td>

											<td><c:choose>
													<c:when test="${trade.realizedProfit > 0}">
														<span class="price-up"> +<fmt:formatNumber
																value="${trade.realizedProfit}" pattern="#,##0.##" />원
														</span>
													</c:when>

													<c:when test="${trade.realizedProfit < 0}">
														<span class="price-down"> <fmt:formatNumber
																value="${trade.realizedProfit}" pattern="#,##0.##" />원
														</span>
													</c:when>

													<c:otherwise>
														<span class="price-flat"> <fmt:formatNumber
																value="${trade.realizedProfit}" pattern="#,##0.##" />원
														</span>
													</c:otherwise>
												</c:choose></td>

											<td><c:choose>
													<c:when test="${trade.returnRate > 0}">
														<span class="price-up"> +<fmt:formatNumber
																value="${trade.returnRate}" pattern="#,##0.00" />%
														</span>
													</c:when>

													<c:when test="${trade.returnRate < 0}">
														<span class="price-down"> <fmt:formatNumber
																value="${trade.returnRate}" pattern="#,##0.00" />%
														</span>
													</c:when>

													<c:otherwise>
														<span class="price-flat"> <fmt:formatNumber
																value="${trade.returnRate}" pattern="#,##0.00" />%
														</span>
													</c:otherwise>
												</c:choose></td>
												
											<td>
											    <c:choose>
											        <c:when test="${trade.totalRuleCount == 0}">
											            <span class="text-secondary">
											                적용 원칙 없음
											            </span>
											        </c:when>
											
											        <c:otherwise>
											            <span>
											                ${trade.followedRuleCount} / ${trade.totalRuleCount} 준수
											            </span>
											        </c:otherwise>
											    </c:choose>
											</td>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</c:if>

					<!-- 전체 매매일지 이동 -->
					<div class="text-end mt-4">

						<a href="${tradeListUrl}" class="text-decoration-none"> 전체
							매매일지 보기 → </a>

					</div>

				</div>

			</div>

		</main>

	</div>


	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js">
		
	</script>

</body>
</html>