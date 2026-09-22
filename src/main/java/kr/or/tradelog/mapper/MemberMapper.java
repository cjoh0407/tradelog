package kr.or.tradelog.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.or.tradelog.dto.MemberDTO;

@Mapper
public interface MemberMapper {
	// 1. 내가 DB에서 하고 싶은 작업은 무엇인가..!
	// 2. 작업을 하려면 DB에 제공해야하는 데이터는 무엇인가..?
	// 3. 작업이 끝난 뒤 DB가 나에게 무엇을 돌려줘야 하는가..?
	// 4. 이 메서드 이름을 무엇으로 지을까..!
	
	// 회원 가입
	int insertMember(MemberDTO dto);
	
	// 회원 가입 시 아이디 중복 확인
	int checkLoginIdDuplicate(String loginId);
	
	// 회원 조회
	MemberDTO selectMemberByLoginId(String loginId);
	
    // 회원 번호로 회원 조회
    MemberDTO selectMemberByMemberId(int memberId);
    
    // 회원의 원칙 체크 데이터 삭제
    int deleteTradeRuleChecksByMemberId(int memberId);

    // 회원의 매매일지 삭제
    int deleteTradesByMemberId(int memberId);

    // 회원의 매매 원칙 삭제
    int deleteTradeRulesByMemberId(int memberId);

    // 회원 삭제
    int deleteMember(int memberId);
}
