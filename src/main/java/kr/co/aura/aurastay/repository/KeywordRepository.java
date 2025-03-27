package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.KeywordDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface KeywordRepository {

    // 키워드 목록 리스트로 전체 조회하기
    List<KeywordDTO> getAllKeywords();

    // 숙소 등록 이후, 숙소 내용을 확인했을 때 보여지는 선택한 키워드가 무엇인지?
    KeywordDTO getKeywordById(Integer keywordNo);
}
