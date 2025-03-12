package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.MemberDTO;
import kr.co.aura.aurastay.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class MemberServiceImpl implements MemberService {
    private final MemberRepository memberRepository;
    private final PasswordEncoder passwordEncoder;

    public void save(MemberDTO dto) {
        // db에 이미 동일한 username을 가진 회원이 있는지 검사해서
        boolean existsMember = memberRepository.existsByEmail(dto.getMemberEmail());
        // 사업자에도 존재하는 이메일인지 확인해야함...사용자, 사업자 이메일은 유니크해야함
        
        // 있으면 저장 안함
        if (existsMember) {
            return ;
        }

        dto.setMemberPassword(passwordEncoder.encode(dto.getMemberPassword()));
        dto.setAuthority("ROLE_MEMBER");
        // 없으면 저장
        memberRepository.insertMember(dto);
    }

}
