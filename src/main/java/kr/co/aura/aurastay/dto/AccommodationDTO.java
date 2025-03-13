package kr.co.aura.aurastay.dto;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalTime;
import java.util.List;


@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AccommodationDTO {

    private int acmNo;                  // 숙소 번호
    private String acmName;             // 숙소 이름
    private String acmAddress;          // 숙소 주소
    private String acmTel;              // 숙소 전화번호
    private String contents;            // 숙소 상세설명
    //    private LocalTime checkinTime;        // 체크인 시간
//    private LocalTime checkoutTime;           // 체크아웃 시간
    private String checkinTime;                 // "HH:mm a" 형식 (예: "01:00 PM")
    private String checkoutTime;
    private Integer businessNo;            // 사업자번호

    // 파일 업로드 관련 필드
    private List<String> filenames;             // 여러 파일 이름
    private List<String> filepath;              // 여러 파일 경로
    private List<MultipartFile> files;          // 실제 MultipartFile 리스트

    private List<CategoryDTO> categories;       // 카테고리 리스트 (조회용)
    private Integer categoryNo;                 // insert 용 단일 카테고리

    private List<KeywordDTO> keywords;          // 키워드 리스트 (조회용)
    private Integer keywordNo;                  // insert 용 단일 카테고리
}
