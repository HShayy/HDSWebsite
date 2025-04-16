package com.hds.model;

import java.sql.Date;

public class Order {
    private int saleId;
    private double quantity;
    private double totalCost;
    private Date saleDate;
    private String serial;
    private int customerId;
    
    public Order(int saleId, double quantity, double totalCost, Date saleDate, String serial, int customerId) {
        this.saleId = saleId;
        this.quantity = quantity;
        this.totalCost = totalCost;
        this.saleDate = saleDate;
        this.serial = serial;
        this.customerId = customerId;
    }
    
    public int getSaleId() { return saleId; }
    public double getQuantity() { return quantity; }
    public double getTotalCost() { return totalCost; }
    public Date getSaleDate() { return saleDate; }
    public String getSerial() { return serial; }
    public int getCustomerId() { return customerId; }
}

