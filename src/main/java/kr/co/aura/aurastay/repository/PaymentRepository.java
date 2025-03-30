package kr.co.aura.aurastay.repository;

import kr.co.aura.aurastay.dto.PaymentDTO;
import kr.co.aura.aurastay.dto.SpecialRequestDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface PaymentRepository {
    PaymentDTO getPayment(int reservationNo);
    void insertPayment(PaymentDTO paymentDTO);
    void cancelPayment(PaymentDTO paymentDTO);
}
