package hu.kzsolt.storesync.{{package}}.rest;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;


@SpringBootApplication
@EntityScan("hu.kzsolt.storesync.{{package}}.entity")
@EnableJpaRepositories("hu.kzsolt.storesync.{{package}}.repository")
@ComponentScan({"hu.kzsolt.storesync.{{package}}","hu.kzsolt.storesync.common"})
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
