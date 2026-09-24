<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt"
           uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>매매일지 상세 | TradeLog</title>


    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">


    <!-- 공통 CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/common.css">


    <!-- Trade CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/trade.css">

</head>


<body>

<div class="app-layout">


    <!-- 왼쪽 Sidebar -->
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />


    <!-- 오른쪽 Main -->
    <main class="main-content">


        <div class="trade-container trade-detail-container">


            <!-- 페이지 상단 -->
            <div class="d-flex justify-content-between align-items-center mb-4">

                <div>

                    <h1 class="trade-title mb-1">
                        매매일지 상세
                    </h1>

                    <p class="text-secondary mb-0">
                        등록한 매매 기록을 확인해보세요.
                    </p>

                </div>


                <a href="${pageContext.request.contextPath}/trade/list"
                   class="btn btn-outline-secondary">

                    목록으로

                </a>

            </div>



            <!-- 상세 카드 -->
            <div class="trade-card card">

                <div class="card-body">


                    <!-- =========================
                         종목 정보
                    ========================== -->

                    <div class="trade-detail-header">

                        <span class="detail-label">
                            종목명
                        </span>

                        <h2 class="detail-stock-name">
                            <c:out value="${trade.stockName}" />
                        </h2>


                        <div class="detail-period">

                            <span>
                                ${trade.buyDate}
                            </span>

                            <span class="detail-period-arrow">
                                →
                            </span>

                            <span>
                                ${trade.sellDate}
                            </span>

                        </div>

                    </div>



                    <!-- =========================
                         거래 성과
                    ========================== -->

                    <div class="detail-performance">

                        <div class="row g-3">


                            <!-- 실현손익 -->
                            <div class="col-md-6">

                                <div class="performance-box">

                                    <span class="detail-label">
                                        실현손익
                                    </span>

                                    <c:choose>

							            <c:when test="${trade.realizedProfit > 0}">
							                <div class="performance-value price-up">
							                    +<fmt:formatNumber
							                        value="${trade.realizedProfit}"
							                        pattern="#,##0.##" />원
							                </div>
							            </c:when>
							
							            <c:when test="${trade.realizedProfit < 0}">
							                <div class="performance-value price-down">
							                    <fmt:formatNumber
							                        value="${trade.realizedProfit}"
							                        pattern="#,##0.##" />원
							                </div>
							            </c:when>
							
							            <c:otherwise>
							                <div class="performance-value price-flat">
							                    <fmt:formatNumber
							                        value="${trade.realizedProfit}"
							                        pattern="#,##0.##" />원
							                </div>
							            </c:otherwise>
							
							        </c:choose>

                                </div>

                            </div>



                            <!-- 수익률 -->
                            <div class="col-md-6">

                                <div class="performance-box">

                                    <span class="detail-label">
                                        수익률
                                    </span>

                                    <c:choose>

							            <c:when test="${trade.returnRate > 0}">
							                <div class="performance-value price-up">
							                    +<fmt:formatNumber
							                        value="${trade.returnRate}"
							                        pattern="#,##0.00" />%
							                </div>
							            </c:when>
							
							            <c:when test="${trade.returnRate < 0}">
							                <div class="performance-value price-down">
							                    <fmt:formatNumber
							                        value="${trade.returnRate}"
							                        pattern="#,##0.00" />%
							                </div>
							            </c:when>
							
							            <c:otherwise>
							                <div class="performance-value price-flat">
							                    <fmt:formatNumber
							                        value="${trade.returnRate}"
							                        pattern="#,##0.00" />%
							                </div>
							            </c:otherwise>
							
							        </c:choose>
                                </div>

                            </div>


                        </div>

                    </div>



                    <!-- =========================
                         거래 정보
                    ========================== -->

                    <section class="detail-section">


                        <h5 class="detail-section-title">
                            거래 정보
                        </h5>


                        <div class="row g-4">


                            <!-- 매수가 -->
                            <div class="col-md-4">

                                <span class="detail-label">
                                    매수가
                                </span>

                                <div class="detail-value">

                                    <fmt:formatNumber
                                        value="${trade.buyPrice}"
                                        pattern="#,##0.##" />원

                                </div>

                            </div>



                            <!-- 매도가 -->
                            <div class="col-md-4">

                                <span class="detail-label">
                                    매도가
                                </span>

                                <div class="detail-value">

                                    <fmt:formatNumber
                                        value="${trade.sellPrice}"
                                        pattern="#,##0.##" />원

                                </div>

                            </div>



                            <!-- 수량 -->
                            <div class="col-md-4">

                                <span class="detail-label">
                                    수량
                                </span>

                                <div class="detail-value">

                                    <fmt:formatNumber
                                        value="${trade.quantity}"
                                        pattern="#,##0.####" />개

                                </div>

                            </div>


                        </div>

                    </section>



                    <!-- =========================
                         매도 이후 가격 변화
                    ========================== -->

                    <section class="detail-section">

                        <h5 class="detail-section-title">
                            매도 이후 가격 변화
                        </h5>

                        <p class="text-secondary small">
                            현재 가격과 비교한 매매 복기용 참고 정보입니다.
                        </p>


                        <c:choose>

						    <c:when test="${not empty stock}">
						
						        <div class="row g-4 mt-1">
						
						
						            <!-- 현재가 -->
						            <div class="col-md-6">
						
						                <span class="detail-label">
						                    현재가
						                </span>
						
						                <div class="detail-value">
						
						                    <fmt:formatNumber
						                        value="${stock.currentPrice}"
						                        pattern="#,##0" />원
						
						                </div>
						
						            </div>
						
						
						            <!-- 매도 이후 변화율 -->
						            <div class="col-md-6">
						
						                <span class="detail-label">
						                    매도 이후 변화율
						                </span>
						
						
						                <c:choose>
						
						                    <c:when test="${priceChangeRate > 0}">
						
						                        <div class="detail-value price-up">
						
						                            +<fmt:formatNumber
						                                value="${priceChangeRate}"
						                                pattern="#,##0.00" />%
						
						                        </div>
						
						                    </c:when>
						
						
						                    <c:when test="${priceChangeRate < 0}">
						
						                        <div class="detail-value price-down">
						
						                            <fmt:formatNumber
						                                value="${priceChangeRate}"
						                                pattern="#,##0.00" />%
						
						                        </div>
						
						                    </c:when>
						
						
						                    <c:otherwise>
						
						                        <div class="detail-value price-flat">
						
						                            <fmt:formatNumber
						                                value="${priceChangeRate}"
						                                pattern="#,##0.00" />%
						
						                        </div>
						
						                    </c:otherwise>
						
						                </c:choose>
						
						            </div>
						
						
						        </div>
						
						    </c:when>
						
						
						    <c:otherwise>
						
						        <div class="text-secondary mt-3">
						            현재 주가 정보를 불러올 수 없습니다.
						        </div>
						
						    </c:otherwise>
						
						</c:choose>

                    </section>



                    <!-- =========================
                         매매 기록
                    ========================== -->

                    <section class="detail-section">


                        <h5 class="detail-section-title">
                            매매 기록
                        </h5>



                        <!-- 매수 이유 -->
                        <div class="detail-record">

                            <span class="detail-label">
                                매수 이유
                            </span>

                            <div class="detail-text"><c:out value="${trade.buyReason}" /></div>

                        </div>



                        <!-- 매매 복기 -->
                        <div class="detail-record mb-0">

                            <span class="detail-label">
                                매매 복기
                            </span>

                            <div class="detail-text"><c:out value="${trade.review}" /></div>

                        </div>


                    </section>



					<!-- =========================
					     매매 원칙
					========================== -->
					
					<section class="detail-section">
					
					    <div class="mb-3">
					
					        <h5 class="detail-section-title mb-1">
					            매매 원칙
					        </h5>
					
					        <span class="text-secondary small">
					            이번 거래에 적용한 매매 원칙과 준수 여부입니다.
					        </span>
					
					    </div>
					
					
					    <c:choose>
					
					        <%-- 적용한 원칙이 없는 경우 --%>
					        <c:when test="${empty ruleChecks}">
					
					            <div class="text-secondary">
					                적용한 매매 원칙이 없습니다.
					            </div>
					
					        </c:when>
					
					
					        <%-- 적용한 원칙이 있는 경우 --%>
					        <c:otherwise>
					
					            <div class="list-group">
					
					                <c:forEach var="ruleCheck" items="${ruleChecks}">
					
					                    <div class="list-group-item
					                                d-flex
					                                justify-content-between
					                                align-items-center">
					
					                        <!-- 원칙 내용 -->
					                        <span>
					                            <c:out value="${ruleCheck.ruleContent}" />
					                        </span>
					
					
					                        <!-- 준수 여부 -->
					                        <c:choose>
					
					                            <c:when test="${ruleCheck.followed eq 'Y'}">
					
					                                <span class="badge text-bg-success">
					                                    준수
					                                </span>
					
					                            </c:when>
					
					                            <c:otherwise>
					
					                                <span class="badge text-bg-danger">
					                                    미준수
					                                </span>
					
					                            </c:otherwise>
					
					                        </c:choose>
					
					                    </div>
					
					                </c:forEach>
					
					            </div>
					
					        </c:otherwise>
					
					    </c:choose>
					
					</section>



                    <!-- =========================
                         수정 / 삭제
                    ========================== -->

                    <div class="detail-actions">


                        <!-- 수정 -->
                        <a href="${pageContext.request.contextPath}/trade/modify?tradeId=${trade.tradeId}"
                           class="btn btn-outline-primary">

                            수정

                        </a>



                        <!-- 삭제 -->
                        <form id="deleteForm"
                              action="${pageContext.request.contextPath}/trade/delete"
                              method="post">


                            <input type="hidden"
                                   name="tradeId"
                                   value="${trade.tradeId}">


                            <button type="submit"
                                    class="btn btn-outline-danger">

                                삭제

                            </button>


                        </form>


                    </div>


                </div>

            </div>


        </div>


    </main>


</div>



<!-- =========================
     삭제 확인
========================== -->

<script>

    const deleteForm =
        document.getElementById("deleteForm");


    deleteForm.addEventListener("submit", function(event) {

        const result =
            confirm("정말 이 매매일지를 삭제하시겠습니까?");


        if (!result) {

            event.preventDefault();

        }

    });

</script>


</body>

</html>
