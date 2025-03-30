package kr.co.aura.aurastay.service;

import java.util.HashMap;
import java.util.List;

public interface MainService {
    // 숙소 쪽으로 옮기거나 삭제하거나
    List<HashMap<String, Object>> getAllAccommodation();
    // 숙소 12개씩 가져오기
    List<HashMap<String, Object>> getPagedAccommodations(int offset, int size);
    // 전체 숙소 수
    int getTotalCount();
    // 숙소별 리뷰 수, 리뷰 평점
    List<HashMap<String, Object>> getReview();
}
