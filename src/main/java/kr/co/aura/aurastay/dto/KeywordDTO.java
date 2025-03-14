package kr.co.aura.aurastay.dto;

import lombok.*;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class KeywordDTO {

    private Integer keywordNo;          // 키워드 (지역명)
    private String keywordName;

}
