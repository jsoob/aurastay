package kr.co.aura.aurastay.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AcmDTO {
    private int accommodationNo;
    private String accommodationName;
    private String accommodationAddress;
    private String accommodationContents;
    private String checkin;
    private String checkout;
    private String tel;
    private int keywordNo;
    private String keywordName;
    private int businessNo;
    private int categoryNo;
    private String categoryName;

    // 방
    private int roomNo;
//    private int accommodationNo;
    private String roomName;
    private int roomQty;
    private int roomPrice;
    private int roomDiscount;
    private String roomContents;
    private String roomViewtype;
    private int roomCapacity;
}
