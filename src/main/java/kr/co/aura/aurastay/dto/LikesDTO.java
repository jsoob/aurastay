package kr.co.aura.aurastay.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LikesDTO {
    private int likeNo; // 좋아요 번호
    private int accommodationNo; // 숙소 번호
    private int memberNo; // 사용자 번호
}
