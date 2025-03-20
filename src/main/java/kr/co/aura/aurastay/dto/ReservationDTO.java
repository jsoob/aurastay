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
    private int reservation_no;
    private int member_no;
    private int room_no;
    private int accommodation_no;

    private String checkin_date;
    private String checkout_date;
    private String reservation_status;
    private String reservation_details_request;
    private String residence_country;
    private String guest_name;
    private String guest_phone_number;
    private String guest_email;
}
