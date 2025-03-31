package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.*;
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
    int countAcmAll(int businessNo, String search);

    List<RoomDTO> getBnsRoomList(@Param("acmNo") int acmNo, @Param("offset") int offset, int limit, @Param("search") String search);
    int countRoomAll(int acmNo, String search);

    RoomImageDTO getImageOne(int acmNo);
}
