package com.jone.test;

import org.junit.Test;

import java.math.BigInteger;

/**
 * Created by 向敬光 on 2016/8/29.
 */
public class TestBit {

    @Test
    public void test(){
        //初始
        BigInteger num = new BigInteger("0");
        num = num.setBit(2);
        num = num.setBit(1);
        System.out.println(num);
        System.out.println(num.testBit(2));
        System.out.println(num.testBit(1));
        System.out.println(num.testBit(3));
        num.clearBit(2);
        System.out.println(num.testBit(1));
    }
}
