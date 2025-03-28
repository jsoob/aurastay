package kr.co.aura.aurastay.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RefundRequest {
    String impUid;
    String merchantUid;
    String amount;
    String reason;
}
