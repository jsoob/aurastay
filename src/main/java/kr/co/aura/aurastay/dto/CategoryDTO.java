package kr.co.aura.aurastay.dto;

import lombok.*;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CategoryDTO {
    private Integer categoryNo;         // 카테고리 (숙소 종류)
    private String categoryName;
}
