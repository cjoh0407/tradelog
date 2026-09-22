package kr.or.tradelog.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.tradelog.dto.TradeRuleCheckDTO;
import kr.or.tradelog.mapper.TradeRuleCheckMapper;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TradeRuleCheckServiceImpl implements TradeRuleCheckService{
	
	private final TradeRuleCheckMapper mapper;
	
	public void register(TradeRuleCheckDTO dto) {
		mapper.insertRuleCheck(dto);
	};
	
	@Override
	public List<TradeRuleCheckDTO> selectByTradeId(
	        int tradeId,
	        int memberId) {

	    return mapper.selectByTradeId(
	            tradeId,
	            memberId
	    );
	}
	
	@Override
	public void deleteByTradeId(int tradeId) {
	    mapper.deleteByTradeId(tradeId);
	}
}
