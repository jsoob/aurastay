package kr.co.aura.aurastay.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PaymentDTO {
    private int paymentNo;
    private int roomPrice;
    private int pointPrice;
    private int paymentPrice;
    private int paymentStatus;
    private String paymentId;
    private String provider;
    private String paymentCompletionDate;
    private String paymentCancelId;
    private String paymentCancelDate;
    private int reservationNo;
}
