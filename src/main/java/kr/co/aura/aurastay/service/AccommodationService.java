package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.AccommodationDTO;

import kr.co.aura.aurastay.repository.AccommodationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class AccommodationService {

    private final AccommodationRepository accommodationRepository;

    // 전체 조회하기
    public List<AccommodationDTO> selectAll() {
        return accommodationRepository.selectAll();
    }

    // 숙소 정보 등록(추가)하기
    public void add(AccommodationDTO dto) {
        System.out.println("에러인가용?");
        accommodationRepository.add(dto);
    }


}
