package kr.or.tradelog.controller;

import java.math.BigDecimal;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.tradelog.dto.MemberDTO;
import kr.or.tradelog.dto.TradeDTO;
import kr.or.tradelog.service.TradeService;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/dashboard")
@RequiredArgsConstructor
public class DashboardController {
	
	private final TradeService service;
	
	@GetMapping
	public String dashboard(HttpSession session, Model model) {
		MemberDTO loginMember = (MemberDTO)session.getAttribute("loginMember");
		int memberId = loginMember.getMemberId();
		
		//최근 거래 내역
		List<TradeDTO> recentTrades = service.selectRecent(memberId);
		model.addAttribute("recentTrades", recentTrades);
		
		//총 거래 건수
		int totalCount = service.getTotalTradeCount(memberId);
		model.addAttribute("totalCount", totalCount);
		
		//총 손익
		BigDecimal totalProfit = service.getTotalProfit(memberId);
		model.addAttribute("totalProfit", totalProfit);
		
		//평균 수익률
		BigDecimal averageReturnRate = service.getAverageReturnRate(memberId);
		model.addAttribute("averageReturnRate", averageReturnRate);
		
		//매매원칙 준수율
		BigDecimal ruleComplianceRate = service.getRuleComplianceRate(memberId);
		model.addAttribute("ruleComplianceRate", ruleComplianceRate);
		
		//승률
		BigDecimal winRate = service.getWinRate(memberId);
		model.addAttribute("winRate", winRate);
		
		return "dashboard";
	}
	
	
	
	
}
