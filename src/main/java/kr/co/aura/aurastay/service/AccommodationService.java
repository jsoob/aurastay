package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.AccommodationDTO;

import kr.co.aura.aurastay.dto.AmenitiesDTO;
import kr.co.aura.aurastay.dto.RoomDTO;
import kr.co.aura.aurastay.dto.RoomImageDTO;
import kr.co.aura.aurastay.repository.AccommodationRepository;
import kr.co.aura.aurastay.repository.RoomImageRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Service
public class AccommodationService {

    private final AccommodationRepository accommodationRepository;
    private final RoomService roomService;          // roomService와 연동
    private final RoomImageRepository roomImageRepository;

    // 전체 조회하기
    public List<AccommodationDTO> selectAll() {
        return accommodationRepository.selectAll();
    }

    // 숙소 정보 등록(추가)하기
    public void add(AccommodationDTO dto) {
        log.info("숙소 추가가 되고 있나용? >>>>>>>>>>> {}", dto);
        System.out.println("에러인가용?");

        // 만약 dto의 키워드가 null이라면? (입력이 되지 않았다면?)
        // keywordNo가 null이라면 객실정보를 저장하지 않음
        if (dto.getKeywordNo() == null) {
            // keywordNo 값이 없으면 오류를 발생시키거나, 기본값을 설정
            throw new IllegalArgumentException("키워드를 선택해주세요.");     // 예외 발생
        }

        dto.setBusinessNo(1211565655);     // 수정해야하는 데이터, 사업자번호 (추후에 변경해야한다)
        accommodationRepository.add(dto);   // 숙소정보를 DB에 저장
        log.info("정상적으로 add가 작동되고 등록이 된다면 보여준다 >>>>>>>>>>> " + dto);
        System.out.println("숙소 등록이 완료된다면 보여주는 dto : " + dto);

        // 이미지 정보를 저장하는 로직 추가
        if (dto.getFilenames() != null && dto.getFilenames().isEmpty()) {
            for (int i = 0; i < dto.getFilenames().size(); i++) {
                RoomImageDTO roomImage = new RoomImageDTO();
                roomImage.setFilename(dto.getFilenames().get(i));
                roomImage.setFilepath(dto.getFilepath().get(i));
                roomImage.setImageNo(dto.getAcmNo());   // 숙소 번호와 연결

                // 로그 추가
                log.info("Saving image: {}", roomImage);
                roomImageRepository.add(roomImage);
            }
        }

        // 객실 정보가 있으면 추가 (객실 등록)
        if (dto.getRooms() != null && !dto.getRooms().isEmpty()) {
            for (RoomDTO room : dto.getRooms()) {
                roomService.roomAdd(room);  // RoomService를 통해서 객실 추가
            }
        }

        // 편의시설 등록이 1개가 아니라 2개 이상..
        // 선택된 편의시설 등록
        if (dto.getAmenities() != null && !dto.getAmenities().isEmpty()) {
            for (Integer amenitiesNo : dto.getAmenities()) {
                accommodationRepository.saveAmenities(dto.getAcmNo(), amenitiesNo);
            }
        }
    }

    // 선택한 숙소의 정보를 보여주기 (1건 조회)
    public AccommodationDTO selectOne(int acmNo) {

        // roomImageRepository에서 숙소번호를 가지고 있는 이미지를 불러와서 배열로 하나씩 담고,
        // 숙소번호(acmNo)를 기준으로 filename, filepath 하나씩 불러와서 담아놓고,
        AccommodationDTO accommodationDTO = accommodationRepository.selectOne(acmNo);
        // 객실 정보 조회
        List<RoomDTO> roomList = roomService.findRoomByAccommodation(acmNo);         // 숙소 id를 통해 객실 정보 조회
        List<RoomImageDTO> roomImageList = roomImageRepository.getImages(acmNo);
        List<String> filename = new ArrayList<>();
        List<String> filepath = new ArrayList<>();

        // 그 뒤, 향상된 for문을 사용해서 roomList 안에 담긴 값들을 가져와서 추가해준다
        for (RoomImageDTO roomImage : roomImageList) {
           filename.add(roomImage.getFilename());
           filepath.add(roomImage.getFilepath());
        }

        // 그리고 DTO
        accommodationDTO.setRooms(roomList);
        accommodationDTO.setFilenames(filename);
        accommodationDTO.setFilepath(filepath);
        return accommodationDTO;
    }



    // 숙소 정보 변경
    public void acmUpdate(int acmNo) {

        accommodationRepository.acmUpdate(acmNo);
    }

    // 숙소 정보 삭제
    public void acmDelete(int acmNo) {
        accommodationRepository.acmDelete(acmNo);
    }

    // 숙소 정보 저장 (업데이트)
    public void save(AccommodationDTO accommodation) {
        accommodationRepository.update(accommodation);
    }

    // acmNo로 숙소 정보 찾기
    public AccommodationDTO findById(int acmNo) {
        return accommodationRepository.selectOne(acmNo);        // 숙소 번호로 숙소 정보 조회
    }

    // roomNo로 숙소 정보 찾기
    public AccommodationDTO findByRoomId(int roomNo) {
        return accommodationRepository.findByRoomId(roomNo);    // 객실 번호로 숙소 정보 조회
    }

}
