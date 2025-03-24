package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.AcmDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.HashMap;

@Mapper
@Repository
public interface AcmRoomRepository {
    AcmDTO selectRoomDetail(AcmDTO acmDTO);
}
