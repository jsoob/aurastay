package kr.co.aura.aurastay.service;

import java.util.HashMap;
import java.util.List;

public interface MainService {
    // 숙소 쪽으로 옮기거나 삭제하거나
    List<HashMap<String, Object>> getAllAccommodation();


    List<HashMap<String, Object>> getPagedAccommodations(int offset, int size);

    int getTotalCount();
}
