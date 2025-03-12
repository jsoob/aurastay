package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.SpecialRequestDTO;

import java.util.List;

public interface ReservationService {
    public List<SpecialRequestDTO> getSpecialRequests();
}
