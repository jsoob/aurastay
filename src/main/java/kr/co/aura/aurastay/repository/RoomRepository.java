package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.RoomDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface RoomRepository {

    // 객실 등록(추가)
    void roomAdd(RoomDTO roomDTO);
    // 객실 정보 변경
    void roomUpdate(RoomDTO roomDTO);
    // 객실 정보 삭제
    void roomDelete(int roomNo);
}
