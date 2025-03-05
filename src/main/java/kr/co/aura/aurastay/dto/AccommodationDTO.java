package kr.co.aura.aurastay.dto;

import lombok.*;

@Data
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AccommodationDTO {

    private int acmNo;                  // 숙소 번호
    private String acmName;             // 숙소 이름
    private String acmAddress;          // 숙소 주소
    private String acmTel;            // 숙소 전화번호
    private String contents;            // 숙소 상세설명
    private String checkinTime;         // 체크인 시간
    private String checkoutTime;        // 체크아웃 시간

}
