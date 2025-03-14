package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.BusinessDTO;
import kr.co.aura.aurastay.dto.MemberDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface BusinessRepository {
    void insertBusiness(BusinessDTO dto);

    BusinessDTO findByUsername(String username);

    boolean existsByEmail(String businessEmail);
}
