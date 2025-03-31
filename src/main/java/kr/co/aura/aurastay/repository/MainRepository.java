package kr.co.aura.aurastay.repository;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
@Mapper
public interface MainRepository {
    // 전체 숙소 정보, 이미지
    List<HashMap<String, Object>> getAllAccommodation();
    // 숙소 12개씩 가져오기
    List<HashMap<String, Object>> getPagedAccommodations(HashMap<String,Integer> map);
    // 전체 숙소 수
    int getTotalCount();
    // 숙소별 리뷰 수, 리뷰평점
    List<HashMap<String, Object>>getReview();
}
