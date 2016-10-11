package com.fh.entity.henxin;

public class Content {
    private Integer contentId;

    private String contentName;

    private String contentType;

    private String docType;

    private String path;

    private String refTable;

    private String refFiled;

    private String refValue;

    private String fileSize;

    private String createDate;

    private String userId;

    public Integer getContentId() {
        return contentId;
    }

    public void setContentId(Integer contentId) {
        this.contentId = contentId;
    }

    public String getContentName() {
        return contentName;
    }

    public void setContentName(String contentName) {
        this.contentName = contentName == null ? null : contentName.trim();
    }

    public String getContentType() {
        return contentType;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType == null ? null : contentType.trim();
    }

    public String getDocType() {
        return docType;
    }

    public void setDocType(String docType) {
        this.docType = docType == null ? null : docType.trim();
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path == null ? null : path.trim();
    }

    public String getRefTable() {
        return refTable;
    }

    public void setRefTable(String refTable) {
        this.refTable = refTable == null ? null : refTable.trim();
    }

    public String getRefFiled() {
        return refFiled;
    }

    public void setRefFiled(String refFiled) {
        this.refFiled = refFiled == null ? null : refFiled.trim();
    }

    public String getRefValue() {
        return refValue;
    }

    public void setRefValue(String refValue) {
        this.refValue = refValue == null ? null : refValue.trim();
    }

    public String getFileSize() {
        return fileSize;
    }

    public void setFileSize(String fileSize) {
        this.fileSize = fileSize == null ? null : fileSize.trim();
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
        return "Content{" +
                "contentId=" + contentId +
                ", contentName='" + contentName + '\'' +
                ", contentType='" + contentType + '\'' +
                ", docType='" + docType + '\'' +
                ", path='" + path + '\'' +
                ", refTable='" + refTable + '\'' +
                ", refFiled='" + refFiled + '\'' +
                ", refValue='" + refValue + '\'' +
                ", fileSize='" + fileSize + '\'' +
                ", createDate='" + createDate + '\'' +
                ", userId='" + userId + '\'' +
                '}';
    }
}