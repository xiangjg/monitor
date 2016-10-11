package com.fh.entity.henxin;

public class Report {
    private Integer id;

    private Integer type;

    private String address;

    private String bank;

    private String client;

    private String createDate;

    private String userId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getBank() {
        return bank;
    }

    public void setBank(String bank) {
        this.bank = bank == null ? null : bank.trim();
    }

    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client == null ? null : client.trim();
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate == null ? null : createDate.trim();
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    @Override
    public String toString() {
        return "Report{" +
                "id=" + id +
                ", type=" + type +
                ", address='" + address + '\'' +
                ", bank='" + bank + '\'' +
                ", client='" + client + '\'' +
                ", createDate='" + createDate + '\'' +
                ", userId='" + userId + '\'' +
                '}';
    }
}