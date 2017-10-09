package top.guhanjie.wine.model;

import static org.junit.Assert.*;

import java.math.BigDecimal;

import org.junit.Test;

/**
 * Created by guhanjie on 2017-10-09.
 */
public class TestOrder {

    @Test
    public void test() {
        Order order = new Order();
        BigDecimal amount = new BigDecimal(18.90);
        order.setPayAmount(amount);
        System.out.println("amount="+order.getPayAmount());
        System.out.println("scale="+order.getPayAmount().scale());
        System.out.println("precision="+order.getPayAmount().precision());
        System.out.println("unscaleValue="+order.getPayAmount().unscaledValue());
        System.out.println("round_half="+order.getPayAmount().setScale(1, BigDecimal.ROUND_HALF_DOWN));
        System.out.println("double="+order.getPayAmount().doubleValue()*100);
        System.out.println("int="+(int)(order.getPayAmount().doubleValue()*100));
        System.out.println(order.getPayAmount().multiply(new BigDecimal(100)).setScale(0, BigDecimal.ROUND_HALF_DOWN).intValue());
    }

}
