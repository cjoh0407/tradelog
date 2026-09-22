package kr.or.tradelog.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TradeRuleDTO {
    private int ruleId;
    private int memberId;
    private String ruleContent;
    private LocalDateTime createdAt;
}
