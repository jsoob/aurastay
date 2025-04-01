package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.BusinessDTO;
import kr.co.aura.aurastay.repository.BusinessRepository;
import kr.co.aura.aurastay.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class BusinessServiceImpl implements BusinessService {
    private final BusinessRepository businessRepository;
    private final PasswordEncoder passwordEncoder;
    private final MemberRepository memberRepository;

    // 사업자 회원가입
    public void save(BusinessDTO dto) {
        // db에 이미 동일한 username을 가진 회원이 있는지 검사해서
        boolean existsBusiness = businessRepository.existsByEmail(dto.getBusinessEmail());
        // 사용자에도 존재하는 이메일인지 확인해야함...사용자, 사업자 이메일은 유니크해야함
        boolean existsMember = memberRepository.existsByEmail(dto.getBusinessEmail());


        // 있으면 저장 안함
        if (existsBusiness || existsMember) {
            return ;
        }

        dto.setBusinessPassword(passwordEncoder.encode(dto.getBusinessPassword()));
        dto.setAuthority("ROLE_BUSINESS");
        // 없으면 저장
        businessRepository.insertBusiness(dto);
    }

    @Override
    public BusinessDTO findByEmail(String email) {
        BusinessDTO business = businessRepository.findByUsername(email);
        return business;
    }

    @Override
    public void resetPassword(BusinessDTO dto) {
        dto.setBusinessPassword(passwordEncoder.encode(dto.getBusinessPassword()));
        businessRepository.resetPassword(dto);
    }

    @Override
    public boolean isBusinessExist(String email) {
        return businessRepository.existsByEmail(email);
    }

    @Override
    public boolean isAllBusinessExist(String email) {
        return businessRepository.existsByEmailAndWithdrawal(email);
    }

    @Override
    public boolean isBusinessNoExist(String businessNo) {
        return businessRepository.existsById(businessNo);
    }
}
