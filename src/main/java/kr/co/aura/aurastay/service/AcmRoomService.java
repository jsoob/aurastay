package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.AcmDTO;
import kr.co.aura.aurastay.repository.AcmRoomRepository;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

import java.util.HashMap;

@RequiredArgsConstructor
@Service
public class AcmRoomService {
    private final AcmRoomRepository acmRoomRepository;

    public AcmDTO selectRoomDetail(AcmDTO acmDTO) {
        return acmRoomRepository.selectRoomDetail(acmDTO);
    }
}
