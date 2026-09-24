package kr.or.tradelog.service;

import java.util.List;

import kr.or.tradelog.dto.TradeRuleCheckDTO;

public interface TradeRuleCheckService {
	
	List<TradeRuleCheckDTO> selectByTradeId(
	        int tradeId,
	        int memberId
	);
}
