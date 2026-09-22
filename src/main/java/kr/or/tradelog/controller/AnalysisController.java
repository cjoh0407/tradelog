package kr.or.tradelog.controller;

import java.math.BigDecimal;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.tradelog.dto.MemberDTO;
import kr.or.tradelog.dto.MonthlyAnalysisDTO;
import kr.or.tradelog.dto.RuleAnalysisDTO;
import kr.or.tradelog.dto.RuleComparisonDTO;
import kr.or.tradelog.dto.StockAnalysisDTO;
import kr.or.tradelog.service.TradeRuleService;
import kr.or.tradelog.service.TradeService;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/analysis")
public class AnalysisController {

    private final TradeService service;
    private final TradeRuleService tradeRuleService;

    @GetMapping
    public String analysis(HttpSession session, Model model) {

        // 로그인 회원
        MemberDTO loginMember =
                (MemberDTO) session.getAttribute("loginMember");

        int memberId = loginMember.getMemberId();


        // ==========================================
        // 전체 매매 성과
        // ==========================================

        // 총 거래 수
        int totalCount =
                service.getTotalTradeCount(memberId);

        // 승률
        BigDecimal winRate =
                service.getWinRate(memberId);

        // 총 실현손익
        BigDecimal totalProfit =
                service.getTotalProfit(memberId);

        // 평균 수익률
        BigDecimal averageReturnRate =
                service.getAverageReturnRate(memberId);


        // ==========================================
        // 월별 성과
        // REQ-027 월별 손익 차트에서 사용
        // ==========================================

        List<MonthlyAnalysisDTO> monthlyAnalysisList =
                service.getMonthlyAnalysis(memberId);


        // ==========================================
        // 종목별 성과
        // 종목별 성과 표 + REQ-028 TOP10 차트
        // ==========================================

        List<StockAnalysisDTO> stockAnalysisList =
                service.getStockAnalysis(memberId);


        // ==========================================
        // 원칙별 성과
        // ==========================================

        // 원칙별 성과 표
        List<RuleAnalysisDTO> ruleAnalysisList =
                tradeRuleService.selectRuleAnalysis(memberId);

        // REQ-029 준수 / 위반 성과 차트
        List<RuleComparisonDTO> ruleComparisonList =
                tradeRuleService.selectRuleComparison(memberId);


        // ==========================================
        // View 데이터 전달
        // ==========================================

        // 전체 매매 성과
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("winRate", winRate);
        model.addAttribute("totalProfit", totalProfit);
        model.addAttribute(
                "averageReturnRate",
                averageReturnRate
        );

        // 월별
        model.addAttribute(
                "monthlyAnalysisList",
                monthlyAnalysisList
        );

        // 종목별
        model.addAttribute(
                "stockAnalysisList",
                stockAnalysisList
        );

        // 원칙별
        model.addAttribute(
                "ruleAnalysisList",
                ruleAnalysisList
        );

        model.addAttribute(
                "ruleComparisonList",
                ruleComparisonList
        );


        return "analysis/analysis";
    }
}