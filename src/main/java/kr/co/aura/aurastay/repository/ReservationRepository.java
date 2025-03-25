package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.ReservationDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.HashMap;

@Mapper
@Repository
public interface ReservationRepository {


    boolean existsByAccommodationNo(int acmNo);

    int getRemainingRooms(HashMap<String, Object> rsrvMap);
    int insertReservation(ReservationDTO dto);
}