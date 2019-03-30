package top.guhanjie.wine.util;

import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;

public class CustomPropertyPlaceHolder extends PropertyPlaceholderConfigurer {
    private static final Logger logger = LoggerFactory
            .getLogger(CustomPropertyPlaceHolder.class);

    @Override
    protected String resolvePlaceholder(String placeholder, Properties props) {
        logger.warn("=========placeholder = "+ placeholder);
        String val =  props.getProperty(placeholder);
        logger.warn("=========val = "+ val);
        return val;
    }
//    protected void processProperties(ConfigurableListableBeanFactory beanFactoryToProcess,
//            final ConfigurablePropertyResolver propertyResolver) throws BeansException {
//
//        propertyResolver.setPlaceholderPrefix(this.placeholderPrefix);
//        propertyResolver.setPlaceholderSuffix(this.placeholderSuffix);
//        propertyResolver.setValueSeparator(this.valueSeparator);
//
//        StringValueResolver valueResolver = new StringValueResolver() {
//            @Override
//            public String resolveStringValue(String strVal) {
//                String resolved = ignoreUnresolvablePlaceholders ?
//                        propertyResolver.resolvePlaceholders(strVal) :
//                        propertyResolver.resolveRequiredPlaceholders(strVal);
//                logger.warn("========Original Property Value = " + resolved);
//                String value = (resolved.equals(nullValue) ? null : resolved);
//                logger.warn("========Resolved Property Value = " + value);
//                return value;
//            }
//        };
//
//        doProcessProperties(beanFactoryToProcess, valueResolver);
//    }

    // @Autowired
    // private Cryptograph cryptograph;
    //
    // @Override
    // protected String resolvePlaceholder(String placeholder, Properties props)
    // {
    // logger.warn("===placeholder key: "+placeholder);
    // String val = props.getProperty(placeholder);
    // //如果是从KC加密过的密文，则调用KC API，解密出明文
    // if(val.startsWith("$$")) {
    // val = val.substring(2);
    // val = cryptograph.decrypt(val,"nas-yaochi");
    // }
    // logger.warn("===return val: "+val);
    // return val;
    // }
}