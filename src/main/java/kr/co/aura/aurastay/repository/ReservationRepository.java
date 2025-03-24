package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.ReservationDTO;
import kr.co.aura.aurastay.dto.ReservationRequestDTO;
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

    List<ReservationDTO> getReservations(ReservationDTO reservationDTO);
    ReservationDTO getReservation(ReservationDTO reservationDTO);

    List<ReservationRequestDTO> getReservationRequests(ReservationRequestDTO reservationRequestDTO);
}
