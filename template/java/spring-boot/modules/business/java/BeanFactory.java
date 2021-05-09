package {{CLASS_PACKAGE}}.config;

import {{CLASS_PACKAGE}}.mapper.ExampleMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


@Configuration
public class BeanFactory {
    @Bean
    public ExampleMapper getExampleMapper() {
        return ExampleMapper.INSTANCE;
    }
}
