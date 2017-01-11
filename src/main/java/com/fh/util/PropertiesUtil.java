package com.fh.util;

import java.util.Properties;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

/**
 * 读取properties文件的工具类
 * Created by 向敬光 on 2017-01-11.
 */
public class PropertiesUtil {
    private String fileName;

    public PropertiesUtil(String fileName) {
        this.fileName = fileName;
    }

    public String readProperty(String name) {
        Resource res = new ClassPathResource(fileName);
        Properties p = new Properties();
        try {
            p.load(res.getInputStream());
            // System.out.println(p.getProperty(name));
        } catch (Exception e) {
            e.printStackTrace();
        }

        return p.getProperty(name);

    }
}
