package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.AmenitiesDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface AmenitiesRepository {

    List<AmenitiesDTO> getAllAmenities();
}
