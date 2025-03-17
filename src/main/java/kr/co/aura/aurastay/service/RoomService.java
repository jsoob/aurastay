package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.AccommodationDTO;
import kr.co.aura.aurastay.dto.RoomDTO;
import kr.co.aura.aurastay.repository.RoomRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class RoomService {

    private final RoomRepository roomRepository;

    // 숙소에 대한 객실 리스트 조회
    public List<RoomDTO> findRoomByAccommodation(int acmNo){
        return roomRepository.findRoomByAccommodation(acmNo);       // acmNo를 통해 객실 리스트 조회
    }

    // 객실 등록하기
    public void roomAdd(RoomDTO roomDTO) {
        roomRepository.roomAdd(roomDTO);        // roomDTO에 포함된 acmNo가 mybatis 쿼리로 전달
    }

    // 객실 정보 변경
    public void roomUpdate(RoomDTO roomDTO) {
        roomRepository.roomUpdate(roomDTO);
    }

    // 객실 정보 삭제
    public void roomDelete(int roomNo) {
        roomRepository.roomDelete(roomNo);
    }


}
