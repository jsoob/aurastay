package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.LikesDTO;

import java.util.HashMap;
import java.util.List;

public interface LikesService {
    // 위시리스트 추가
    void addWishList(LikesDTO likesDTO);

    // 위시리스트
    List<HashMap<String, Object>> wishList(int memberNo);

    void removeWishList(LikesDTO likesDTO);
}
