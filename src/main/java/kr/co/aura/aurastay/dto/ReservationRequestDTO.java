package kr.co.aura.aurastay.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ReservationRequestDTO {
    private int requestNo;
    private String requestName;
    private int reservationNo;
}
