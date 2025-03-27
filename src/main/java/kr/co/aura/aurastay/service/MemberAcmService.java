package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.AccommodationDTO;
import kr.co.aura.aurastay.repository.MemberAcmRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class MemberAcmService {

    private final MemberAcmRepository memberAcmRepository;

    // 사용자 화면 기준 : 선택한 숙소를 데이터베이스에서 정보를 조회한다 (숙소번호로 접근)
    public AccommodationDTO getAccommodationById(int acmNo) {
        AccommodationDTO dto = memberAcmRepository.getAccommodationById(acmNo);

        System.out.println("DTO 내용: " + dto); // DTO 상태 출력

        return dto;

//        return memberAcmRepository.getAccommodationById(acmNo);

    }
}
