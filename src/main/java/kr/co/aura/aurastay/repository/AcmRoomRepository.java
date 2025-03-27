package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.AccommodationDTO;
import kr.co.aura.aurastay.dto.AcmDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Mapper
@Repository
public interface AcmRoomRepository {
//    HashMap<String, Object> selectRoomDetail(int accommodationNo, int roomNo);
    AcmDTO selectRoomDetail(AcmDTO acmDTO);
    List<AccommodationDTO> getBnsAcmList(@Param("businessNo") int businessNo, @Param("offset") int offset, int limit, @Param("search") String search);

    int countAll(int businessNo, String search);
}
