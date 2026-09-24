package kr.or.tradelog.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import kr.or.tradelog.dto.MonthlyAnalysisDTO;
import kr.or.tradelog.dto.StockAnalysisDTO;
import kr.or.tradelog.dto.TradeDTO;
import kr.or.tradelog.dto.PageRequestDTO;
import kr.or.tradelog.dto.PageResponseDTO;
import kr.or.tradelog.dto.TradeSearchCondition;

public interface TradeService {

    // 거래 등록 + 매매 원칙 연결
    void registerWithRules(
            TradeDTO dto,
            List<Integer> ruleIds,
            Map<String, String> params
    );

    // 상세 조회
    TradeDTO detail(int tradeId, int memberId);

    // 매도 이후 가격 변화율 계산
    BigDecimal calculatePriceChangeRate(
            BigDecimal sellPrice,
            int currentPrice
    );

    // 삭제
    void delete(int tradeId, int memberId);

    // 대시보드용 최근 5건 목록 조회
    List<TradeDTO> selectRecent(int memberId);

    // 대시보드 총 매매건수 조회
    int getTotalTradeCount(int memberId);

    // 대시보드 총 손익 조회
    BigDecimal getTotalProfit(int memberId);

    // 대시보드 평균 수익률 조회
    BigDecimal getAverageReturnRate(int memberId);

    // 대시보드 매매 원칙 준수율 조회
    BigDecimal getRuleComplianceRate(int memberId);

    // 대시보드 승률 조회
    BigDecimal getWinRate(int memberId);

    // 거래 수정 + 매매 원칙 수정
    void modifyWithRules(
            TradeDTO dto,
            List<Integer> ruleIds,
            Map<String, String> params
    );

    // 종목별 성과 분석
    List<StockAnalysisDTO> getStockAnalysis(int memberId);

    // 월별 성과 분석
    List<MonthlyAnalysisDTO> getMonthlyAnalysis(int memberId);
    
    PageResponseDTO<TradeDTO> searchPage(
            int memberId,
            TradeSearchCondition condition,
            PageRequestDTO pageRequest
    );

}
