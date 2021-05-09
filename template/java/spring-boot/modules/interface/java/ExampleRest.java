package {{CLASS_PACKAGE}}.service;

import {{CLASS_PACKAGE}}.dto.ExampleDto;
import hu.kzsolt.storesync.common.feign.FeignConfig;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

@FeignClient(name = "{{CAMEL_NAME}}", url = "${url.{{NAME}}}", configuration = {FeignConfig.class})
public interface ExampleRest {

    @GetMapping("/check")
    ExampleDto check();
}
