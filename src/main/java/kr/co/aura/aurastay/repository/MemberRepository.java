package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.MemberDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
@Mapper
public interface MemberRepository {
    // 사용자 정보 저장
    void insertMember(MemberDTO dto);
    // 이메일로 사용자 찾기
    MemberDTO findByUsername(String username);
    // 존재하는 사용자인지 확인
    boolean existsByEmail(String memberEmail);
    // 소셜로그인 사용자 정보 찾기
    MemberDTO findByProviderId(String providerId);
    // 사용자 정보 수정
    void updateMember(MemberDTO member);
    // 비밀번호 재설정
    void resetPassword(MemberDTO member);
    // 마이페이지 정보 수정
    void modifyMember(MemberDTO member);
    // memberNo로 사용자 찾기
    MemberDTO findById(int memberNo);
    // 사용자 삭제
    void deleteMember(int memberNo);

    // 숙소 쪽으로 옮기거나 삭제하거나
    List<HashMap<String, Object>> getAllAccommodation();
}
