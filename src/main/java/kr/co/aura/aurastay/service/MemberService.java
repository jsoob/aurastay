package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.MemberDTO;

import java.util.HashMap;
import java.util.List;

public interface MemberService {
    // 사용자 정보 저장
    public void save(MemberDTO dto);
    // 이메일로 사용자 찾기
    MemberDTO findByEmail(String email);
    // 소셜로그인 사용자 정보 찾기
    MemberDTO findByProviderId(String providerId);
    // 비밀번호 재설정
    void resetPassword(MemberDTO dto);
    // 존재하는 사용자인지 확인
    boolean isMemberExist(String email);
    // 개인정보 수정
    void modifyMemberInfo(MemberDTO dto);
    // memberNo로 사용자 찾기
    MemberDTO findByMemberNo(int memberNo);
    // 회원탈퇴
    void withdrawalMember(int memberNo);

    // 숙소 쪽으로 옮기거나 삭제하거나
    List<HashMap<String, Object>> getAllAccommodation();
}
