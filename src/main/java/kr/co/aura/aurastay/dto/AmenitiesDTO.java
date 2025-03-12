package kr.co.aura.aurastay.dto;

import lombok.*;

@Data
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AmenitiesDTO {
    
    private int amenitiesNo;        // 편의시설 번호
    private String amenitiesName;   // 편의시설 이름 (수영장, 골프장, 헬스장, 와인바, 카페 등)
}
