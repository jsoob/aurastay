package kr.co.aura.aurastay.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AcmDTO {
    private int acmNo;
    private String acmName;
    private String acmAddress;
    private String contents;
    private String checkinTime;
    private String checkoutTime;
    private String acmTel;
    private int keywordNo;
    private String keywordName;
    private int businessNo;
    private int categoryNo;
    private String categoryName;

    // 방
    private int roomNo;
    private String roomName;
    private int roomQty;
    private int roomPrice;
    private int roomDiscount;
    private String roomContents;
    private String roomViewtype;
    private int roomCapacity;
}
