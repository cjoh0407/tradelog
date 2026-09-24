package kr.or.tradelog.dto;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.Digits;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

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
    @Size(max = 100, message = "종목명은 100자 이하로 입력해주세요.")
    private String stockName;

    @NotBlank(message = "종목코드를 입력해주세요.")
    @Size(max = 20, message = "종목코드는 20자 이하로 입력해주세요.")
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
    @Digits(integer = 13, fraction = 2, message = "매수가는 정수 13자리, 소수 2자리까지 입력할 수 있습니다.")
    private BigDecimal buyPrice;

    @NotNull(message = "매도가를 입력해주세요.")
    @DecimalMin(
        value = "0.0",
        inclusive = false,
        message = "매도가는 0보다 커야 합니다."
    )
    @Digits(integer = 13, fraction = 2, message = "매도가는 정수 13자리, 소수 2자리까지 입력할 수 있습니다.")
    private BigDecimal sellPrice;

    @NotNull(message = "수량을 입력해주세요.")
    @DecimalMin(
        value = "0.0",
        inclusive = false,
        message = "수량은 0보다 커야 합니다."
    )
    @Digits(integer = 11, fraction = 4, message = "수량은 정수 11자리, 소수 4자리까지 입력할 수 있습니다.")
    private BigDecimal quantity;

    @Size(max = 1000, message = "매수 이유는 1000자 이하로 입력해주세요.")
    private String buyReason;
    @Size(max = 2000, message = "복기는 2000자 이하로 입력해주세요.")
    private String review;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // 화면/계산용
    private BigDecimal returnRate;
    private BigDecimal realizedProfit;

    private int totalRuleCount;
    private int followedRuleCount;
}
