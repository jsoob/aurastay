package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.LikesDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
@Mapper
public interface LikesRepository {
    // 위시리스트에 담기
    void addWishList(LikesDTO likesDTO);

    // 위시리스트
    List<HashMap<String, Object>> getWishList(int memberNo);

    void deleteWishList(LikesDTO likesDTO);
}
