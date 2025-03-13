/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bussiness;

import java.time.LocalDateTime;


/**
 *
 * @author rio
 */
public class Account {

    private int custNo;
    private int accNo;
    private double balance;
    private String password;
    private LocalDateTime lastAccess;

    public Account() {
    }
    
     public Account(int custNo, double balance, String password, LocalDateTime lastAccess) {
        this.custNo = custNo;
        this.balance = balance;
        this.password = password;
        this.lastAccess = lastAccess;
    }

    public Account(int custNo, int accNo, double balance, String password, LocalDateTime lastAccess) {
        this.custNo = custNo;
        this.accNo = accNo;
        this.balance = balance;
        this.password = password;
        this.lastAccess = lastAccess;
    }

    public int getCustNo() {
        return custNo;
    }

    public int getAccNo() {
        return accNo;
    }

    public double getBalance() {
        return balance;
    }

    public String getPassword() {
        return password;
    }

    public LocalDateTime getLastAccess() {
        return lastAccess;
    }

    public void setCustNo(int custNo) {
        this.custNo = custNo;
    }

    public void setAccNo(int accNo) {
        this.accNo = accNo;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setLastAccess(LocalDateTime lastAccess) {
        this.lastAccess = lastAccess;
    }

    @Override
    public String toString() {
        return "Account{" + "custNo=" + custNo + ", accNo=" + accNo + ", balance=" + balance + ", password=" + password + ", lastAccess=" + lastAccess + '}';
    }

}
