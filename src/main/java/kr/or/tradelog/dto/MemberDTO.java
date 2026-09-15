package kr.or.tradelog.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MemberDTO {
	private int memberId;
	private String loginId;
	private String password;
	private String nickname;
	private LocalDateTime createAt;
}
