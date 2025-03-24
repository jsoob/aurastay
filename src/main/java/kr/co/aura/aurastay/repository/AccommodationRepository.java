package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.AccommodationDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


@Mapper
@Repository
public interface AccommodationRepository {

    // 전체조회
    List<AccommodationDTO> selectAll(@Param("offset") int offset, int limit, @Param("search") String search);

    // 전체 숙소 개수를 가져오는 메서드 추가
    int countAll(String search); // 추가

    // 등록하기
    void add(AccommodationDTO dto);

    // 선택한 숙소 정보의 1건을 조회하기
    AccommodationDTO selectOne(int acmNo);

    // 숙소 정보 변경
    void acmUpdate(AccommodationDTO dto);

    // 숙소 삭제
    void acmDelete(int acmNo);

    //
    AccommodationDTO findById(int acmNo);           // 숙소 ID로 숙소정보를 조회하는 메서드

    AccommodationDTO findByRoomId(int roomNo);      // 객실 번호로 해당 객실이 속한 숙소를 찾는 메서드

    void update(AccommodationDTO accommodation);    // 수정된 숙소 정보를 DB에 업데이트하는 메서드

    // 편의시설 정보 가져오기
    void saveAmenities(@Param("accommodationNo") int accommodationNo, @Param("amenitiesNo") Integer amenitiesNo);

    // 숙소 정보 변경하기 위해서 기존에 정보를 불러올 때 필요
    List<Integer> selectSelectedKeywords(int acmNo);
    List<Integer> selectSelectedAmenities(int acmNo);
}