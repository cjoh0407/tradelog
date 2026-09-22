package kr.or.tradelog.service;

import java.util.List;

import kr.or.tradelog.dto.RuleAnalysisDTO;
import kr.or.tradelog.dto.RuleComparisonDTO;
import kr.or.tradelog.dto.TradeRuleDTO;

public interface TradeRuleService {
	
	// 원칙 등록
	void register(TradeRuleDTO dto);
	
	// 원칙 목록들 조회
	List<TradeRuleDTO> selectAll(int memberId);
	
	// 원칙 상세보기
	TradeRuleDTO detail(int ruleId, int memberId);

	// 원칙 수정
	void modify(TradeRuleDTO dto);
	
	// 원칙 삭제
	void delete(int ruleId, int memberId);
	
	List<RuleAnalysisDTO> selectRuleAnalysis(int memberId);
	
	List<RuleComparisonDTO> selectRuleComparison(int memberId);
}
