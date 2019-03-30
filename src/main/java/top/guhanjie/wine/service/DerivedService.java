package top.guhanjie.wine.service;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;

@Service
public class DerivedService extends AbstractService implements InitializingBean {

    @PostConstruct
    public void init() {
        System.err.println("=======PostConstruct");
        System.err.println("=======PostConstruct------categoryService"+categoryService);

        System.out.println("---------\n"+JSON.toJSONString(categoryService.listCategory(), true));
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        System.err.println("=======afterPropertiesSet");
        System.err.println("=======afterPropertiesSet------categoryService"+categoryService);
    }

}
