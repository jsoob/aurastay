package kr.co.aura.aurastay.dto;

import lombok.*;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MemberRoomDTO {

    private int memberRoomNo;               // 객실 번호 (pk)
    private String memberRoomName;          // 객실명
    private int memberRoomQty;              // 객실 수량
    private int memberRoomPrice;            // 객실 가격
    private int memberRoomDiscount;         // 할인율
    private String memberRoomContents;      // 객실 상세내용
    private String memberRoomViewType;      // 뷰 타입
    private int memberRoomCapacity;         // 인원수

    private int businessAcmNo;              // 숙소 번호 (fk)

}
