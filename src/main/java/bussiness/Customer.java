/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package bussiness;

/**
 *
 * @author rio
 */
public class Customer {

    private int custNo;
    private String custFname;
    private String custLname;
    private int idNo;
    private String Tel;
    private String address;
    private String email;
    private byte[] photo;

    public Customer() {
    }

    public Customer(int custNo, String custFname, String custLname, int idNo, String Tel, String address, String email, byte[] photo) {
        this.custNo = custNo;
        this.custFname = custFname;
        this.custLname = custLname;
        this.idNo = idNo;
        this.Tel = Tel;
        this.address = address;
        this.email = email;
        this.photo = photo;
    }
     public Customer(String custFname, String custLname, int idNo, String Tel, String address, String email, byte[] photo) {
        this.custFname = custFname;
        this.custLname = custLname;
        this.idNo = idNo;
        this.Tel = Tel;
        this.address = address;
        this.email = email;
        this.photo = photo;
    }

    public int getCustNo() {
        return custNo;
    }

    public String getCustFname() {
        return custFname;
    }

    public String getCustLname() {
        return custLname;
    }

    public int getIdNo() {
        return idNo;
    }

    public String getTel() {
        return Tel;
    }

    public String getAddress() {
        return address;
    }

    public String getEmail() {
        return email;
    }

    public byte[] getPhoto() {
        return photo;
    }

    public void setCustNo(int custNo) {
        this.custNo = custNo;
    }

    public void setCustFname(String custFname) {
        this.custFname = custFname;
    }

    public void setCustLname(String custLname) {
        this.custLname = custLname;
    }

    public void setIdNo(int idNo) {
        this.idNo = idNo;
    }

    public void setTel(String Tel) {
        this.Tel = Tel;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPhoto(byte[] photo) {
        this.photo = photo;
    }
    
    public String getPhotoBase64() {
        if (photo != null) {
            return java.util.Base64.getEncoder().encodeToString(photo);
        }
        return null;
    }
    @Override
    public String toString() {
        return "Customer{" + "custNo=" + custNo + ", custFname=" + custFname + ", custLname=" + custLname + ", idNo=" + idNo + ", Tel=" + Tel + ", address=" + address + ", email=" + email + ", photo=" + photo + '}';
    }

}
