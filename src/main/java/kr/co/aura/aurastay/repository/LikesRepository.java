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

    // 위시리스트의 숙소정보, 파일이미지 가져옴
    List<HashMap<String, Object>> getWishList(int memberNo);

    // 위시리스트에서 삭제
    void deleteWishList(LikesDTO likesDTO);

    // 위시리스트 조회
    List<LikesDTO> getWish(int memberNo);

    // 이미 위시리스트에 저장한 곳인지 판단
    boolean existsWish(LikesDTO likesDTO);
}
