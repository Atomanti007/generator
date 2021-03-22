package hu.kzsolt.storesync.{{package}}.service;

import hu.kzsolt.storesync.{{package}}.dto.StatusDto;
import hu.kzsolt.storesync.common.feign.FeignConfig;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

@FeignClient(name = "{{name}}Example", url = "${url.{{name}}}", configuration = {FeignConfig.class})
public interface ExampleRest {

    @GetMapping("status")
    public StatusDto status();
}
