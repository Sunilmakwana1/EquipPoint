package com.equip.point.model;

public class Payment {


    private Long paymentId;
    private Long billId;
    private Long paymentAmount;
    private String paymentDate;

    public Payment() {
        super();
    }
    public Long getPaymentId() {
        return paymentId;
    }
    public void setPaymentId(Long paymentId) {
        this.paymentId = paymentId;
    }
    public Long getBillId() {
        return billId;
    }
    public void setBillId(Long billId) {
        this.billId = billId;
    }
    public Long getPaymentAmount() {
        return paymentAmount;
    }
    public void setPaymentAmount(Long paymentAmount) {
        this.paymentAmount = paymentAmount;
    }
    public String getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(String paymentDate) {
        this.paymentDate = paymentDate;
    }
    @Override
    public String toString() {
        return "Payment [paymentId=" + paymentId + ", billId=" + billId + ", paymentAmount=" + paymentAmount
                + ", paymentDate=" + paymentDate + "]";
    }
}
