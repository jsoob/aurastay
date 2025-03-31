package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.*;
import kr.co.aura.aurastay.repository.MemberAcmRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class MemberAcmService {

    private final MemberAcmRepository memberAcmRepository;

    // 사용자 화면 기준 : 선택한 숙소를 데이터베이스에서 정보를 조회한다 (숙소번호로 접근)
    public AccommodationDTO getAccommodationById(int acmNo) {
        AccommodationDTO dto = memberAcmRepository.getAccommodationById(acmNo);

        System.out.println("DTO 내용: " + dto); // DTO 상태 출력
        return dto;
    }

    // 숙소 이미지 조회
    public List<RoomImageDTO> getAccommodationRoomImagesById(int acmNo) {
        return memberAcmRepository.getAccommodationRoomImagesById(acmNo);
    }

    // 객실 정보 조회
    public List<RoomDTO> getRoomInfoById(int acmNo) {
        return memberAcmRepository.getRoomInfoById(acmNo);
    }

    // 카테고리 정보 조회
    public List<CategoryDTO> getCategoriesById(int acmNo) {
        return memberAcmRepository.getCategoriesById(acmNo);
    }

    // 키워드 정보 조회
        public List<KeywordDTO> getKeywordsById(int acmNo) {
        return memberAcmRepository.getKeywordsById(acmNo);
    }
}
