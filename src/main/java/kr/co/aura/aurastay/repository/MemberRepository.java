package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.MemberDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface MemberRepository {
    public void insertMember(MemberDTO dto);
}
