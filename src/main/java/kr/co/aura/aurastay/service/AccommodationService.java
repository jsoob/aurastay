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
        dto.setBusinessNo(1211565655);     // 수정해야하는 데이터, 사업자번호 (추후에 변경해야한다)
        accommodationRepository.add(dto);
        System.out.println("dto : " + dto);     //
    }

    // 선택한 숙소의 정보를 보여주기 (1건 조회)
    public AccommodationDTO selectOne(int acmNo) {
        AccommodationDTO dto = accommodationRepository.selectOne(acmNo);
        return dto;
    }


    // 숙소 정보 변경
    public void acmUpdate(int acmNo) {
        accommodationRepository.acmUpdate(acmNo);
    }

    // 숙소 정보 삭제
    public void acmDelete(int acmNo) {
        accommodationRepository.acmDelete(acmNo);
    }
}
