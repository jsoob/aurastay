package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.AccommodationDTO;

import kr.co.aura.aurastay.dto.RoomDTO;
import kr.co.aura.aurastay.repository.AccommodationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class AccommodationService {

    private final AccommodationRepository accommodationRepository;
    private final RoomService roomService;          // roomService와 연동

    // 전체 조회하기
    public List<AccommodationDTO> selectAll() {
        return accommodationRepository.selectAll();
    }

    // 숙소 정보 등록(추가)하기
    public void add(AccommodationDTO dto) {
        System.out.println("에러인가용?");

        // 만약 dto의 키워드가 null이라면? (입력이 되지 않았다면?)
        // keywordNo가 null이라면 객실정보를 저장하지 않음
        if (dto.getKeywordNo() == null) {
            // keywordNo 값이 없으면 오류를 발생시키거나, 기본값을 설정
            throw new IllegalArgumentException("키워드를 선택해주세요.");     // 예외 발생
        }

        dto.setBusinessNo(1211565655);     // 수정해야하는 데이터, 사업자번호 (추후에 변경해야한다)
        accommodationRepository.add(dto);
        System.out.println("숙소 등록이 완료된다면 보여주는 dto : " + dto);

        // 객실 정보가 있으면 추가 (객실 등록)
        if (dto.getRooms() != null && !dto.getRooms().isEmpty()) {
            for (RoomDTO room : dto.getRooms()) {
                roomService.roomAdd(room);  // RoomService를 통해서 객실 추가
            }
        }
    }


    // 선택한 숙소의 정보를 보여주기 (1건 조회)
    public AccommodationDTO selectOne(int acmNo) {
        AccommodationDTO dto = accommodationRepository.selectOne(acmNo);
        return dto;
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
