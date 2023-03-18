package com.cashrich.coinrich.request;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

@Data
public class UserRequest {

    @NotBlank(message = "Invalid Username")
    @Pattern(regexp = "[A-Za-z0-9]{4,15}", message = "Invalid Username")
    private String username;
    @NotBlank(message = "Invalid Username")
    @Pattern(regexp = "\\S{8,15}", message = "Invalid Password")
    private String password;

}
