package kr.or.tradelog.service;

import kr.or.tradelog.dto.MemberDTO;

public interface MemberService {
	//회원가입
	void register(MemberDTO dto);
	
	//아이디 중복 확인
	boolean isLoginDuplicate(String loginId);
	
	//로그인 처리
	MemberDTO login(MemberDTO dto);
	
	// 회원 탈퇴 비밀번호 확인
	boolean checkPassword(int memberId, String password);
	
	// 회원 탈퇴
	void withdraw(int memberId);
}
