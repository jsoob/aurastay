package kr.co.aura.aurastay.dto;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MUser {
    private String email;
    private String password;
    private String authority;
    private int type;

}
