package kr.co.aura.aurastay.dto;

import lombok.*;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RoomDTO {
    
    private int roomNo;                 // 객실정보에 따른 번호
    private String roomName;            // 객실 이름
    private int roomQty;                // 객실 수량
    private int roomPrice;              // 객실 가격
    private int roomDiscount;           // 객실 할인율
    private String roomContents;        // 객실 상세 설명
    private String roomViewType;        // 객실 뷰타입
    private int roomCapacity;           // 객실 인원수


    private int acmNo;                  // 숙소번호 (외래키로 추가)
}
