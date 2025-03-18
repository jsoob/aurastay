package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.SpecialRequestDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Mapper
@Repository
public interface ReservationRepository {
    List<SpecialRequestDTO> getSpecialRequests();
    int getRemainingRooms(HashMap<String, Object> rsrvMap);
}
