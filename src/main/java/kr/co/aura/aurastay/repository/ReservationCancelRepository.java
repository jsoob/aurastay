package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.ReservationCancelDTO;
import kr.co.aura.aurastay.dto.ReservationDTO;
import kr.co.aura.aurastay.dto.ReservationRequestDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Mapper
@Repository
public interface ReservationCancelRepository {
    void cancelReservationReq(ReservationCancelDTO cancelDTO);
}
