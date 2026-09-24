package kr.or.tradelog.dto;

import java.time.LocalDateTime;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

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
    @NotBlank(message = "매매 원칙을 입력해주세요.")
    @Size(max = 500, message = "매매 원칙은 500자 이하로 입력해주세요.")
    private String ruleContent;
    private LocalDateTime createdAt;
}
