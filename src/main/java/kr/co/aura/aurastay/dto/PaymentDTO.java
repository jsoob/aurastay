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
    private int payment_no;
    private int room_price;
    private int point_price;
    private int payment_price;
    private String payment_status;
    private String payment_id;
    private String provider;
    private String payment_completion_date;
    private String payment_cancel_id;
    private String payment_cancel_date;
    private int reservation_no;
}
