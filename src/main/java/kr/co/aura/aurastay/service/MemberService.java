package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.MemberDTO;

public interface MemberService {
    public void save(MemberDTO dto);
    MemberDTO findByEmail(String email);
    void resetPassword(MemberDTO dto);
}
