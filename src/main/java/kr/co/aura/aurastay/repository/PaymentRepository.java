package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.PaymentDTO;
import kr.co.aura.aurastay.dto.SpecialRequestDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface PaymentRepository {

    void insertPayment(PaymentDTO paymentDTO);
}
