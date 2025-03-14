package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.MemberDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface MemberRepository {
    void insertMember(MemberDTO dto);

    MemberDTO findByUsername(String username);

    boolean existsByEmail(String memberEmail);
    // 소셜로그인 사용자 정보 찾기
    MemberDTO findByProviderId(String providerId);

    void updateMember(MemberDTO member);
}
