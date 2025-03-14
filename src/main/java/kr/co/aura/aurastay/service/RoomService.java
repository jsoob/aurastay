package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.RoomDTO;
import kr.co.aura.aurastay.repository.RoomRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class RoomService {

    private final RoomRepository roomRepository;

    // 객실 등록하기
    public void roomAdd(RoomDTO roomDTO) {
        roomRepository.roomAdd(roomDTO);

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
