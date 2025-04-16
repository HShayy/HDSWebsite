package com.hds.model;

public class Employee {
    private int employeeId;
    private String firstName;
    private String lastName;
    
    public Employee(int employeeId, String firstName, String lastName) {
        this.employeeId = employeeId;
        this.firstName = firstName;
        this.lastName = lastName;
    }
    
    public int getEmployeeId() {
        return employeeId;
    }
    
    public String getFirstName() {
        return firstName;
    }
    
    public String getLastName() {
        return lastName;
    }
}


