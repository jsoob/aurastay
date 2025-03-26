package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.AccommodationDTO;

import kr.co.aura.aurastay.dto.AmenitiesDTO;
import kr.co.aura.aurastay.dto.RoomDTO;
import kr.co.aura.aurastay.dto.RoomImageDTO;
import kr.co.aura.aurastay.repository.AccommodationRepository;
import kr.co.aura.aurastay.repository.ReservationRepository;
import kr.co.aura.aurastay.repository.RoomImageRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@Service
public class AccommodationService {

    private final AccommodationRepository accommodationRepository;
    private final RoomService roomService;          // roomService와 연동
    private final RoomImageRepository roomImageRepository;
    private final ReservationRepository reservationRepository;

    // 전체 조회하기
    public List<AccommodationDTO> selectAll(int currentPage, int pageSize, String search) {
        int offset = (currentPage - 1) * pageSize;      // offset 계산
        // 만약, 검색어가 없거나 공백인 경우에는 ?
        if (search == null || search.isEmpty()) {
            // 전체 숙소 목록을 보여준다
            return accommodationRepository.selectAll(offset, pageSize, null);   // null 로 검색어를 전달
        } else {
            // 그게 아니라면? 작성자가 입력한 검색 결과를 보여준다
            return accommodationRepository.selectAll(offset, pageSize, search);     // repository 메서드 호출 (해당 부분에서 offset과 pageSize 전달) : 데이터베이스에서 목록 가져오기
        }
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
        if (dto.getFilenames() != null && !dto.getFilenames().isEmpty()) {
            addImages(dto.getAcmNo(), dto.getFilenames(), dto.getFilepath());
        }

//        // 이미지 정보를 저장하는 로직 추가
//        if (dto.getFilenames() != null && dto.getFilenames().isEmpty()) {
//            for (int i = 0; i < dto.getFilenames().size(); i++) {
//                RoomImageDTO roomImage = new RoomImageDTO();
//                roomImage.setFilename(dto.getFilenames().get(i));
//                roomImage.setFilepath(dto.getFilepath().get(i));
//                roomImage.setImageNo(dto.getAcmNo());   // 숙소 번호와 연결
//
//                // 로그 추가
//                log.info("Saving image: {}", roomImage);
//                roomImageRepository.add(roomImage);
//            }
//        }

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

    // 페이지네이션을 위해 전체 숙소 개수를 가져오는 conutAll() 메서드가 필요
    // 전체 숙소 조회 (검색어 포함)
    public int countAll(String search) {
        return accommodationRepository.countAll(search);
    }


    // 숙소 정보 변경/수정
    public void updateAccommodation(AccommodationDTO dto) {
        // 숙소 정보 업데이트
        accommodationRepository.updateAccommodation(dto);

        // 기존 이미지 삭제
        deleteExistingImages(dto.getAcmNo());

        // 새로운 이미지 추가
        if (dto.getFilenames() != null && !dto.getFilenames().isEmpty()) {
            addImages(dto.getAcmNo(), dto.getFilenames(), dto.getFilepath());
        }

//        // 객실 정보가 있으면 추가 (객실 등록 또는 업데이트)
//        if (dto.getRooms() != null && !dto.getRooms().isEmpty()) {
//            for (RoomDTO room : dto.getRooms()) {
//                if (room.getRoomNo() > 0) { // roomNo가 0보다 큰 경우
//                    roomService.roomUpdate(room); // 기존 객실 정보 업데이트
//                } else {
//                    roomService.roomAdd(room); // 새로운 객실 정보 추가
//                }
//            }
//        }

        // 편의시설 업데이트
        if (dto.getAmenities() != null && !dto.getAmenities().isEmpty()) {
            deleteAmenities(dto.getAcmNo()); // 기존 편의시설 삭제
            for (Integer amenitiesNo : dto.getAmenities()) {
                accommodationRepository.addAmenities(dto.getAcmNo(), amenitiesNo);
            }
        }
        accommodationRepository.updateAccommodation(dto);
    }

    // 숙소 정보와 함께 선택된 키워드와 편의시설을 불러오는 메서드
    public List<Integer> getSelectedKeywords(int acmNo) {
        return accommodationRepository.selectSelectedKeywords(acmNo);
    }

    public List<Integer> getSelectedAmenities(int acmNo) {
        return accommodationRepository.selectSelectedAmenities(acmNo);
    }


    // 정보 변경할 때 필요한 편의시설 정보 삭제 후 다시 저장하기 위한 메서드
    public void deleteAmenities(int acmNo) {
        accommodationRepository.deleteAmenities(acmNo);
    }

    // 편의시설 정보 (추가)
    public void addAmenities(int acmNo, int amenitiesNo) {
        accommodationRepository.addAmenities(acmNo, amenitiesNo);
    }

    // 정보 변경할 때 필요한 이미지 첨부파일 정보 (추가)
    public void deleteExistingImages(int acmNo) {
        accommodationRepository.deleteExistingImages(acmNo);
    }

    // 이미지 정보 (추가)
    public void addImages(int acmNo, List<String> filenames, List<String> filepath) {
        // 현재 파일 경로를 출력 (디버깅용)
        System.out.println("파일 경로 >>>>>>>>>>>>>> : " + filepath);

        // filenames와 filepath를 각각 반복하면서 처리
        for (int i = 0; i < filenames.size(); i++) {
            // 각 파일 이름과 경로를 하나씩 꺼내서 처리
            String filename = filenames.get(i);  // 현재 파일 이름
            String path = filepath.get(i);  // 현재 파일 경로

            // imageNo는 자동 증가가 아닌 경우, 적절한 값을 설정
//            int imageNo = i + 1; // 예시로 인덱스를 사용할 수 있지만, 실제로는 다른 로직이 필요할 수 있음

            // 파일명과 경로를 repository에 전달
            accommodationRepository.addImages(acmNo, filename, path);
        }
    }

    // 삭제 전, 예약내역 존재여부 확인 중
    public boolean checkReservations(int acmNo) {
        // 해당 숙소의 예약 내역이 존재하는지 확인
        return reservationRepository.existsByAccommodationNo(acmNo);
    }

    // 숙소 정보 삭제
    public void acmDelete(int acmNo) {

        // 객실 삭제
        accommodationRepository.deleteRoomsByAccommodationNo(acmNo);
        // 숙소 삭제
        accommodationRepository.acmDelete(acmNo);
    }

}