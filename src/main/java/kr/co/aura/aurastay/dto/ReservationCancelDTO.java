package kr.co.aura.aurastay.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ReservationCancelDTO {
    private int cancelNo;
    private String cancelReasons;
    private int cancelStatus;
    private String cancelDate;
    private String  cancelRespDate;
    private int reservationNo;
}
