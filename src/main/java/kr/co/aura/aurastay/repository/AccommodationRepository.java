package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.AccommodationDTO;
import lombok.RequiredArgsConstructor;
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
//    void fileadd(AccommodationDTO dto);
}
