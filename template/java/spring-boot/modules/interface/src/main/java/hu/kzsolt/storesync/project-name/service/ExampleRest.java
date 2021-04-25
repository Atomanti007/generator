package {{package}}.service;

import {{package}}.dto.StatusDto;
import hu.kzsolt.storesync.common.feign.FeignConfig;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

@FeignClient(name = "{{NAME}}Example", url = "${url.{{NAME}}}", configuration = {FeignConfig.class})
public interface ExampleRest {

    @GetMapping("status")
    public StatusDto status();
}
