package com.jone.test;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Created by 向敬光 on 2017-01-11.
 */
public class TaskTest {
    public static void main(String[] args) {
        ApplicationContext context = new ClassPathXmlApplicationContext("classpath:/spring/ApplicationContext-task.xml");
    }
}
