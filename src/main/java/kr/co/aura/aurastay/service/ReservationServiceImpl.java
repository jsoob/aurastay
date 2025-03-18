package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.SpecialRequestDTO;
import kr.co.aura.aurastay.repository.ReservationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ReservationServiceImpl implements ReservationService {
    private final ReservationRepository reservationRepository;
    @Override
    public List<SpecialRequestDTO> getSpecialRequests() {
        return reservationRepository.getSpecialRequests();
    }

    @Override
    public int getRemainingRooms(HashMap<String, Object> rsrvMap) {
        return reservationRepository.getRemainingRooms(rsrvMap);
    }
}
