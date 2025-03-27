package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.ReservationCancelDTO;
import kr.co.aura.aurastay.dto.ReservationDTO;
import kr.co.aura.aurastay.dto.ReservationRequestDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Mapper
@Repository
public interface ReservationRepository {
    // 등록
    int getRemainingRooms(HashMap<String, Object> rsrvMap);
    int insertReservation(ReservationDTO dto);

    // 예약 조회
    List<ReservationDTO> getReservations(ReservationDTO reservationDTO);
    ReservationDTO getReservation(ReservationDTO reservationDTO);

    // 예약 - 요청 조회
    List<ReservationRequestDTO> getReservationRequests(ReservationRequestDTO reservationRequestDTO);
    // 예약 취소 요청
    void cancelReservationReq(ReservationDTO rsDTO);

    // 숙소 관련
    boolean existsByAccommodationNo(int acmNo);
}
