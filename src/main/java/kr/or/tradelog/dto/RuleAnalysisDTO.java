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
public class RuleAnalysisDTO {

    private int ruleId;
    private String ruleContent;

    // 원칙을 적용한 거래 수
    private int tradeCount;

    // 준수 횟수
    private int followedCount;

    // 미준수 횟수
    private int notFollowedCount;

    // 준수율
    private BigDecimal complianceRate;

    // 해당 원칙이 적용된 거래들의 평균 수익률
    private BigDecimal averageReturnRate;

    // 해당 원칙이 적용된 거래들의 총 실현손익
    private BigDecimal totalProfit;
}