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
public class RuleComparisonDTO {

    private int ruleId;
    private String ruleContent;

    // 준수 거래
    private int followedTradeCount;
    private BigDecimal followedAverageReturnRate;
    private BigDecimal followedTotalProfit;

    // 미준수 거래
    private int notFollowedTradeCount;
    private BigDecimal notFollowedAverageReturnRate;
    private BigDecimal notFollowedTotalProfit;
}