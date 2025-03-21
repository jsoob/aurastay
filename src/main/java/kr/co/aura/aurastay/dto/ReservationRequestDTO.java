package kr.co.aura.aurastay.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReservationRequestDTO {
    private int requestNo;
    private int reservationNo;
    private String requestName;
}
