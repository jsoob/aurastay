package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.AccommodationDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface MemberAcmRepository {

    // 사용자 화면 기준 : 선택한 숙소의 정보 조회
    AccommodationDTO getAccommodationById(int acmNo);
    
}
