package kr.or.tradelog.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.tradelog.dto.RuleAnalysisDTO;
import kr.or.tradelog.dto.RuleComparisonDTO;
import kr.or.tradelog.dto.TradeRuleDTO;

@Mapper
public interface TradeRuleMapper {

	//추가
    int insertRule(TradeRuleDTO dto);
    
    //목록 조회
    List<TradeRuleDTO> selectAll(@Param("memberId") int memberId);
    
    //상세보기
    TradeRuleDTO selectOne(
            @Param("ruleId") int ruleId,
            @Param("memberId") int memberId);

    //수정
    int updateRule(TradeRuleDTO dto);
    
    // 해당 원칙이 적용된 거래 연결 데이터 삭제
    int deleteRuleChecks(
            @Param("ruleId") int ruleId,
            @Param("memberId") int memberId);

    // 원칙 삭제
    int deleteRule(
            @Param("ruleId") int ruleId,
            @Param("memberId") int memberId);
    
    List<RuleAnalysisDTO> selectRuleAnalysis(int memberId);
    
    List<RuleComparisonDTO> selectRuleComparison(int memberId);
    
    int countOwnedRule(
            @Param("ruleId") int ruleId,
            @Param("memberId") int memberId
    );
}