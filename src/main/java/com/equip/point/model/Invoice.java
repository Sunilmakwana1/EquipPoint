package com.equip.point.model;

public class Invoice {

    /*
    payment_id bigint AI PK
bill_id bigint
payment_amount decimal(20,2)
payment_date date

     */
    private Long paymentId;
    private Long billId;
    private String paymentDate;
    private String paymentAmount;

    public Invoice() {
    }
    public Invoice(Long paymentId, Long billId, String paymentDate, String paymentAmount) {
        this.paymentId = paymentId;
        this.billId = billId;
        this.paymentDate = paymentDate;
        this.paymentAmount = paymentAmount;
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
    public String getPaymentDate() {
        return paymentDate;
    }
    public void setPaymentDate(String paymentDate) {
        this.paymentDate = paymentDate;
    }
    public String getPaymentAmount() {
        return paymentAmount;
    }
    public void setPaymentAmount(String paymentAmount) {
        this.paymentAmount = paymentAmount;
    }
    @Override
    public String toString() {
        return "Invoice [paymentId=" + paymentId + ", billId=" + billId + ", paymentDate=" + paymentDate
                + ", paymentAmount=" + paymentAmount + "]";
    }
}
