package kr.or.tradelog.dto;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TradeDTO {

    private int tradeId;
    private int memberId;

    @NotBlank(message = "종목명을 입력해주세요.")
    private String stockName;

    @NotBlank(message = "종목코드를 입력해주세요.")
    private String stockCode;

    @NotNull(message = "매수일을 입력해주세요.")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate buyDate;

    @NotNull(message = "매도일을 입력해주세요.")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate sellDate;

    @NotNull(message = "매수가를 입력해주세요.")
    @DecimalMin(
        value = "0.0",
        inclusive = false,
        message = "매수가는 0보다 커야 합니다."
    )
    private BigDecimal buyPrice;

    @NotNull(message = "매도가를 입력해주세요.")
    @DecimalMin(
        value = "0.0",
        inclusive = false,
        message = "매도가는 0보다 커야 합니다."
    )
    private BigDecimal sellPrice;

    @NotNull(message = "수량을 입력해주세요.")
    @DecimalMin(
        value = "0.0",
        inclusive = false,
        message = "수량은 0보다 커야 합니다."
    )
    private BigDecimal quantity;

    private String buyReason;
    private String review;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // 화면/계산용
    private BigDecimal returnRate;
    private BigDecimal realizedProfit;

    private int totalRuleCount;
    private int followedRuleCount;
}