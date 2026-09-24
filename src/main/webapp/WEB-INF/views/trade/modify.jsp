<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>매매일지 수정 | TradeLog</title>

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

    <!-- Sidebar -->
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />


    <!-- Main -->
    <main class="main-content">

        <div class="trade-container">

            <!-- 페이지 제목 -->
            <div class="mb-4">

                <h1 class="trade-title mb-1">
                    매매일지 수정
                </h1>

                <p class="text-secondary mb-0">
                    기존 매매 기록을 수정합니다.
                </p>

            </div>


            <!-- 수정 Form -->
            <div class="card">

                <div class="card-body">

                    <form id="tradeForm"
					      action="${pageContext.request.contextPath}/trade/modify"
					      method="post">

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                <c:out value="${error}" />
                            </div>
                        </c:if>

                        <!-- 수정할 매매의 PK -->
                        <input type="hidden"
                               name="tradeId"
                               value="${trade.tradeId}">


                        <!-- 종목명 -->
						<div class="mb-3">
						
						    <label for="stockName"
						           class="form-label">
						        종목명
						    </label>
						
						    <input type="text"
						           class="form-control"
						           id="stockName"
						           name="stockName"
							           value="<c:out value='${trade.stockName}' />"
						           autocomplete="off"
						           required>
						
						    <!-- 종목 코드 -->
						    <input type="hidden"
						           id="stockCode"
						           name="stockCode"
							           value="<c:out value='${trade.stockCode}' />">

                        <c:if test="${not empty errors.stockName}">
                            <div class="text-danger mt-1"><c:out value="${errors.stockName}" /></div>
                        </c:if>
                        <c:if test="${not empty errors.stockCode}">
                            <div class="text-danger mt-1"><c:out value="${errors.stockCode}" /></div>
                        </c:if>
						
						    <!-- 종목 검색 결과 -->
						    <div id="stockSearchResult">
						    </div>
						
						</div>


                        <!-- 매수일 / 매도일 -->
                        <div class="row">

                            <div class="col-md-6 mb-3">

                                <label for="buyDate"
                                       class="form-label">
                                    매수일
                                </label>

                                <input type="date"
                                       class="form-control"
                                       id="buyDate"
                                       name="buyDate"
                                       value="<c:out value='${trade.buyDate}' />"
                                       required>

                                <c:if test="${not empty errors.buyDate}">
                                    <div class="text-danger mt-1"><c:out value="${errors.buyDate}" /></div>
                                </c:if>

                            </div>


                            <div class="col-md-6 mb-3">

                                <label for="sellDate"
                                       class="form-label">
                                    매도일
                                </label>

                                <input type="date"
                                       class="form-control"
                                       id="sellDate"
                                       name="sellDate"
                                       value="<c:out value='${trade.sellDate}' />"
                                       required>

                                <c:if test="${not empty errors.sellDate}">
                                    <div class="text-danger mt-1"><c:out value="${errors.sellDate}" /></div>
                                </c:if>

                            </div>

                        </div>


                        <!-- 매수가 / 매도가 -->
                        <div class="row">

                            <div class="col-md-6 mb-3">

                                <label for="buyPrice"
                                       class="form-label">
                                    매수가
                                </label>

                                <input type="number"
                                       class="form-control"
                                       id="buyPrice"
                                       name="buyPrice"
                                       value="<c:out value='${trade.buyPrice}' />"
                                       step="0.01"
                                       min="0"
                                       required>

                                <c:if test="${not empty errors.buyPrice}">
                                    <div class="text-danger mt-1"><c:out value="${errors.buyPrice}" /></div>
                                </c:if>

                            </div>


                            <div class="col-md-6 mb-3">

                                <label for="sellPrice"
                                       class="form-label">
                                    매도가
                                </label>

                                <input type="number"
                                       class="form-control"
                                       id="sellPrice"
                                       name="sellPrice"
                                       value="<c:out value='${trade.sellPrice}' />"
                                       step="0.01"
                                       min="0"
                                       required>

                                <c:if test="${not empty errors.sellPrice}">
                                    <div class="text-danger mt-1"><c:out value="${errors.sellPrice}" /></div>
                                </c:if>

                            </div>

                        </div>


                        <!-- 수량 -->
                        <div class="mb-3">

                            <label for="quantity"
                                   class="form-label">
                                수량
                            </label>

                            <input type="number"
                                   class="form-control"
                                   id="quantity"
                                   name="quantity"
                                   value="<c:out value='${trade.quantity}' />"
                                   step="0.0001"
                                   min="0"
                                   required>

                            <c:if test="${not empty errors.quantity}">
                                <div class="text-danger mt-1"><c:out value="${errors.quantity}" /></div>
                            </c:if>

                        </div>


                        <!-- 매수 이유 -->
                        <div class="mb-3">

                            <label for="buyReason"
                                   class="form-label">
                                매수 이유
                            </label>

                            <textarea class="form-control"
                                      id="buyReason"
                                      name="buyReason"
                                      rows="4"><c:out value="${trade.buyReason}" /></textarea>

                            <c:if test="${not empty errors.buyReason}">
                                <div class="text-danger mt-1"><c:out value="${errors.buyReason}" /></div>
                            </c:if>

                        </div>


                        <!-- 매매 복기 -->
                        <div class="mb-3">

                            <label for="review"
                                   class="form-label">
                                매매 복기
                            </label>

                            <textarea class="form-control"
                                      id="review"
                                      name="review"
                                      rows="5"><c:out value="${trade.review}" /></textarea>

                            <c:if test="${not empty errors.review}">
                                <div class="text-danger mt-1"><c:out value="${errors.review}" /></div>
                            </c:if>

                        </div>


                       <!-- 매매 원칙 -->
						<div class="mb-4">
						
						    <label class="form-label d-block">
						        매매 원칙
						    </label>
						
						    <p class="text-secondary small">
						        이번 거래에 적용한 원칙과 준수 여부를 수정해주세요.
						    </p>
						
						    <c:choose>
						
						        <%-- 등록한 원칙이 없는 경우 --%>
						        <c:when test="${empty rules}">
						
						            <div class="alert alert-light border">
						                등록된 매매 원칙이 없습니다.
						
						                <a href="${pageContext.request.contextPath}/rules/register">
						                    원칙 등록하기
						                </a>
						            </div>
						
						        </c:when>
						
						        <%-- 등록한 원칙이 있는 경우 --%>
						        <c:otherwise>
						
						            <div class="trade-rule-list">
						
						                <c:forEach var="rule" items="${rules}">
						
						                    <div class="trade-rule-item">
						
						                        <!-- 원칙 선택 -->
						                        <div class="form-check mb-2">
						
						                            <input class="form-check-input rule-checkbox"
						                                   type="checkbox"
						                                   name="ruleIds"
						                                   value="${rule.ruleId}"
						                                   id="rule_${rule.ruleId}"
						                                   ${ruleCheckMap[rule.ruleId] != null ? 'checked' : ''}>
						
						                            <label class="form-check-label"
						                                   for="rule_${rule.ruleId}">
						                                <c:out value="${rule.ruleContent}" />
						                            </label>
						
						                        </div>
						
						
						                        <!-- 준수 / 미준수 -->
						                        <div class="rule-followed-options ms-4">
						
						                            <div class="form-check form-check-inline">
						
						                                <input class="form-check-input"
						                                       type="radio"
						                                       name="followed_${rule.ruleId}"
						                                       id="followedY_${rule.ruleId}"
						                                       value="Y"
						                                       ${ruleCheckMap[rule.ruleId] eq 'Y' ? 'checked' : ''}
						                                       ${ruleCheckMap[rule.ruleId] == null ? 'disabled' : ''}
						                                       ${ruleCheckMap[rule.ruleId] != null ? 'required' : ''}>
						
						                                <label class="form-check-label"
						                                       for="followedY_${rule.ruleId}">
						                                    준수
						                                </label>
						
						                            </div>
						
						
						                            <div class="form-check form-check-inline">
						
						                                <input class="form-check-input"
						                                       type="radio"
						                                       name="followed_${rule.ruleId}"
						                                       id="followedN_${rule.ruleId}"
						                                       value="N"
						                                       ${ruleCheckMap[rule.ruleId] eq 'N' ? 'checked' : ''}
						                                       ${ruleCheckMap[rule.ruleId] == null ? 'disabled' : ''}
						                                       ${ruleCheckMap[rule.ruleId] != null ? 'required' : ''}>
						
						                                <label class="form-check-label"
						                                       for="followedN_${rule.ruleId}">
						                                    미준수
						                                </label>
						
						                            </div>
						
						                        </div>
						
						                    </div>
						
						                </c:forEach>
						
						            </div>
						
						        </c:otherwise>
						
						    </c:choose>
						
						</div>


                        <!-- 버튼 -->
                        <div class="d-flex justify-content-end gap-2">

                            <a href="${pageContext.request.contextPath}/trade/detail?tradeId=${trade.tradeId}"
                               class="btn btn-outline-secondary">
                                취소
                            </a>

                            <button type="submit"
                                    class="btn btn-primary">
                                수정 완료
                            </button>

                        </div>

                    </form>

                </div>

            </div>

        </div>

    </main>

</div>


<script>
    const tradeForm = document.getElementById("tradeForm");
    
 // ===== 종목 검색 =====

    const stockNameInput =
        document.getElementById("stockName");

    const stockCodeInput =
        document.getElementById("stockCode");

    const stockSearchResult =
        document.getElementById("stockSearchResult");

    stockNameInput.addEventListener("input", function() {

        // 종목명을 직접 수정하면 기존 종목코드 초기화
        stockCodeInput.value = "";

        const keyword = stockNameInput.value;

        if (keyword.trim() === "") {
            stockSearchResult.innerHTML = "";
            return;
        }

        fetch("/stock/search?keyword=" + encodeURIComponent(keyword))
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {

                stockSearchResult.innerHTML = "";

                data.slice(0, 10).forEach(function(stock) {

                    const item =
                        document.createElement("div");

                    item.textContent =
                        stock.stockName +
                        " (" +
                        stock.stockCode +
                        ")";

                    item.addEventListener("click", function() {

                        stockNameInput.value =
                            stock.stockName;

                        stockCodeInput.value =
                            stock.stockCode;

                        stockSearchResult.innerHTML = "";
                    });

                    stockSearchResult.appendChild(item);
                });
            });
    });
    
    const now = new Date();

    const year = now.getFullYear();
    const month = String(now.getMonth() + 1).padStart(2, "0");
    const day = String(now.getDate()).padStart(2, "0");

    const today = year + "-" + month + "-" + day;

    document.getElementById("buyDate").max = today;
    document.getElementById("sellDate").max = today;

 // ===== 매매 원칙 선택 =====

    const ruleCheckboxes =
        document.querySelectorAll(".rule-checkbox");

    ruleCheckboxes.forEach(function(checkbox) {

        checkbox.addEventListener("change", function() {

            const ruleId = checkbox.value;

            const followedY =
                document.getElementById("followedY_" + ruleId);

            const followedN =
                document.getElementById("followedN_" + ruleId);

            if (checkbox.checked) {

                followedY.disabled = false;
                followedN.disabled = false;

                followedY.required = true;
                followedN.required = true;

            } else {

                followedY.checked = false;
                followedN.checked = false;

                followedY.disabled = true;
                followedN.disabled = true;

                followedY.required = false;
                followedN.required = false;
            }

        });

    });
    
    
    tradeForm.addEventListener("submit", function(event) {

        if (stockCodeInput.value === "") {

            alert("검색 결과에서 종목을 선택해주세요.");

            event.preventDefault();

            return;
        }

        const buyDate =
            document.getElementById("buyDate").value;

        const sellDate =
            document.getElementById("sellDate").value;

        if (sellDate < buyDate) {

            alert("매도일은 매수일보다 빠를 수 없습니다.");

            event.preventDefault();
        }
    });
</script>

</body>
</html>
