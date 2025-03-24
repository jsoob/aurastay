package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.AccommodationDTO;
import kr.co.aura.aurastay.dto.RoomDTO;
import kr.co.aura.aurastay.repository.RoomRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Service
@Transactional
public class RoomService {

    private final RoomRepository roomRepository;

    // 숙소에 대한 객실 리스트 조회
    public List<RoomDTO> findRoomByAccommodation(int acmNo){
//        List<RoomDTO> rooms = roomRepository.findRoomByAccommodation(acmNo);
//        log.info("방이 조회가 되고 있나요? >>>>>>>>>>> {} : {} ", acmNo, rooms);
        return roomRepository.findRoomByAccommodation(acmNo);       // acmNo를 통해 객실 리스트 조회
//        return rooms;
    }

    // 객실 등록하기
    public void roomAdd(RoomDTO roomDTO) {
        roomRepository.roomAdd(roomDTO);        // roomDTO에 포함된 acmNo가 mybatis 쿼리로 전달
    }

    // 객실 정보 변경
    public void roomUpdate(RoomDTO roomDTO) {
        log.info("Updating room in repository(여기서는 정상적으로 되고 있는가?>>>>>>>>> ) : {}", roomDTO); // 로그 추가
        roomRepository.roomUpdate(roomDTO);
    }

    // 객실 정보 삭제
    public void roomDelete(int roomNo) {
        roomRepository.roomDelete(roomNo);
    }

    // 객실 1건 조회
    public RoomDTO findByRoomId(RoomDTO roomDTO) {
        return roomRepository.findByRoomId(roomDTO);
    }

}
