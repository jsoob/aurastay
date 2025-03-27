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

    List<HashMap<String, Object>> getPagedAccommodations();

    int getTotalCount();
}
