package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.AccommodationDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface AccommodationRepository {

    // 전체조회
    List<AccommodationDTO> selectAll();
    // 등록하기
    void add(AccommodationDTO dto);
    // 선택한 숙소 정보의 1건을 조회하기
    AccommodationDTO selectOne(int acmNo);
    // 숙소 정보 변경
    void acmUpdate(int acmNo);
    // 숙소 삭제
    void acmDelete(int acmNo);


//    void fileadd(AccommodationDTO dto);
}
