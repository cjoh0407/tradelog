package kr.or.tradelog.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import kr.or.tradelog.dto.MonthlyAnalysisDTO;
import kr.or.tradelog.dto.StockAnalysisDTO;
import kr.or.tradelog.dto.TradeDTO;

public interface TradeService {

    // 등록
    void register(TradeDTO dto);

    // 목록 조회
    List<TradeDTO> selectAll(int memberId);

    // 상세 조회
    TradeDTO detail(int tradeId, int memberId);

    // 수정
    void modify(TradeDTO dto);

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
    
    List<TradeDTO> searchTrades(
            int memberId,
            String keyword,
            String startDate,
            String endDate,
            String sort,
            int offset,
            int pageSize
    );

    int countTrades(
            int memberId,
            String keyword,
            String startDate,
            String endDate
    );
}