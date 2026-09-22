package kr.or.tradelog.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
	    // 현재 요청의 Session 객체 가져오기
		HttpSession session = request.getSession();
		
		// Session에 로그인한 회원 정보가 존재하는지 확인
		if(null == session.getAttribute("loginMember")) {

			// 로그인하지 않은 경우 로그인 페이지로 이동
			response.sendRedirect(request.getContextPath() + "/member/login");
			
			//요청 처리를 중단하여 Controller가 실행되지 않도록 함
			return false;
		}else {
			//로그인한 경우 요청을 계속 진행하여 Controller 실행
			return true;
		}
	}

}
