package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.MemberDTO;
import kr.co.aura.aurastay.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class MemberServiceImpl implements MemberService {
    private final MemberRepository memberRepository;

    public void save(MemberDTO dto) {
        memberRepository.insertMember(dto);
    }

}
