package kr.co.aura.aurastay.dto;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

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
//    private String categoryName;

    private List<KeywordDTO> keywords;          // 키워드 리스트 (조회용)
    private Integer keywordNo;                  // insert 용 단일 카테고리

    private List<Integer> amenities;            // 편의시설 리스트 (조회용) : 여러 편의시설 저장
    private Integer amenitiesNo;                // insert 용 단일 카테고리
    private String amenitiesName;               // 편의시설 이름



    // 객실 정보를 위한 추가 필드
    private List<RoomDTO> rooms;                // 객실 리스트 추가

    // 객실 추가
    public void addRoom(RoomDTO roomDTO) {

        this.rooms.add(roomDTO);

//        if (rooms == null) {
//            rooms = new ArrayList<>();
//        }
//        rooms.add(roomDTO);
    }

    // 특정 객실을 번호(roomNo)로 삭제하는 메서드
    public void removeRoom(int roomNo) {
        if (rooms != null) {
            rooms.removeIf(room -> room.getRoomNo() == roomNo);
        }
    }

    // 특정 객실 정보 업데이트
    public void updateRoom(RoomDTO roomDTO) {
        if (rooms != null) {
            for (int i = 0; i < rooms.size(); i++) {
                if (rooms.get(i).getRoomNo() == roomDTO.getRoomNo()) {
                    rooms.set(i, roomDTO);  // 기존 데이터를 새로운 값으로 교체
                    return;  // 업데이트 후 바로 종료
                }
            }
        }
    }

}
