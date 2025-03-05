package kr.co.aura.aurastay.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MemberDTO {
    private Long memberNo; // 사용자 번호 sequence
    private String memberEmail; // 이메일
    private String memberPassword; // 비밀번호
    private String memberNickName; // 닉네임
    private String memberName; // 이름
    private String memberPhoneNumber; // 전화번호
    private int memberStatus; // 탈퇴 여부
    private int point;
}
