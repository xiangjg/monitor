package com.fh.entity.henxin;

import java.io.Serializable;

/**
 * Created by 向敬光 on 2016/10/10.
 */
public class Report implements Serializable{
    private int id;
    private int type;
    private String address;
    private String bank;
    private String client;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getBank() {
        return bank;
    }

    public void setBank(String bank) {
        this.bank = bank;
    }

    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }

    @Override
    public String toString() {
        return "Report{" +
                "id=" + id +
                ", type=" + type +
                ", address='" + address + '\'' +
                ", bank='" + bank + '\'' +
                ", client='" + client + '\'' +
                '}';
    }
}
