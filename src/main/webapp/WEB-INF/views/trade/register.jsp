<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>매매 기록 등록 | TradeLog</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- 공통 CSS -->
    <link href="<c:url value='/resources/css/common.css' />"
          rel="stylesheet">

    <!-- 매매 CSS -->
    <link href="<c:url value='/resources/css/trade.css' />"
          rel="stylesheet">
</head>

<body>

<c:url var="registerUrl" value="/trade/register" />
<c:url var="listUrl" value="/trade/list" />
<c:url var="dashboardUrl" value="/dashboard" />
<c:url var="logoutUrl" value="/member/logout" />

<!-- 상단 네비게이션 -->
<nav class="navbar navbar-expand-lg bg-white border-bottom">
    <div class="container">

        <a class="navbar-brand brand" href="${dashboardUrl}">TradeLog</a>

        <div class="d-flex align-items-center gap-3">
            <span class="text-secondary small">
                <c:out value="${sessionScope.loginMember.loginId}" />
            </span>

            <form action="${logoutUrl}" method="post">
                <button type="submit" class="btn btn-outline-secondary btn-sm">
                    로그아웃
                </button>
            </form>

        </div>
    </div>
</nav>


<!-- 매매 등록 -->
<main class="container trade-container">

    <div class="mb-4">
        <h1 class="trade-title">매매 기록 등록</h1>

        <p class="text-secondary mb-0">
            매수와 매도 내용을 기록하고 나의 투자 과정을 복기해보세요.
        </p>
    </div>


    <div class="card trade-card">

        <div class="card-body">

            <form id="tradeForm" action="${registerUrl}" method="post">

                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        <c:out value="${error}" />
                    </div>
                </c:if>

                <!-- 종목명 -->
                <div class="mb-4">

                    <label for="stockName" class="form-label">종목명</label>
                    <input type="text"
                           class="form-control"
                            id="stockName"
                            name="stockName"
                           value="<c:out value='${trade.stockName}' />"
                            placeholder="예: 삼성전자"
                           autocomplete="off"
                           required>
                           
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


                <!-- 매수 / 매도 날짜 -->
                <div class="row">
                    <div class="col-md-6 mb-4">
                        <label for="buyDate" class="form-label">
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
                    <div class="col-md-6 mb-4">
                        <label for="sellDate" class="form-label">
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
                    <div class="col-md-6 mb-4">
                        <label for="buyPrice" class="form-label">
                            매수가
                        </label>

                        <input type="number"
                               class="form-control"
                               id="buyPrice"
                               name="buyPrice"
                               value="<c:out value='${trade.buyPrice}' />"
                               min="0"
                               step="0.01"
                               placeholder="매수 가격"
                               required>

                        <c:if test="${not empty errors.buyPrice}">
                            <div class="text-danger mt-1"><c:out value="${errors.buyPrice}" /></div>
                        </c:if>
                    </div>

                    <div class="col-md-6 mb-4">
                        <label for="sellPrice" class="form-label">
                            매도가
                        </label>

                        <input type="number"
                               class="form-control"
                               id="sellPrice"
                               name="sellPrice"
                               value="<c:out value='${trade.sellPrice}' />"
                               min="0"
                               step="0.01"
                               placeholder="매도 가격"
                               required>

                        <c:if test="${not empty errors.sellPrice}">
                            <div class="text-danger mt-1"><c:out value="${errors.sellPrice}" /></div>
                        </c:if>
                    </div>
                </div>

                <!-- 수량 -->
                <div class="mb-4">
                    <label for="quantity" class="form-label">
                        수량
                    </label>

                    <input type="number"
                           class="form-control"
                           id="quantity"
                           name="quantity"
                           value="<c:out value='${trade.quantity}' />"
                           min="0.0001"
                           step="0.0001"
                           placeholder="매매 수량"
                           required>

                    <c:if test="${not empty errors.quantity}">
                        <div class="text-danger mt-1"><c:out value="${errors.quantity}" /></div>
                    </c:if>
                </div>

                <!-- 매수 이유 -->
                <div class="mb-4">
                    <label for="buyReason" class="form-label">
                        매수 이유
                    </label>

                    <textarea class="form-control"
                              id="buyReason"
                              name="buyReason"
                               rows="4"
                              maxlength="1000"
                               placeholder="이 종목을 매수한 이유를 기록해보세요.">
                               <c:out value="${trade.buyReason}" />
                               </textarea>

                    <c:if test="${not empty errors.buyReason}">
                        <div class="text-danger mt-1"><c:out value="${errors.buyReason}" /></div>
                    </c:if>
                </div>

                <!-- 매매 복기 -->
                <div class="mb-4">
                    <label for="review" class="form-label">
                        매매 복기
                    </label>

                    <textarea class="form-control"
                              id="review"
                              name="review"
                               rows="5"
                              maxlength="2000"
                               placeholder="잘한 점, 아쉬운 점, 다음 매매에서 개선할 점 등을 기록해보세요.">
                               <c:out value="${trade.review}" />
                               </textarea>

                    <c:if test="${not empty errors.review}">
                        <div class="text-danger mt-1"><c:out value="${errors.review}" /></div>
                    </c:if>
                </div>
				
				<!-- 매매 원칙 적용 -->
				<div class="mb-4">
				    <label class="form-label d-block">
				        매매 원칙
				    </label>
				
				    <p class="text-secondary small">
				        이번 거래에 적용한 원칙과 준수 여부를 선택해주세요.
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
				                                   id="rule_${rule.ruleId}">
				
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
				                                       disabled>
				
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
				                                       disabled>
				
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
                <div class="d-flex justify-content-end gap-2 mt-5">

                    <a href="${listUrl}"
                       class="btn btn-outline-secondary trade-btn">
                        취소
                    </a>

                    <button type="submit"
                            class="btn btn-primary trade-btn">
                        매매 기록 등록
                    </button>
                </div>
            </form>
        </div>
    </div>
</main>

<script>

    const tradeForm = document.getElementById("tradeForm");

    // 종목 검색용 추가
    const stockNameInput = document.getElementById("stockName");
    const stockCodeInput = document.getElementById("stockCode");
    const stockSearchResult = document.getElementById("stockSearchResult");

    // 종목명 입력 감지
    stockNameInput.addEventListener("input", function() {
    	
        // 기존에 선택했던 종목코드 초기화
        stockCodeInput.value = "";

        const keyword = stockNameInput.value;
        
        if (keyword.trim() === "") {

            stockSearchResult.innerHTML = "";

            return;
        }

        fetch("/stock/search?keyword=" + keyword)
        .then(function(response) {
            return response.json();
        })
        .then(function(data) {

            stockSearchResult.innerHTML = "";

            data.slice(0, 10).forEach(function(stock) {

                const item = document.createElement("div");

                item.textContent =
                    stock.stockName + " (" + stock.stockCode + ")";
                
                item.addEventListener("click", function() {

                    // 선택한 종목명을 input에 넣기
                    stockNameInput.value = stock.stockName;
                    
                    // 선택한 종목코드 저장
                    stockCodeInput.value = stock.stockCode;
                    
                    // 검색 결과 목록 비우기
                    stockSearchResult.innerHTML = "";
                    
                });

                stockSearchResult.appendChild(item);

            });

        });

    });


    // ===== 기존 날짜 관련 코드 =====

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
	
	                // 원칙을 선택하면 준수 여부 선택 가능
	                followedY.disabled = false;
	                followedN.disabled = false;
	
	                followedY.required = true;
	                followedN.required = true;
	
	            } else {
	
	                // 원칙 선택을 해제하면 초기화
	                followedY.checked = false;
	                followedN.checked = false;
	
	                followedY.disabled = true;
	                followedN.disabled = true;
	
	                followedY.required = false;
	                followedN.required = false;
	            }
	
	        });
	
	    });
    
    // ===== 기존 form 검증 코드 =====

    tradeForm.addEventListener("submit", function(event) {
    	
    	if (stockCodeInput.value === "") {

    	    alert("검색 결과에서 종목을 선택해주세요.");

    	    event.preventDefault();

    	    return;
    	}

        const buyDate = document.getElementById("buyDate").value;

        const sellDate = document.getElementById("sellDate").value;

        if (sellDate < buyDate) {

            alert("매도일은 매수일보다 빠를 수 없습니다.");

            event.preventDefault();
        }

    });

</script>

</body>
</html>
