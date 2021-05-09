package {{CLASS_PACKAGE}}.rest;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;


@SpringBootApplication
@EntityScan("{{CLASS_PACKAGE}}.entity")
@EnableJpaRepositories("{{CLASS_PACKAGE}}.repository")
@ComponentScan({"{{CLASS_PACKAGE}}", "hu.kzsolt.storesync.common"})
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
