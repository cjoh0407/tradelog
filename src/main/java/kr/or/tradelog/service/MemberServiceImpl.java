package kr.or.tradelog.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.tradelog.dto.MemberDTO;
import kr.or.tradelog.mapper.MemberMapper;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService{

	private final MemberMapper mapper;
	private final PasswordEncoder passwordEncoder;
	
	@Override
	public void register(MemberDTO dto) {
	    String encodedPassword =
	            passwordEncoder.encode(dto.getPassword());

	    dto.setPassword(encodedPassword);

	    mapper.insertMember(dto);
	}

	@Override
	public boolean isLoginDuplicate(String loginId) {
		int checkResult = mapper.checkLoginIdDuplicate(loginId);
		if (checkResult != 1) return false;
		return true;
	}

	@Override
	public MemberDTO login(MemberDTO dto) {

		// 아이디와 비밀번호가 비어있는지 확인.
		if(null == dto.getLoginId() || null == dto.getPassword()) return null;

		// DB에서 해당 아이디를 가진 회원의 존재 확인
		MemberDTO member = mapper.selectMemberByLoginId(dto.getLoginId());
		if(null == member) return null;
		
		// 입력 비밀번호와, DB에 비밀번호가 일치하는지 확인
		if (!passwordEncoder.matches(
		        dto.getPassword(),
		        member.getPassword())) {

		    return null;
		}
		
		return member;
		
	}

	@Override
	public boolean checkPassword(int memberId, String password) {

	    // 비밀번호 미입력
	    if (password == null || password.trim().isEmpty()) {
	        return false;
	    }

	    // 현재 로그인 회원 조회
	    MemberDTO member =
	            mapper.selectMemberByMemberId(memberId);

	    // 회원이 존재하지 않는 경우
	    if (member == null) {
	        return false;
	    }

	    // 입력한 비밀번호와 DB 비밀번호 비교
	    return passwordEncoder.matches(
	            password,
	            member.getPassword()
	    );
	}
	
	@Override
	@Transactional
	public void withdraw(int memberId) {

	    // 1. 거래별 원칙 체크 삭제
	    mapper.deleteTradeRuleChecksByMemberId(memberId);

	    // 2. 매매일지 삭제
	    mapper.deleteTradesByMemberId(memberId);

	    // 3. 매매 원칙 삭제
	    mapper.deleteTradeRulesByMemberId(memberId);

	    // 4. 회원 삭제
	    mapper.deleteMember(memberId);
	}
}
