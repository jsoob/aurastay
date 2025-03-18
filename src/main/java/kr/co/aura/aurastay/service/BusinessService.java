package kr.co.aura.aurastay.service;

import kr.co.aura.aurastay.dto.BusinessDTO;
import kr.co.aura.aurastay.dto.MemberDTO;

public interface BusinessService {
    public void save(BusinessDTO dto);
    BusinessDTO findByEmail(String email);
    void resetPassword(BusinessDTO dto);

}
