package com.siot.IamportRestClient.request;

import java.math.BigDecimal;

import com.google.gson.annotations.SerializedName;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class OnetimePaymentData {

    @SerializedName("merchant_uid")
    private String merchant_uid;

    @SerializedName("amount")
    private BigDecimal amount;

    @SerializedName("vat")
    private BigDecimal vat;

    @SerializedName("customer_uid")
    private String customer_uid;

    @SerializedName("pg")
    private String pg;

    @SerializedName("currency")
    private String currency;

    @SerializedName("name")
    private String name;

    @SerializedName("buyer_name")
    private String buyer_name;

    @SerializedName("buyer_email")
    private String buyer_email;

    @SerializedName("buyer_tel")
    private String buyer_tel;

    @SerializedName("buyer_addr")
    private String buyer_addr;

    @SerializedName("buyer_postcode")
    private String buyer_postcode;

    @SerializedName("browser_ip")
    private String browser_ip;

    @SerializedName("secure_3d_charge_id")
    private String secure_3d_charge_id;

    @SerializedName("secure_3d_token")
    private String secure_3d_token;

    @SerializedName("card_quota")
    private int card_quota;

    @SerializedName("custom_data")
    private String custom_data;
    
    @SerializedName("notice_url")
    private String notice_url;

    @SerializedName("card_number")
    protected String card_number;

    @SerializedName("expiry")
    protected String expiry;

    @SerializedName("birth")
    protected String birth;

    @SerializedName("pwd_2digit")
    protected String pwd_2digit;

}
