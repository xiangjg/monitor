package com.fh.entity.henxin;

import java.io.Serializable;

/**
 * Created by 向敬光 on 2016/10/10.
 */
public class Content implements Serializable {
    private int contentId;
    private String contentName;
    private String contentType;
    private String docType;
    private String path;
    private String refTable;
    private String refFiled;
    private String refValue;
    private String fileSize;

    public int getContentId() {
        return contentId;
    }

    public void setContentId(int contentId) {
        this.contentId = contentId;
    }

    public String getContentName() {
        return contentName;
    }

    public void setContentName(String contentName) {
        this.contentName = contentName;
    }

    public String getContentType() {
        return contentType;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }

    public String getDocType() {
        return docType;
    }

    public void setDocType(String docType) {
        this.docType = docType;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getRefTable() {
        return refTable;
    }

    public void setRefTable(String refTable) {
        this.refTable = refTable;
    }

    public String getRefFiled() {
        return refFiled;
    }

    public void setRefFiled(String refFiled) {
        this.refFiled = refFiled;
    }

    public String getRefValue() {
        return refValue;
    }

    public void setRefValue(String refValue) {
        this.refValue = refValue;
    }

    public String getFileSize() {
        return fileSize;
    }

    public void setFileSize(String fileSize) {
        this.fileSize = fileSize;
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
                '}';
    }
}
