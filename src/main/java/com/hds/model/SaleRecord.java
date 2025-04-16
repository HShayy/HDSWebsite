package com.hds.model;

import java.sql.Date;

public class SaleRecord {
    private int saleId;
    private double saleAmount;
    private Date saleDate;
    
    public SaleRecord(int saleId, double saleAmount, Date saleDate) {
        this.saleId = saleId;
        this.saleAmount = saleAmount;
        this.saleDate = saleDate;
    }
    
    public int getSaleId() {
        return saleId;
    }
    
    public double getSaleAmount() {
        return saleAmount;
    }
    
    public Date getSaleDate() {
        return saleDate;
    }
}
