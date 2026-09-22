package kr.or.tradelog.mapper;

import java.math.BigDecimal;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.tradelog.dto.MonthlyAnalysisDTO;
import kr.or.tradelog.dto.StockAnalysisDTO;
import kr.or.tradelog.dto.TradeDTO;

@Mapper
public interface TradeMapper {

    // 매매일지 등록
    int insertTrade(TradeDTO dto);

    // 매매일지 목록 조회
    List<TradeDTO> selectTradesByMemberId(int memberId);

    // 매매일지 상세 조회
    TradeDTO selectTradeByTradeId(
            @Param("tradeId") int tradeId,
            @Param("memberId") int memberId
    );

    // 매매일지 수정
    int modifyTrade(TradeDTO dto);

    // 매매일지 삭제
    int deleteTrade(
            @Param("tradeId") int tradeId,
            @Param("memberId") int memberId
    );


    // ==========================================
    // 대시보드 / 전체 매매 성과
    // ==========================================

    // 최근 매매 조회
    List<TradeDTO> selectRecentTradesByMemberId(int memberId);

    // 총 매매건수
    int selectCount(int memberId);

    // 총 실현손익
    BigDecimal selectTotalProfit(int memberId);

    // 평균 수익률
    BigDecimal selectAverageReturnRate(int memberId);

    // 매매 원칙 준수율
    BigDecimal selectRuleComplianceRate(int memberId);

    // 승률
    BigDecimal selectWinRate(int memberId);


    // ==========================================
    // 종목별 성과 분석
    // ==========================================

    List<StockAnalysisDTO> selectStockAnalysis(int memberId);


    // ==========================================
    // 월별 성과 분석
    // ==========================================

    List<MonthlyAnalysisDTO> selectMonthlyAnalysis(int memberId);

    // 검색 + 정렬 + 페이징
    List<TradeDTO> searchTrades(
            @Param("memberId") int memberId,
            @Param("keyword") String keyword,
            @Param("startDate") String startDate,
            @Param("endDate") String endDate,
            @Param("sort") String sort,
            @Param("offset") int offset,
            @Param("pageSize") int pageSize
    );

    // 검색 조건에 해당하는 전체 거래 수
    int countTrades(
            @Param("memberId") int memberId,
            @Param("keyword") String keyword,
            @Param("startDate") String startDate,
            @Param("endDate") String endDate
    );
}