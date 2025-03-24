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
    private int dayCount;

    private List<SpecialRequestDTO> specialRequests;
    private List<ReservationRequestDTO> reservationRequests;
    private PaymentDTO payment;
    private AcmDTO acmDTO;
}
