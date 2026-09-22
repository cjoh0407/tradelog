package kr.or.tradelog.service;

import java.util.List;

import kr.or.tradelog.dto.TradeRuleCheckDTO;

public interface TradeRuleCheckService {
	
	void register(TradeRuleCheckDTO dto);
	
	List<TradeRuleCheckDTO> selectByTradeId(
	        int tradeId,
	        int memberId
	);
	
	void deleteByTradeId(int tradeId);
}
