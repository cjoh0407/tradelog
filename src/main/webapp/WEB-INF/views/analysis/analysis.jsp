<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>매매 분석 | TradeLog</title>

<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
    rel="stylesheet">

<link rel="stylesheet"
    href="${pageContext.request.contextPath}/resources/css/common.css">

<link rel="stylesheet"
    href="${pageContext.request.contextPath}/resources/css/analysis.css">

</head>

<body>

<div class="app-layout">

    <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />

    <main class="main-content">

        <div class="analysis-container">

            <!-- 페이지 상단 -->
            <div class="mb-4">

                <h1 class="analysis-title mb-1">
                    매매 분석
                </h1>

                <p class="text-secondary mb-0">
                    누적 거래 데이터를 기반으로 나의 매매 성과를 분석합니다.
                </p>

            </div>


            <!-- ==========================================
                 1. 전체 매매 성과
            =========================================== -->
            <section>

                <h5 class="analysis-section-title">
                    전체 매매 성과
                </h5>

                <div class="row g-3">

                    <!-- 총 거래 -->
                    <div class="col-md-6 col-xl-3">

                        <div class="analysis-card">

                            <span class="analysis-label">
                                총 거래 수
                            </span>

                            <div class="analysis-value">
                                ${totalCount}건
                            </div>

                        </div>

                    </div>


                    <!-- 승률 -->
                    <div class="col-md-6 col-xl-3">

                        <div class="analysis-card">

                            <span class="analysis-label">
                                승률
                            </span>

                            <div class="analysis-value">

                                <fmt:formatNumber
                                    value="${winRate}"
                                    pattern="#,##0.00" />%

                            </div>

                        </div>

                    </div>


                    <!-- 총 실현손익 -->
                    <div class="col-md-6 col-xl-3">

                        <div class="analysis-card">

                            <span class="analysis-label">
                                총 실현손익
                            </span>

                            <c:choose>

                                <c:when test="${totalProfit > 0}">

                                    <div class="analysis-value price-up">

                                        +<fmt:formatNumber
                                            value="${totalProfit}"
                                            pattern="#,##0.##" />원

                                    </div>

                                </c:when>

                                <c:when test="${totalProfit < 0}">

                                    <div class="analysis-value price-down">

                                        <fmt:formatNumber
                                            value="${totalProfit}"
                                            pattern="#,##0.##" />원

                                    </div>

                                </c:when>

                                <c:otherwise>

                                    <div class="analysis-value price-flat">
                                        0원
                                    </div>

                                </c:otherwise>

                            </c:choose>

                        </div>

                    </div>


                    <!-- 평균 수익률 -->
                    <div class="col-md-6 col-xl-3">

                        <div class="analysis-card">

                            <span class="analysis-label">
                                평균 수익률
                            </span>

                            <c:choose>

                                <c:when test="${averageReturnRate > 0}">

                                    <div class="analysis-value price-up">

                                        +<fmt:formatNumber
                                            value="${averageReturnRate}"
                                            pattern="#,##0.00" />%

                                    </div>

                                </c:when>

                                <c:when test="${averageReturnRate < 0}">

                                    <div class="analysis-value price-down">

                                        <fmt:formatNumber
                                            value="${averageReturnRate}"
                                            pattern="#,##0.00" />%

                                    </div>

                                </c:when>

                                <c:otherwise>

                                    <div class="analysis-value price-flat">
                                        0.00%
                                    </div>

                                </c:otherwise>

                            </c:choose>

                        </div>

                    </div>

                </div>

            </section>


            <!-- ==========================================
                 2. 월별 성과
            =========================================== -->
            <section class="analysis-section">

                <h5 class="analysis-section-title">
                    월별 성과
                </h5>

                <p class="text-secondary mb-3">
                    최근 5개월의 총 실현손익 변화를 확인합니다.
                </p>

                <c:choose>

                    <c:when test="${empty monthlyAnalysisList}">

                        <div class="alert alert-light border">
                            분석할 월별 거래 데이터가 없습니다.
                        </div>

                    </c:when>

                    <c:otherwise>

                        <div class="chart-card">

                            <div class="monthly-chart-container">
                                <canvas id="monthlyProfitChart"></canvas>
                            </div>

                        </div>

                    </c:otherwise>

                </c:choose>

            </section>


            <!-- ==========================================
                 3. 종목별 성과
            =========================================== -->
            <section class="analysis-section">

                <h5 class="analysis-section-title">
                    종목별 성과
                </h5>

                <p class="text-secondary mb-3">
                    거래한 종목별 성과와 주요 종목의 실현손익을 확인합니다.
                </p>

                <c:choose>

                    <c:when test="${empty stockAnalysisList}">

                        <div class="alert alert-light border">
                            분석할 종목 데이터가 없습니다.
                        </div>

                    </c:when>

                    <c:otherwise>

                        <div class="row g-4">

                            <!-- 종목별 성과 표 -->
                            <div class="col-lg-6">

                                <div class="analysis-card h-100">

                                    <h6 class="mb-3">
                                        종목별 성과
                                    </h6>

                                    <div class="table-responsive stock-table-container">

                                        <table class="table align-middle">

                                            <thead>

                                                <tr>
                                                    <th>종목명</th>
                                                    <th>거래</th>
                                                    <th>승률</th>
                                                    <th>평균 수익률</th>
                                                    <th>총 손익</th>
                                                </tr>

                                            </thead>

                                            <tbody>

                                                <c:forEach
                                                    var="stock"
                                                    items="${stockAnalysisList}">

                                                    <tr>

                                                        <td>

                                                            <div>
                                                                <c:out value="${stock.stockName}" />
                                                            </div>

                                                            <small class="text-secondary">
                                                                <c:out value="${stock.stockCode}" />
                                                            </small>

                                                        </td>

                                                        <td>
                                                            ${stock.tradeCount}건
                                                        </td>

                                                        <td>

                                                            <fmt:formatNumber
                                                                value="${stock.winRate}"
                                                                pattern="#,##0.00" />%

                                                        </td>

                                                        <td>

                                                            <c:choose>

                                                                <c:when test="${stock.averageReturnRate > 0}">

                                                                    <span class="price-up">

                                                                        +<fmt:formatNumber
                                                                            value="${stock.averageReturnRate}"
                                                                            pattern="#,##0.00" />%

                                                                    </span>

                                                                </c:when>

                                                                <c:when test="${stock.averageReturnRate < 0}">

                                                                    <span class="price-down">

                                                                        <fmt:formatNumber
                                                                            value="${stock.averageReturnRate}"
                                                                            pattern="#,##0.00" />%

                                                                    </span>

                                                                </c:when>

                                                                <c:otherwise>

                                                                    <span class="price-flat">
                                                                        0.00%
                                                                    </span>

                                                                </c:otherwise>

                                                            </c:choose>

                                                        </td>

                                                        <td>

                                                            <c:choose>

                                                                <c:when test="${stock.totalProfit > 0}">

                                                                    <span class="price-up">

                                                                        +<fmt:formatNumber
                                                                            value="${stock.totalProfit}"
                                                                            pattern="#,##0.##" />원

                                                                    </span>

                                                                </c:when>

                                                                <c:when test="${stock.totalProfit < 0}">

                                                                    <span class="price-down">

                                                                        <fmt:formatNumber
                                                                            value="${stock.totalProfit}"
                                                                            pattern="#,##0.##" />원

                                                                    </span>

                                                                </c:when>

                                                                <c:otherwise>

                                                                    <span class="price-flat">
                                                                        0원
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


                            <!-- 종목별 TOP10 차트 -->
                            <div class="col-lg-6">

                                <div class="chart-card h-100">

                                    <h6 class="mb-1">
                                        주요 종목 손익
                                    </h6>

                                    <p class="text-secondary small mb-3">
                                        손익 규모가 큰 상위 10개 종목
                                    </p>

                                    <div class="stock-chart-container">
                                        <canvas id="stockProfitChart"></canvas>
                                    </div>

                                </div>

                            </div>

                        </div>

                    </c:otherwise>

                </c:choose>

            </section>


            <!-- ==========================================
                 4. 원칙별 성과
            =========================================== -->
            <section class="analysis-section">

                <h5 class="analysis-section-title">
                    원칙별 성과
                </h5>

                <p class="text-secondary mb-3">
                    매매 원칙별 성과와 준수 여부에 따른 수익률을 비교합니다.
                </p>

                <c:choose>

                    <c:when test="${empty ruleAnalysisList}">

                        <div class="alert alert-light border">
                            분석할 매매 원칙이 없습니다.
                        </div>

                    </c:when>

                    <c:otherwise>

                        <div class="row g-4">

                            <!-- 원칙별 성과 표 -->
                            <div class="col-lg-6">

                                <div class="analysis-card h-100">

                                    <h6 class="mb-3">
                                        원칙별 성과
                                    </h6>

                                    <div class="table-responsive rule-table-container">

                                        <table class="table align-middle">

                                            <thead>

                                                <tr>
                                                    <th>매매 원칙</th>
                                                    <th>거래</th>
                                                    <th>준수율</th>
                                                    <th>평균 수익률</th>
                                                    <th>총 손익</th>
                                                </tr>

                                            </thead>

                                            <tbody>

                                                <c:forEach
                                                    var="rule"
                                                    items="${ruleAnalysisList}">

                                                    <tr>

                                                        <td>
                                                            <c:out value="${rule.ruleContent}" />
                                                        </td>

                                                        <td>
                                                            ${rule.tradeCount}건
                                                        </td>

                                                        <td>

                                                            <fmt:formatNumber
                                                                value="${rule.complianceRate}"
                                                                pattern="#,##0.00" />%

                                                        </td>

                                                        <td>

                                                            <c:choose>

                                                                <c:when test="${rule.averageReturnRate > 0}">

                                                                    <span class="price-up">

                                                                        +<fmt:formatNumber
                                                                            value="${rule.averageReturnRate}"
                                                                            pattern="#,##0.00" />%

                                                                    </span>

                                                                </c:when>

                                                                <c:when test="${rule.averageReturnRate < 0}">

                                                                    <span class="price-down">

                                                                        <fmt:formatNumber
                                                                            value="${rule.averageReturnRate}"
                                                                            pattern="#,##0.00" />%

                                                                    </span>

                                                                </c:when>

                                                                <c:otherwise>

                                                                    <span class="price-flat">
                                                                        0.00%
                                                                    </span>

                                                                </c:otherwise>

                                                            </c:choose>

                                                        </td>

                                                        <td>

                                                            <c:choose>

                                                                <c:when test="${rule.totalProfit > 0}">

                                                                    <span class="price-up">

                                                                        +<fmt:formatNumber
                                                                            value="${rule.totalProfit}"
                                                                            pattern="#,##0.##" />원

                                                                    </span>

                                                                </c:when>

                                                                <c:when test="${rule.totalProfit < 0}">

                                                                    <span class="price-down">

                                                                        <fmt:formatNumber
                                                                            value="${rule.totalProfit}"
                                                                            pattern="#,##0.##" />원

                                                                    </span>

                                                                </c:when>

                                                                <c:otherwise>

                                                                    <span class="price-flat">
                                                                        0원
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


                            <!-- 원칙별 TOP5 차트 -->
                            <div class="col-lg-6">

                                <div class="chart-card h-100">

                                    <h6 class="mb-1">
                                        준수 / 위반 성과
                                    </h6>

                                    <p class="text-secondary small mb-3">
                                        거래 횟수가 많은 상위 5개 원칙의 평균 수익률 비교
                                    </p>

                                    <div class="rule-chart-container">
                                        <canvas id="rulePerformanceChart"></canvas>
                                    </div>

                                </div>

                            </div>

                        </div>

                    </c:otherwise>

                </c:choose>

            </section>

        </div>

    </main>

</div>


<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>

/* ==========================================
   월별 손익 차트
========================================== */

const monthlyLabels = [
    <c:forEach var="month"
               items="${monthlyAnalysisList}"
               varStatus="status">
        '${month.tradeMonth}'<c:if test="${!status.last}">,</c:if>
    </c:forEach>
];

const monthlyProfits = [
    <c:forEach var="month"
               items="${monthlyAnalysisList}"
               varStatus="status">
        ${month.totalProfit}<c:if test="${!status.last}">,</c:if>
    </c:forEach>
];

const monthlyChartValues =
    monthlyProfits.map(profit => Math.abs(profit));

const monthlyColors =
    monthlyProfits.map(profit => {

        if (profit > 0) {
            return 'rgba(220, 53, 69, 0.7)';
        }

        if (profit < 0) {
            return 'rgba(13, 110, 253, 0.7)';
        }

        return 'rgba(108, 117, 125, 0.7)';
    });

const monthlyCtx =
    document.getElementById('monthlyProfitChart');

if (monthlyCtx) {

    new Chart(monthlyCtx, {

        type: 'bar',

        data: {

            labels: monthlyLabels,

            datasets: [{

                label: '월별 실현손익',

                data: monthlyChartValues,

                backgroundColor: monthlyColors,

                borderRadius: 6,

                maxBarThickness: 70,

                categoryPercentage: 0.7,

                barPercentage: 0.8
            }]
        },

        options: {

            responsive: true,

            maintainAspectRatio: false,

            scales: {

                y: {

                    beginAtZero: true,

                    ticks: {

                        callback: function(value) {
                            return value.toLocaleString() + '원';
                        }
                    }
                }
            },

            plugins: {

                legend: {
                    display: false
                },

                tooltip: {

                    callbacks: {

                        label: function(context) {

                            const index =
                                context.dataIndex;

                            const realProfit =
                                monthlyProfits[index];

                            return '실현손익: '
                                + realProfit.toLocaleString()
                                + '원';
                        }
                    }
                }
            }
        }
    });
}


/* ==========================================
   종목별 TOP10 차트
========================================== */

const stockLabels = [
    <c:forEach var="stock"
               items="${stockAnalysisList}"
               varStatus="status">
        '<c:out value="${stock.stockName}" />'<c:if test="${!status.last}">,</c:if>
    </c:forEach>
];

const stockProfits = [
    <c:forEach var="stock"
               items="${stockAnalysisList}"
               varStatus="status">
        ${stock.totalProfit}<c:if test="${!status.last}">,</c:if>
    </c:forEach>
];

const stockData =
    stockLabels.map((label, index) => ({
        label: label,
        profit: stockProfits[index]
    }));

const topStocks =
    stockData
        .sort(
            (a, b) =>
                Math.abs(b.profit)
                - Math.abs(a.profit)
        )
        .slice(0, 10);

const stockChartLabels =
    topStocks.map(stock => stock.label);

const stockChartProfits =
    topStocks.map(stock => stock.profit);

const stockChartValues =
    stockChartProfits.map(
        profit => Math.abs(profit)
    );

const stockColors =
    stockChartProfits.map(profit => {

        if (profit > 0) {
            return 'rgba(220, 53, 69, 0.7)';
        }

        if (profit < 0) {
            return 'rgba(13, 110, 253, 0.7)';
        }

        return 'rgba(108, 117, 125, 0.7)';
    });

const stockCtx =
    document.getElementById('stockProfitChart');

if (stockCtx) {

    new Chart(stockCtx, {

        type: 'bar',

        data: {

            labels: stockChartLabels,

            datasets: [{

                label: '종목별 실현손익',

                data: stockChartValues,

                backgroundColor: stockColors,

                borderRadius: 6,

                maxBarThickness: 24,

                categoryPercentage: 0.7,

                barPercentage: 0.8
            }]
        },

        options: {

            indexAxis: 'y',

            responsive: true,

            maintainAspectRatio: false,

            scales: {

                x: {

                    beginAtZero: true,

                    ticks: {

                        callback: function(value) {
                            return value.toLocaleString() + '원';
                        }
                    },

                    grid: {
                        color: 'rgba(0, 0, 0, 0.05)'
                    }
                },

                y: {

                    grid: {
                        display: false
                    }
                }
            },

            plugins: {

                legend: {
                    display: false
                },

                tooltip: {

                    callbacks: {

                        label: function(context) {

                            const index =
                                context.dataIndex;

                            const realProfit =
                                stockChartProfits[index];

                            return '실현손익: '
                                + realProfit.toLocaleString()
                                + '원';
                        }
                    }
                }
            }
        }
    });
}


/* ==========================================
   원칙별 TOP5 준수 / 위반 성과 차트
========================================== */

/*
 * 전체 원칙 데이터를 먼저 가져온다.
 */
const ruleLabels = [
    <c:forEach var="rule"
               items="${ruleComparisonList}"
               varStatus="status">
        '<c:out value="${rule.ruleContent}" />'<c:if test="${!status.last}">,</c:if>
    </c:forEach>
];

const followedTradeCounts = [
    <c:forEach var="rule"
               items="${ruleComparisonList}"
               varStatus="status">
        ${rule.followedTradeCount}<c:if test="${!status.last}">,</c:if>
    </c:forEach>
];

const notFollowedTradeCounts = [
    <c:forEach var="rule"
               items="${ruleComparisonList}"
               varStatus="status">
        ${rule.notFollowedTradeCount}<c:if test="${!status.last}">,</c:if>
    </c:forEach>
];

const followedReturns = [
    <c:forEach var="rule"
               items="${ruleComparisonList}"
               varStatus="status">
        ${rule.followedAverageReturnRate}<c:if test="${!status.last}">,</c:if>
    </c:forEach>
];

const notFollowedReturns = [
    <c:forEach var="rule"
               items="${ruleComparisonList}"
               varStatus="status">
        ${rule.notFollowedAverageReturnRate}<c:if test="${!status.last}">,</c:if>
    </c:forEach>
];


/*
 * 원칙별 데이터를 하나의 객체로 묶는다.
 *
 * tradeCount
 * = 준수 거래 수 + 위반 거래 수
 */
const ruleData =
    ruleLabels.map((label, index) => ({

        label: label,

        tradeCount:
            followedTradeCounts[index]
            + notFollowedTradeCounts[index],

        followedReturn:
            followedReturns[index],

        notFollowedReturn:
            notFollowedReturns[index]
    }));


/*
 * 전체 거래 횟수가 많은 순으로 정렬하고
 * 상위 5개 원칙만 사용한다.
 */
const topRules =
    ruleData
        .sort(
            (a, b) =>
                b.tradeCount - a.tradeCount
        )
        .slice(0, 5);


/*
 * TOP5 차트 데이터 생성
 */
const ruleChartLabels =
    topRules.map(
   		(rule, index) => '원칙 #' + (index + 1)
    );

const topFollowedReturns =
    topRules.map(
        rule => rule.followedReturn
    );

const topNotFollowedReturns =
    topRules.map(
        rule => rule.notFollowedReturn
    );


/*
 * 막대 높이는 절댓값으로 표시하고
 * 실제 +/- 값은 툴팁에서 보여준다.
 */
const followedChartValues =
    topFollowedReturns.map(
        value => Math.abs(value)
    );

const notFollowedChartValues =
    topNotFollowedReturns.map(
        value => Math.abs(value)
    );


const ruleCtx =
    document.getElementById('rulePerformanceChart');

if (ruleCtx) {

    new Chart(ruleCtx, {

        type: 'bar',

        data: {

            labels: ruleChartLabels,

            datasets: [

                {
                    label: '준수',

                    data: followedChartValues,

                    backgroundColor:
                        'rgba(25, 135, 84, 0.7)',

                    borderRadius: 6,

                    maxBarThickness: 50
                },

                {
                    label: '위반',

                    data: notFollowedChartValues,

                    backgroundColor:
                        'rgba(220, 53, 69, 0.7)',

                    borderRadius: 6,

                    maxBarThickness: 50
                }
            ]
        },

        options: {

            responsive: true,

            maintainAspectRatio: false,

            scales: {

                y: {

                    beginAtZero: true,

                    ticks: {

                        callback: function(value) {
                            return value + '%';
                        }
                    }
                },

                x: {

                    grid: {
                        display: false
                    }
                }
            },

            plugins: {

            	tooltip: {

            	    callbacks: {

            	        title: function(context) {

            	            const index =
            	                context[0].dataIndex;

            	            return '원칙 #' + (index + 1);
            	        },

            	        beforeLabel: function(context) {

            	            const index =
            	                context.dataIndex;

            	            return topRules[index].label;
            	        },

            	        label: function(context) {

            	            const index =
            	                context.dataIndex;

            	            if (context.datasetIndex === 0) {

            	                const realReturn =
            	                    topFollowedReturns[index];

            	                return '준수 평균 수익률: '
            	                    + realReturn.toFixed(2)
            	                    + '%';
            	            }

            	            const realReturn =
            	                topNotFollowedReturns[index];

            	            return '위반 평균 수익률: '
            	                + realReturn.toFixed(2)
            	                + '%';
            	        }
            	    }
            	}
            }
        }
    });
}

</script>

</body>

</html>