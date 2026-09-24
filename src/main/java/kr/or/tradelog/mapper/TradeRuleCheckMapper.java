package kr.or.tradelog.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.tradelog.dto.TradeRuleCheckDTO;

@Mapper
public interface TradeRuleCheckMapper {
	
	// 원칙 준수 여부
	int insertRuleCheck(TradeRuleCheckDTO dto);

	List<TradeRuleCheckDTO> selectByTradeId(
	        @Param("tradeId") int tradeId,
	        @Param("memberId") int memberId
	);
	
	// 원칙 삭제
	int deleteByTradeId(int tradeId);

	// 본인 거래의 원칙 체크 삭제
	int deleteByTradeIdAndMemberId(
	        @Param("tradeId") int tradeId,
	        @Param("memberId") int memberId
	);
}
