package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.KeywordDTO;
import kr.co.aura.aurastay.repository.KeywordRepository;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.javassist.compiler.ast.Keyword;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class KeywordService {

    private final KeywordRepository keywordRepository;

    public List<KeywordDTO> getAllKeywords(){
        // 키워드 리스트 조회
        List<KeywordDTO> keywordList = keywordRepository.getAllKeywords();

        return keywordList;
    }

//    // Keyword를 KeywordDTO로 변환하는 메서드
//    private KeywordDTO convertToDTO(Keyword keyword) {
//        return new KeywordDTO(keyword.getKeywordNo(), keyword.getKeywordName()); // Keyword 필드에 맞게 수정
//    }
//
//    // 모든 키워드를 반환하는 메서드
//    public List<KeywordDTO> getAllKeywords() {
//        List<Keyword> keywords = keywordRepository.getAllKeywords(); // KeywordRepository에서 키워드 리스트 가져오기
//
//        // Keyword 리스트를 KeywordDTO 리스트로 변환
//        return keywords.stream()
//                .map(this::convertToDTO) // Keyword -> KeywordDTO 변환
//                .collect(Collectors.toList()); // List<KeywordDTO>로 변환하여 반환
//    }
}
