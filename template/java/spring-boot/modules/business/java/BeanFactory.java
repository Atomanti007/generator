package {{CLASS_PACKAGE}}.config;

{{#IS_DB}}
import {{CLASS_PACKAGE}}.mapper.ExampleMapper;
{{/IS_DB}}
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


@Configuration
public class BeanFactory {
    {{#IS_DB}}
    @Bean
    public ExampleMapper getExampleMapper() {
        return ExampleMapper.INSTANCE;
    }
    {{/IS_DB}}
}
