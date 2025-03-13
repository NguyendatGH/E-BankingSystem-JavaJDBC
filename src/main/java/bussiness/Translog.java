/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bussiness;

import java.time.LocalDateTime;
import java.util.Date;

/**
 *
 * @author rio
 */
public class Translog {
    private int accNo;
    private int logID;
    private LocalDateTime time;
    private String task;
    private double amount;
    private double posBalance;

    public Translog() {
    }

    public Translog(int accNo, int logID, LocalDateTime time, String task, double amount, double posBalance) {
        this.accNo = accNo;
        this.logID = logID;
        this.time = time;
        this.task = task;
        this.amount = amount;
        this.posBalance = posBalance;
    }

    public int getAccNo() {
        return accNo;
    }

    public int getLogID() {
        return logID;
    }

    public LocalDateTime getTime() {
        return time;
    }

    public String getTask() {
        return task;
    }

    public double getAmount() {
        return amount;
    }

    public double getPosBalance() {
        return posBalance;
    }

    public void setAccNo(int accNo) {
        this.accNo = accNo;
    }

    public void setLogID(int logID) {
        this.logID = logID;
    }

    public void setTime(LocalDateTime time) {
        this.time = time;
    }

    public void setTask(String task) {
        this.task = task;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public void setPosBalance(double posBalance) {
        this.posBalance = posBalance;
    }

    @Override
    public String toString() {
        return "Translog{" + "accNo=" + accNo + ", logID=" + logID + ", time=" + time + ", task=" + task + ", amount=" + amount + ", posBalance=" + posBalance + '}';
    }
    
}
