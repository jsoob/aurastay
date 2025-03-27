package kr.co.aura.aurastay.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MemberAccommodationDTO {

    // 사용자 페이지 기준

    private int memberAcmNo;                    // 숙소 번호 (숙소번호를 기준으로 불러와서 숙소의 상세페이지를 제공)
    private String memberAcmName;               // 숙소명
    private String memberAcmAddress;            // 주소
    private String memberAcmContents;           // 상세설명
    private String memberAcmCheckin;            // 체크인 시간
    private String memberAcmCheckout;           // 체크아웃 시간
    private String memberAcmTel;                // 전화번호

    private int businessAcmNo;                  // 사업자번호
    private int businessKeywordNo;              // 사업자 키워드 번호
    private int businessCategoryNo;             // 사업자 카테고리 번호
    private int businessAmenities;              // 사업자 편의시설 번호

}
