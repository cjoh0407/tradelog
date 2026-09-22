package kr.or.tradelog.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TradeRuleCheckDTO {

    private int tradeId;
    private int ruleId;
    private String followed;
    private String ruleContent;
}
