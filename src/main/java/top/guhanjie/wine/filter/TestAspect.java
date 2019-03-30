package top.guhanjie.wine.filter;

import java.util.Date;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class TestAspect {
    @Pointcut("execution(public * top.guhanjie.wine.service.RushItemService.get*(..))")
    private void aopTest() {}

//    @Before("aopTest()")
//    public void before(JoinPoint jp) {
//        System.out.println("调用方法前拦截" + new Date().getTime());
//        System.out.println("调用方法名称：" + jp.getSignature().getName());
//        System.out.println("调用方法参数：" + jp.getArgs());
////        throw new RuntimeException("run error....");
//    }
//
//    @AfterReturning("aopTest()")
//    public void afterReturn() {
//        System.out.println();
//        System.out.println("调用方法之后拦截" + new Date().getTime());
//    }

    @Around(value="aopTest() && args(itemId)", argNames="itemId")
    public void around(ProceedingJoinPoint pjp, Integer itemId) {
        System.out.println("调用方法之前的环绕拦截, ItemId:" + itemId);
        try {
            pjp.proceed();
        } catch (Throwable e) {
            e.printStackTrace();
        }
        System.out.println("调用方法之后的环绕拦截" + new Date().getTime());
    }

    @AfterThrowing(pointcut="aopTest()", throwing="ex")
    public void throwing(RuntimeException ex) {
        System.out.println("调用中的异常拦截" + new Date().getTime());
        System.err.println(ex);
    }

    @After("aopTest()")
    public void after() {
        System.out.println();
        System.out.println("调用方法final拦截" + new Date().getTime());
    }

}
