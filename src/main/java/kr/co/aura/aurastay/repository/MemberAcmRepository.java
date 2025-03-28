package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.*;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface MemberAcmRepository {

    // 사용자 화면 기준 : 선택한 숙소의 정보 조회
    AccommodationDTO getAccommodationById(int acmNo);
    // 사용자 화면 기준 : 선택한 숙소에 등록되어있는 이미지 조회
    List<RoomImageDTO> getAccommodationRoomImagesById(int acmNo);
    // 사용자 화면 기준 : 선택한 숙소에 등록되어있는 객실 정보 조회
    List<RoomDTO> getRoomInfoById(int acmNo);
    // 사용자 화면 기준 : 선택한 숙소에 등록되어있는 카테고리 정보 조회
    List<CategoryDTO> getCategoriesById(int acmNo);
    // 사용자 화면 기준 : 선택한 숙소에 등록되어있는 키워드 정보 조회
    List<KeywordDTO> getKeywordsById(int acmNo);

}
