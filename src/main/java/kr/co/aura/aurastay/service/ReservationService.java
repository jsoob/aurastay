package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.SpecialRequestDTO;

import java.util.HashMap;
import java.util.List;

public interface ReservationService {
    public List<SpecialRequestDTO> getSpecialRequests();

    int getRemainingRooms(HashMap<String, Object> rsrvMap);
}
