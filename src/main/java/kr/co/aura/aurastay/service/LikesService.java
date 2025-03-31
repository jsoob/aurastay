package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.LikesDTO;

import java.util.HashMap;
import java.util.List;

public interface LikesService {
    // 위시리스트 추가
    void addWishList(LikesDTO likesDTO);

    // 위시리스트 (숙소정보,이미지)
    List<HashMap<String, Object>> wishList(int memberNo);

    // 위시리스트에서 삭제
    void removeWishList(LikesDTO likesDTO);

    // 위시리스트 조회
    List<LikesDTO> getWish(int memberNo);

    // 이미 위시리스트에 저장했는지 판단
    boolean existsWish(LikesDTO likesDTO);
}
