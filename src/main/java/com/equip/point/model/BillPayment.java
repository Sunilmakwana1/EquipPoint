package com.equip.point.model;

public class BillPayment {

    private Long billId;
    private Long equipmentId;
    private String billDate;

    public BillPayment() {
        super();
    }
    public Long getBillId() {
        return billId;
    }
    public void setBillId(Long billId) {
        this.billId = billId;
    }
    public Long getEquipmentId() {
        return equipmentId;
    }
    public void setEquipmentId(Long equipmentId) {
        this.equipmentId = equipmentId;
    }
    public String getBillDate() {
        return billDate;
    }
    public void setBillDate(String billDate) {
        this.billDate = billDate;
    }
    @Override
    public String toString() {
        return "BillPayment [billId=" + billId + ", equipmentId=" + equipmentId + ", billDate=" + billDate + "]";
    }
    @Override
    public int hashCode() {
        return (int) (billId + equipmentId + billDate.hashCode());
    }
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        BillPayment other = (BillPayment) obj;
        return billId.equals(other.billId) && equipmentId.equals(other.equipmentId) && billDate.equals(other.billDate);
    }


}
