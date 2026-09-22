package kr.or.tradelog.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.tradelog.dto.MonthlyAnalysisDTO;
import kr.or.tradelog.dto.StockAnalysisDTO;
import kr.or.tradelog.dto.TradeDTO;
import kr.or.tradelog.dto.TradeRuleCheckDTO;
import kr.or.tradelog.mapper.TradeMapper;
import kr.or.tradelog.mapper.TradeRuleCheckMapper;
import kr.or.tradelog.mapper.TradeRuleMapper;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TradeServiceImpl implements TradeService {

    private final TradeMapper mapper;
    private final TradeRuleCheckMapper tradeRuleCheckMapper;
    private final TradeRuleMapper tradeRuleMapper;


    // ==========================================
    // 거래 등록
    // ==========================================

    @Override
    public void register(TradeDTO dto) {

        // 매도일은 매수일보다 빠를 수 없음
        if (dto.getBuyDate() != null
                && dto.getSellDate() != null
                && dto.getSellDate().isBefore(dto.getBuyDate())) {

            throw new IllegalArgumentException(
                    "매도일은 매수일보다 빠를 수 없습니다."
            );
        }

        mapper.insertTrade(dto);
    }


    // ==========================================
    // 거래 목록 조회
    // ==========================================

    @Override
    public List<TradeDTO> selectAll(int memberId) {

        List<TradeDTO> list =
                mapper.selectTradesByMemberId(memberId);

        for (TradeDTO trade : list) {
            calculateTradeResult(trade);
        }

        return list;
    }


    // ==========================================
    // 거래 상세 조회
    // ==========================================

    @Override
    public TradeDTO detail(int tradeId, int memberId) {

        TradeDTO trade =
                mapper.selectTradeByTradeId(
                        tradeId,
                        memberId
                );

        if (trade == null) {
            return null;
        }
        
        calculateTradeResult(trade);

        return trade;
    }


    // ==========================================
    // 매도 이후 가격 변화율 계산
    // ==========================================

    @Override
    public BigDecimal calculatePriceChangeRate(
            BigDecimal sellPrice,
            int currentPrice) {

        // 현재가를 BigDecimal로 변환
        BigDecimal currentPriceDecimal =
                BigDecimal.valueOf(currentPrice);

        // 현재가 - 매도가
        BigDecimal result =
                currentPriceDecimal.subtract(sellPrice);

        // (현재가 - 매도가) / 매도가
        result = result.divide(
                sellPrice,
                4,
                RoundingMode.HALF_UP
        );

        // 백분율 변환
        result =
                result.multiply(BigDecimal.valueOf(100));

        return result;
    }


    // ==========================================
    // 거래 수정
    // ==========================================

    @Override
    public void modify(TradeDTO dto) {
        mapper.modifyTrade(dto);
    }


    // ==========================================
    // 거래 삭제
    // ==========================================

    @Override
    public void delete(int tradeId, int memberId) {
        mapper.deleteTrade(tradeId, memberId);
    }


    // ==========================================
    // 최근 거래 조회
    // ==========================================

    @Override
    public List<TradeDTO> selectRecent(int memberId) {

        List<TradeDTO> list =
                mapper.selectRecentTradesByMemberId(memberId);

        for (TradeDTO trade : list) {
            calculateTradeResult(trade);
        }

        return list;
    }


    // ==========================================
    // 전체 매매 성과
    // ==========================================

    @Override
    public int getTotalTradeCount(int memberId) {
        return mapper.selectCount(memberId);
    }

    @Override
    public BigDecimal getTotalProfit(int memberId) {
        return mapper.selectTotalProfit(memberId);
    }

    @Override
    public BigDecimal getAverageReturnRate(int memberId) {
        return mapper.selectAverageReturnRate(memberId);
    }

    @Override
    public BigDecimal getWinRate(int memberId) {
        return mapper.selectWinRate(memberId);
    }


    // ==========================================
    // 매매 원칙 준수율
    // ==========================================

    @Override
    public BigDecimal getRuleComplianceRate(int memberId) {
        return mapper.selectRuleComplianceRate(memberId);
    }


    // ==========================================
    // 거래 결과 계산
    // ==========================================

    private void calculateTradeResult(TradeDTO trade) {

        // 실현손익
        BigDecimal realizedProfit =
                trade.getSellPrice()
                        .subtract(trade.getBuyPrice())
                        .multiply(trade.getQuantity());

        trade.setRealizedProfit(realizedProfit);


        // 수익률
        BigDecimal returnRate =
                trade.getSellPrice()
                        .subtract(trade.getBuyPrice())
                        .divide(
                                trade.getBuyPrice(),
                                4,
                                RoundingMode.HALF_UP
                        )
                        .multiply(BigDecimal.valueOf(100));

        trade.setReturnRate(returnRate);
    }


    // ==========================================
    // 거래 수정 + 매매 원칙 수정
    // ==========================================

    @Override
    @Transactional
    public void modifyWithRules(
            TradeDTO dto,
            List<Integer> ruleIds,
            Map<String, String> params) {

        // 1. 본인 거래만 수정
        int updated = mapper.modifyTrade(dto);

        // 존재하지 않거나 다른 회원의 거래
        if (updated == 0) {
            return;
        }

        // 2. 본인 거래임이 확인된 후 기존 원칙 연결 삭제
        tradeRuleCheckMapper.deleteByTradeId(
                dto.getTradeId()
        );

        // 3. 원칙 다시 저장
        if (ruleIds != null) {

            for (Integer ruleId : ruleIds) {

                int owned =
                        tradeRuleMapper.countOwnedRule(
                                ruleId,
                                dto.getMemberId()
                        );

                if (owned == 0) {
                    continue;
                }

                String followed =
                        params.get("followed_" + ruleId);

                TradeRuleCheckDTO ruleCheck =
                        TradeRuleCheckDTO.builder()
                                .tradeId(dto.getTradeId())
                                .ruleId(ruleId)
                                .followed(followed)
                                .build();

                tradeRuleCheckMapper.insertRuleCheck(ruleCheck);
            }
        }
    }


    // ==========================================
    // 종목별 성과 분석
    // ==========================================

    @Override
    public List<StockAnalysisDTO> getStockAnalysis(
            int memberId) {

        return mapper.selectStockAnalysis(memberId);
    }


    // ==========================================
    // 월별 성과 분석
    // ==========================================

    @Override
    public List<MonthlyAnalysisDTO> getMonthlyAnalysis(
            int memberId) {

        return mapper.selectMonthlyAnalysis(memberId);
    }
    
    @Override
    public List<TradeDTO> searchTrades(
            int memberId,
            String keyword,
            String startDate,
            String endDate,
            String sort,
            int offset,
            int pageSize) {

        List<TradeDTO> list =
                mapper.searchTrades(
                        memberId,
                        keyword,
                        startDate,
                        endDate,
                        sort,
                        offset,
                        pageSize
                );

        for (TradeDTO trade : list) {
            calculateTradeResult(trade);
        }

        return list;
    }

    @Override
    public int countTrades(
            int memberId,
            String keyword,
            String startDate,
            String endDate) {

        return mapper.countTrades(
                memberId,
                keyword,
                startDate,
                endDate
        );
    }
}