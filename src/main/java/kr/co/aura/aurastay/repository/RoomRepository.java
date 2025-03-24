package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.RoomDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface RoomRepository {

    // 숙소 ID로 객실 리스트 조회
    List<RoomDTO> findRoomByAccommodation(int acmNo);
    // 객실 등록(추가)
    void roomAdd(RoomDTO roomDTO);
    // 객실 정보 변경
    void roomUpdate(RoomDTO roomDTO);
    // 객실 정보 삭제
    void roomDelete(int roomNo);

    RoomDTO findByRoomId(RoomDTO roomDTO);
}
