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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.tradelog.dto.MemberDTO;
import kr.or.tradelog.dto.PageRequestDTO;
import kr.or.tradelog.dto.PageResponseDTO;
import kr.or.tradelog.dto.StockDTO;
import kr.or.tradelog.dto.TradeDTO;
import kr.or.tradelog.dto.TradeRuleCheckDTO;
import kr.or.tradelog.dto.TradeRuleDTO;
import kr.or.tradelog.dto.TradeSearchCondition;
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

	        addValidationErrors(bindingResult, model);
	        prepareRegisterForm(dto, loginMember.getMemberId(), model);

	        // 잘못된 데이터는 저장하지 않고 등록 화면으로 돌아감
	        return "trade/register";
	    }

	    // 3. 현재 로그인 회원 ID 설정
	    dto.setMemberId(loginMember.getMemberId());

	 // 거래 저장 + 매매 원칙 연결
	    try {

	        service.registerWithRules(dto, ruleIds, params);

	    } catch (IllegalArgumentException e) {

	        // Service에서 발생한 비즈니스 검증 오류
	        model.addAttribute("error", e.getMessage());
	        prepareRegisterForm(dto, loginMember.getMemberId(), model);

	        return "trade/register";
	    }

	    // 등록 완료 후 목록으로 이동
	    return "redirect:/trade/list";
	}
	
	// 매매일지 관리 페이지
	@GetMapping("/list")
	public String listForm(
	        @ModelAttribute TradeSearchCondition condition,
	        @RequestParam(value = "page", defaultValue = "1") int page,
	        HttpSession session,
	        Model model) {

	    MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");

	    int memberId = loginMember.getMemberId();

	    condition.normalize();

	    PageResponseDTO<TradeDTO> result = service.searchPage(
	            memberId,
	            condition,
	            new PageRequestDTO(page, 10)
	    );

	    model.addAttribute("list", result.getList());
	    model.addAttribute("keyword", condition.getKeyword());
	    model.addAttribute("startDate", condition.getStartDate());
	    model.addAttribute("endDate", condition.getEndDate());
	    model.addAttribute("sort", condition.getSort());
	    model.addAttribute("page", result.getPage());
	    model.addAttribute("totalPages", result.getTotalPages());
	    model.addAttribute("totalCount", result.getTotalCount());
	    model.addAttribute("startPage", result.getStartPage());
	    model.addAttribute("endPage", result.getEndPage());


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
	        @Valid TradeDTO dto,
	        BindingResult bindingResult,
	        @RequestParam(value = "ruleIds", required = false)
	        List<Integer> ruleIds,
	        @RequestParam Map<String, String> params,
	        HttpSession session,
	        Model model) {

	    MemberDTO loginMember =
	            (MemberDTO) session.getAttribute("loginMember");

	    dto.setMemberId(loginMember.getMemberId());

	    if (bindingResult.hasErrors()) {
	        addValidationErrors(bindingResult, model);
	        prepareModifyForm(dto, loginMember.getMemberId(), model);
	        return "trade/modify";
	    }

	    try {
	        service.modifyWithRules(
	                dto,
	                ruleIds,
	                params
	        );
	    } catch (IllegalArgumentException e) {
	        model.addAttribute("error", e.getMessage());
	        prepareModifyForm(dto, loginMember.getMemberId(), model);
	        return "trade/modify";
	    }

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

	private void prepareRegisterForm(
	        TradeDTO dto,
	        int memberId,
	        Model model) {

	    model.addAttribute("trade", dto);
	    model.addAttribute("rules", tradeRuleService.selectAll(memberId));
	}

	private void prepareModifyForm(
	        TradeDTO dto,
	        int memberId,
	        Model model) {

	    model.addAttribute("trade", dto);
	    model.addAttribute("rules", tradeRuleService.selectAll(memberId));
	    model.addAttribute("ruleCheckMap", new HashMap<Integer, String>());
	}

	private void addValidationErrors(
	        BindingResult bindingResult,
	        Model model) {

	    Map<String, String> errors = new HashMap<>();

	    bindingResult.getFieldErrors().forEach(error ->
	            errors.putIfAbsent(
	                    error.getField(),
	                    error.getDefaultMessage()
	            )
	    );

	    model.addAttribute("errors", errors);
	}
}
