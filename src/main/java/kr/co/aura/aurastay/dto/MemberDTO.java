package kr.co.aura.aurastay.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MemberDTO {
    private int memberNo; // 사용자 번호(PK) auto_increment
    @NotBlank(message = "이메일은 필수 입력 항목입니다.")
    private String memberEmail; // 이메일
    private String providerId; // 소셜로그인ID
    @NotBlank(message = "비밀번호는 필수 입력 항목입니다.")
    private String memberPassword; // 비밀번호
    private String memberName; // 이름
    private String memberNickname; // 닉네임
    private String memberPhoneNumber; // 전화번호
    private int point; // 포인트
    private LocalDateTime registrationDate; // 가입일자
    private LocalDateTime withdrawalDate; // 탈퇴일자
    private String authority; // 권한
}

