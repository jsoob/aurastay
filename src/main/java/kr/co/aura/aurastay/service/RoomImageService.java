package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.RoomImageDTO;
import kr.co.aura.aurastay.repository.RoomImageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class RoomImageService {

    private final RoomImageRepository roomImageRepository;

    // 숙소 이미지 저장
    public void saveRoomImage(RoomImageDTO roomImage) {
        roomImageRepository.add(roomImage);
    }
    
}
