package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.ReservationDTO;
import kr.co.aura.aurastay.dto.ReservationRequestDTO;
import kr.co.aura.aurastay.dto.SpecialRequestDTO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ReservationService {
    public List<SpecialRequestDTO> getSpecialRequests();

    int getRemainingRooms(HashMap<String, Object> rsrvMap);

    int addReservation(Map<String, Object> jsonData);

    List<ReservationDTO> getReservations(ReservationDTO reservationDTO);
    ReservationDTO getReservationDetail(ReservationDTO reservationDTO);
    List<ReservationRequestDTO> getReservationRequests(ReservationRequestDTO reservationRequestDTO);
}
