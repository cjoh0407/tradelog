package kr.or.tradelog.controller;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.tradelog.dto.MemberDTO;
import kr.or.tradelog.dto.StockDTO;
import kr.or.tradelog.dto.TradeDTO;
import kr.or.tradelog.dto.TradeRuleCheckDTO;
import kr.or.tradelog.dto.TradeRuleDTO;
import kr.or.tradelog.service.StockApiService;
import kr.or.tradelog.service.TradeRuleCheckService;
import kr.or.tradelog.service.TradeRuleService;
import kr.or.tradelog.service.TradeService;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/trade")
@RequiredArgsConstructor
public class TradeController {
	
	private final TradeService service;
	private final StockApiService stockApiService;
	private final TradeRuleService tradeRuleService;
	private final TradeRuleCheckService tradeRuleCheckService;
	
	// 등록 페이지 이동
	@GetMapping("/register")
	public String registerForm(
	        HttpSession session,
	        Model model) {

	    MemberDTO loginMember =
	            (MemberDTO) session.getAttribute("loginMember");

	    List<TradeRuleDTO> rules =
	            tradeRuleService.selectAll(loginMember.getMemberId());

	    model.addAttribute("rules", rules);

	    return "trade/register";
	}
	
	// 매매일지 등록
	@PostMapping("/register")
	public String register(
	        @Valid TradeDTO dto,
	        BindingResult bindingResult,
	        @RequestParam(value = "ruleIds", required = false) List<Integer> ruleIds,
	        @RequestParam Map<String, String> params,
	        HttpSession session,
	        Model model) {

	    // 1. 로그인 회원 정보
	    MemberDTO loginMember =
	            (MemberDTO) session.getAttribute("loginMember");

	    // 2. Bean Validation 서버 유효성 검증
	    if (bindingResult.hasErrors()) {

	        // 등록 화면에서 사용할 매매 원칙 다시 조회
	        List<TradeRuleDTO> rules =
	                tradeRuleService.selectAll(
	                        loginMember.getMemberId()
	                );

	        model.addAttribute("rules", rules);

	        // 잘못된 데이터는 저장하지 않고 등록 화면으로 돌아감
	        return "trade/register";
	    }

	    // 3. 현재 로그인 회원 ID 설정
	    dto.setMemberId(loginMember.getMemberId());

	 // 거래 저장
	    try {

	        service.register(dto);

	    } catch (IllegalArgumentException e) {

	        // Service에서 발생한 비즈니스 검증 오류
	        bindingResult.rejectValue(
	                "sellDate",
	                "invalid.sellDate",
	                e.getMessage()
	        );

	        // 등록 화면에서 사용할 매매 원칙 다시 조회
	        List<TradeRuleDTO> rules =
	                tradeRuleService.selectAll(
	                        loginMember.getMemberId()
	                );

	        model.addAttribute("rules", rules);

	        return "trade/register";
	    }

	    // 5. INSERT 후 생성된 거래 ID
	    int tradeId = dto.getTradeId();

	    // 6. 선택한 매매 원칙이 있다면 거래와 연결
	    if (ruleIds != null) {

	        for (Integer ruleId : ruleIds) {

	            // 현재 로그인 사용자의 원칙인지 확인
	            TradeRuleDTO rule =
	                    tradeRuleService.detail(
	                            ruleId,
	                            loginMember.getMemberId()
	                    );

	            // 다른 사용자의 원칙이면 무시
	            if (rule == null) {
	                continue;
	            }

	            String followed =
	                    params.get("followed_" + ruleId);

	            TradeRuleCheckDTO ruleCheck =
	                    TradeRuleCheckDTO.builder()
	                            .tradeId(tradeId)
	                            .ruleId(ruleId)
	                            .followed(followed)
	                            .build();

	            tradeRuleCheckService.register(ruleCheck);
	        }
	    }

	    // 7. 등록 완료 후 목록으로 이동
	    return "redirect:/trade/list";
	}
	
	// 매매일지 관리 페이지
	@GetMapping("/list")
	public String listForm(
	        @RequestParam(value = "keyword", required = false) String keyword,
	        @RequestParam(value = "startDate", required = false) String startDate,
	        @RequestParam(value = "endDate", required = false) String endDate,
	        @RequestParam(value = "sort", required = false) String sort,
	        @RequestParam(value = "page", defaultValue = "1") int page,
	        HttpSession session,
	        Model model) {

	    MemberDTO loginMember =
	            (MemberDTO) session.getAttribute("loginMember");

	    int memberId = loginMember.getMemberId();


	    // 검색 조건 정리
	    if (keyword != null) {
	        keyword = keyword.trim();
	    }

	    if (startDate != null) {
	        startDate = startDate.trim();
	        if (startDate.isEmpty()) {
	            startDate = null;
	        }
	    }

	    if (endDate != null) {
	        endDate = endDate.trim();
	        if (endDate.isEmpty()) {
	            endDate = null;
	        }
	    }


	    int pageSize = 10;

	    if (page < 1) {
	        page = 1;
	    }


	    int totalCount =
	            service.countTrades(
	                    memberId,
	                    keyword,
	                    startDate,
	                    endDate
	            );

	    int totalPages =
	            (int) Math.ceil((double) totalCount / pageSize);

	    int offset =
	            (page - 1) * pageSize;


	    // 페이지 번호 10개씩
	    int pageBlockSize = 10;

	    int startPage =
	            ((page - 1) / pageBlockSize) * pageBlockSize + 1;

	    int endPage =
	            Math.min(
	                    startPage + pageBlockSize - 1,
	                    totalPages
	            );


	    List<TradeDTO> list =
	            service.searchTrades(
	                    memberId,
	                    keyword,
	                    startDate,
	                    endDate,
	                    sort,
	                    offset,
	                    pageSize
	            );


	    model.addAttribute("list", list);

	    model.addAttribute("keyword", keyword);
	    model.addAttribute("startDate", startDate);
	    model.addAttribute("endDate", endDate);
	    model.addAttribute("sort", sort);

	    model.addAttribute("page", page);
	    model.addAttribute("totalPages", totalPages);
	    model.addAttribute("totalCount", totalCount);

	    model.addAttribute("startPage", startPage);
	    model.addAttribute("endPage", endPage);


	    return "trade/list";
	}
	
	// 매매일지 상세보기
	@GetMapping("/detail")
	public String detailForm(@RequestParam("tradeId") int tradeId, HttpSession session, Model model) {
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		
		int memberId = loginMember.getMemberId();
		
		TradeDTO trade = service.detail(tradeId, memberId);
		
		if (trade == null) {
		    return "redirect:/trade/list";
		}
		
		List<TradeRuleCheckDTO> ruleChecks =
		        tradeRuleCheckService.selectByTradeId(
		                tradeId,
		                memberId
		        );

		System.out.println("현재 거래 종목코드 = [" + trade.getStockCode() + "]");
		
		StockDTO stock =
		        stockApiService.getCurrentPrice(trade.getStockCode());
		
		model.addAttribute("ruleChecks", ruleChecks);
		model.addAttribute("trade", trade);
		
		// 외부 API 조회에 성공한 경우에만 처리
		if (stock != null) {

		    BigDecimal priceChangeRate =
		            service.calculatePriceChangeRate(
		                    trade.getSellPrice(),
		                    stock.getCurrentPrice()
		            );

		    model.addAttribute("stock", stock);
		    model.addAttribute("priceChangeRate", priceChangeRate);
		}
		
		return "trade/detail";
	}
	
	// 수정 페이지 이동
	@GetMapping("/modify")
	public String modifyForm(
	        @RequestParam("tradeId") int tradeId,
	        HttpSession session,
	        Model model) {

	    MemberDTO loginMember =
	            (MemberDTO) session.getAttribute("loginMember");

	    int memberId = loginMember.getMemberId();

	    TradeDTO trade =
	            service.detail(tradeId, memberId);

	    if (trade == null) {
	        return "redirect:/trade/list";
	    }
	    
	    List<TradeRuleDTO> rules =
	            tradeRuleService.selectAll(memberId);

	    List<TradeRuleCheckDTO> ruleChecks =
	            tradeRuleCheckService.selectByTradeId(
	                    tradeId,
	                    memberId
	            );


	    // 기존 원칙 선택 상태를 쉽게 확인하기 위한 Map
	    Map<Integer, String> ruleCheckMap = new HashMap<>();

	    for (TradeRuleCheckDTO ruleCheck : ruleChecks) {

	        ruleCheckMap.put(
	                ruleCheck.getRuleId(),
	                ruleCheck.getFollowed()
	        );
	    }


	    model.addAttribute("trade", trade);
	    model.addAttribute("rules", rules);
	    model.addAttribute("ruleCheckMap", ruleCheckMap);

	    return "trade/modify";
	}
	
	// 수정 완료 후 리스트로 이동
	@PostMapping("/modify")
	public String modify(
	        TradeDTO dto,
	        @RequestParam(value = "ruleIds", required = false)
	        List<Integer> ruleIds,
	        @RequestParam Map<String, String> params,
	        HttpSession session) {

	    MemberDTO loginMember =
	            (MemberDTO) session.getAttribute("loginMember");

	    dto.setMemberId(loginMember.getMemberId());

	    service.modifyWithRules(
	            dto,
	            ruleIds,
	            params
	    );

	    return "redirect:/trade/list";
	}
	
	// 삭제 후 리스트로 이동
	@PostMapping("/delete")
	public String delete(@RequestParam("tradeId") int tradeId, HttpSession session) {
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		int memberId = loginMember.getMemberId();
		service.delete(tradeId, memberId);
		return "redirect:/trade/list";
	}
}
