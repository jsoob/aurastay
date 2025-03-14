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
    private int room_no;
    private int accommodation_no;
    private String room_name;
    private int room_qty;
    private int room_price;
    private int room_discount;
    private String room_contents;
    private String room_viewtype;
    private int room_capacity;
}
