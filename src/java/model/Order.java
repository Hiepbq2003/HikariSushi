package model;

import java.util.Date;

public class Order {
    
     private int orderId;
    private String userName;
    private String phoneNumber;
    private String email;
    private String address;
    private Date date;
    private float total;
    private String orderStatus;
    private String notes;

    public Order() {
    }

    public Order(int orderId, String userName, String phoneNumber, String email, String address, Date date, float total, String orderStatus, String notes) {
        this.orderId = orderId;
        this.userName = userName;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.address = address;
        this.date = date;
        this.total = total;
        this.orderStatus = orderStatus;
        this.notes = notes;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    @Override
    public String toString() {
        return "Order{" + "orderId=" + orderId + ", userName=" + userName + ", phoneNumber=" + phoneNumber + ", email=" + email + ", address=" + address + ", date=" + date + ", total=" + total + ", orderStatus=" + orderStatus + ", notes=" + notes + '}';
    }

       
}