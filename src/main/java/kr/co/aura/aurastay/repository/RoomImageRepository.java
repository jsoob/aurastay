package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.RoomImageDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface RoomImageRepository {

    void add(RoomImageDTO image);

    List<RoomImageDTO> getImages(int acmNo);

}
