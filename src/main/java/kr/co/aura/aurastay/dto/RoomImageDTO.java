package kr.co.aura.aurastay.dto;

import lombok.*;

@Data
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RoomImageDTO {

    private int imageNo;            // 이미지번호
    private String filename;        // 파일 이름
    private String filepath;        // 파일 경로
    
}
