package kr.or.tradelog.dto;

import java.time.LocalDateTime;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

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
	@NotBlank(message = "아이디를 입력해주세요.")
	@Size(min = 4, max = 50, message = "아이디는 4자 이상 입력해주세요.")
	private String loginId;
	@NotBlank(message = "비밀번호를 입력해주세요.")
	private String password;
	private LocalDateTime createAt;
}
