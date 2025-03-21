package kr.co.aura.aurastay.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ReservationDTO {
    private int reservationNo;
    private int memberNo;
    private int roomNo;
    private int accommodationNo;

    private String checkinDate;
    private String checkoutDate;
    private int reservationStatus;
    private String reservationDetailsRequest;
    private String residenceCountry;
    private String guestName;
    private String guestPhoneNumber;
    private String guestEmail;
}
