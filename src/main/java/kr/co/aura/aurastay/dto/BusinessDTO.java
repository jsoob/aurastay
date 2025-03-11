package kr.co.aura.aurastay.dto;

import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BusinessDTO {
    private String businessNo; // 사업자번호 (PK)
    private String businessName; // 상호명
    private String representativeName; // 대표자명
    private String businessEmail; // 이메일
    private String businessPhoneNumber; // 연락처
    private String businessPassword; // 비밀번호
    private String businessAccount; // 계좌번호
    private LocalDateTime registrationDate; // 가입일자
    private LocalDateTime withdrawalDate; // 탈퇴일자
    private String authority; // 권한(BUSINESS, ADMIN)
}
