package kr.or.tradelog.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.tradelog.dto.MemberDTO;
import kr.or.tradelog.service.MemberService;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/member")
public class MemberController {

	private final MemberService service;
	
	@GetMapping("/register")
	public String registerForm() {
		return "member/join";
	}
	
	@PostMapping("/register")
	public String register(MemberDTO dto, Model model) {
		
		//아이디 중복 검증
		boolean loginDuplicate = service.isLoginDuplicate(dto.getLoginId());
		if(true == loginDuplicate) {
			model.addAttribute("error", "이미 사용 중인 아이디입니다.");
			return "member/join";
		}
		service.register(dto);
		
		return "redirect:/";
	}
	
	@GetMapping("/login")
	public String loginForm() {
		return "member/login";
	}
	
	@PostMapping("/login")
	public String login(MemberDTO dto, Model model, HttpSession session) {
		
		MemberDTO member = service.login(dto);
		
		if(null == member) {
			model.addAttribute("error", "로그인 정보를 다시 확인해주세요");
			return "member/login";
		}
		
		session.setAttribute("loginMember", member);
		
		return "redirect:/dashboard";
	}
	
	@PostMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/member/login";
	}
	
	@GetMapping("/withdraw")
	public String withdrawForm() {
	    return "member/withdraw";
	}
	
	@PostMapping("/withdraw")
	public String withdraw(
	        String password,
	        HttpSession session,
	        Model model) {

	    MemberDTO loginMember =
	            (MemberDTO) session.getAttribute("loginMember");
	    
	    int memberId = loginMember.getMemberId();

	    boolean passwordMatch =
	            service.checkPassword(
	                    loginMember.getMemberId(),
	                    password
	            );

	    if (!passwordMatch) {
	        model.addAttribute(
	                "error",
	                "비밀번호가 일치하지 않습니다."
	        );

	        return "member/withdraw";
	    }
	    
	    // 회원 및 관련 데이터 삭제
	    service.withdraw(memberId);

	    // 로그인 세션 종료
	    session.invalidate();

	    return "redirect:/dashboard";
	}
}
