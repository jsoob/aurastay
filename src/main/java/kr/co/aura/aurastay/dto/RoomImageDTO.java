package kr.co.aura.aurastay.dto;

import lombok.*;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RoomImageDTO {

    private int imageNo;            // 이미지번호
    private String filename;        // 파일 이름
    private String filepath;        // 파일 경로
    private int acmNo;             // 숙소 번호 (숙소번호와 연결 : 어떤 숙소에 포함이 되는지를 확인하기 위한 용도)
}
