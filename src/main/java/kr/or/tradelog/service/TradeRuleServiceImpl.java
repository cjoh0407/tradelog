package kr.or.tradelog.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.tradelog.dto.RuleAnalysisDTO;
import kr.or.tradelog.dto.RuleComparisonDTO;
import kr.or.tradelog.dto.TradeRuleDTO;
import kr.or.tradelog.mapper.TradeRuleMapper;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TradeRuleServiceImpl implements TradeRuleService{
	
	private final TradeRuleMapper mapper;

	// 등록
	@Override
	public void register(TradeRuleDTO dto) {
		mapper.insertRule(dto);
	}
	
	//목록 조회
	@Override
	public List<TradeRuleDTO> selectAll(int memberId) {
		List<TradeRuleDTO> selectAll = mapper.selectAll(memberId);
		return selectAll;
	}

	//상세보기
	@Override
	public TradeRuleDTO detail(int ruleId, int memberId) {
		TradeRuleDTO selectOne = mapper.selectOne(ruleId, memberId);
		return selectOne;
	}

	//수정
	@Override
	public void modify(TradeRuleDTO dto) {
		mapper.updateRule(dto);
	}
	
	//삭제
	@Override
	@Transactional
	public void delete(int ruleId, int memberId) {

	    // 1. 거래와 원칙의 연결 데이터 삭제
	    mapper.deleteRuleChecks(ruleId, memberId);

	    // 2. 원칙 삭제
	    mapper.deleteRule(ruleId, memberId);
	}
	
	@Override
	public List<RuleAnalysisDTO> selectRuleAnalysis(int memberId) {
	    return mapper.selectRuleAnalysis(memberId);
	}
	
	@Override
	public List<RuleComparisonDTO> selectRuleComparison(int memberId) {
	    return mapper.selectRuleComparison(memberId);
	}
}
