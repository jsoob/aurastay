package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.MemberDTO;
import kr.co.aura.aurastay.repository.BusinessRepository;
import kr.co.aura.aurastay.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@RequiredArgsConstructor
@Service
public class MemberServiceImpl implements MemberService {
    private final MemberRepository memberRepository;
    private final PasswordEncoder passwordEncoder;
    private final BusinessRepository businessRepository;

    // 사용자 회원가입
    public void save(MemberDTO dto) {
        // db에 이미 동일한 username을 가진 회원이 있는지 검사해서
        boolean existsMember = memberRepository.existsByEmail(dto.getMemberEmail());
        // 사업자에도 존재하는 이메일인지 확인해야함...사용자, 사업자 이메일은 유니크해야함
        boolean existsBusiness = businessRepository.existsByEmail(dto.getMemberEmail());
        // 있으면 저장 안함
        if (existsMember || existsBusiness) {
            return ;
        }

        dto.setMemberPassword(passwordEncoder.encode(dto.getMemberPassword()));
        dto.setAuthority("ROLE_MEMBER");
        // 없으면 저장
        memberRepository.insertMember(dto);
    }

    @Override
    public MemberDTO findByEmail(String email) {
        MemberDTO member = memberRepository.findByUsername(email);
        return member;
    }

    @Override
    public MemberDTO findByProviderId(String providerId) {
        return memberRepository.findByProviderId(providerId);
    }

    @Override
    public void resetPassword(MemberDTO dto) {
        dto.setMemberPassword(passwordEncoder.encode(dto.getMemberPassword()));
        memberRepository.resetPassword(dto);
    }

    @Override
    public boolean isMemberExist(String email) {
        return memberRepository.existsByEmail(email);
    }

    @Override
    public void modifyMemberInfo(MemberDTO dto) {
        memberRepository.modifyMember(dto);
    }

    @Override
    public MemberDTO findByMemberNo(int memberNo) {
        return memberRepository.findById(memberNo);
    }

    @Override
    public void withdrawalMember(int memberNo) {
        memberRepository.deleteMember(memberNo);
    }

    // 숙소 쪽으로 옮기거나 삭제하거나
    @Override
    public List<HashMap<String, Object>> getAllAccommodation() {
        return memberRepository.getAllAccommodation();
    }

}
