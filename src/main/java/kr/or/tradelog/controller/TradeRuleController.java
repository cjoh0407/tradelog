package kr.or.tradelog.controller;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.tradelog.dto.MemberDTO;
import kr.or.tradelog.dto.TradeRuleDTO;
import kr.or.tradelog.service.TradeRuleService;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/rules")
public class TradeRuleController {

	private final TradeRuleService service;
	
    // 매매 원칙 등록 화면
    @GetMapping("/register")
    public String registerForm() {
        return "rules/register";
    }
    
    // 매매 원칙 등록 처리
    @PostMapping("/register")
    public String register(
            @Valid TradeRuleDTO dto,
            BindingResult bindingResult,
            HttpSession session,
            Model model) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("rule", dto);
            model.addAttribute(
                    "error",
                    bindingResult.getFieldErrors().get(0).getDefaultMessage()
            );
            return "rules/register";
        }

        MemberDTO loginMember =
                (MemberDTO) session.getAttribute("loginMember");
        
        dto.setMemberId(loginMember.getMemberId());

        service.register(dto);

        return "redirect:/rules";
    }
    
    // 매매 원칙 목록 조회
    @GetMapping
    public String list(
            HttpSession session,
            Model model) {

        MemberDTO loginMember =
                (MemberDTO) session.getAttribute("loginMember");

        int memberId = loginMember.getMemberId();

        List<TradeRuleDTO> rules =
                service.selectAll(memberId);

        model.addAttribute("rules", rules);

        return "rules/list";
    }
    
    //수정페이지로 이동
    @GetMapping("/modify")
    public String modifyForm(
            int ruleId,
            HttpSession session,
            Model model) {

        MemberDTO loginMember =
                (MemberDTO) session.getAttribute("loginMember");

        TradeRuleDTO rule =
                service.detail(
                        ruleId,
                        loginMember.getMemberId());
        
        if (rule == null) {
            return "redirect:/rules";
        }

        model.addAttribute("rule", rule);

        return "rules/modify";
    }

    //수정
    @PostMapping("/modify")
    public String modify(
            @Valid TradeRuleDTO dto,
            BindingResult bindingResult,
            HttpSession session,
            Model model) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("rule", dto);
            model.addAttribute(
                    "error",
                    bindingResult.getFieldErrors().get(0).getDefaultMessage()
            );
            return "rules/modify";
        }

        MemberDTO loginMember =
                (MemberDTO) session.getAttribute("loginMember");

        dto.setMemberId(loginMember.getMemberId());

        service.modify(dto);

        return "redirect:/rules";
    }
	
    //삭제
    @PostMapping("/delete")
    public String delete(
            int ruleId,
            HttpSession session) {

        MemberDTO loginMember =
                (MemberDTO) session.getAttribute("loginMember");

        service.delete(
                ruleId,
                loginMember.getMemberId());

        return "redirect:/rules";
    }
}
