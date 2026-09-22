package kr.or.tradelog.dto;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class StockAnalysisDTO {

    private String stockName;
    private String stockCode;

    // 거래 횟수
    private int tradeCount;

    // 승률
    private BigDecimal winRate;

    // 평균 수익률
    private BigDecimal averageReturnRate;

    // 총 실현손익
    private BigDecimal totalProfit;
}