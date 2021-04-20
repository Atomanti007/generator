package hu.kzsolt.storesync..service;

import hu.kzsolt.storesync..dto.StatusDto;
import hu.kzsolt.storesync.common.feign.FeignConfig;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

@FeignClient(name = "demoExample", url = "${url.demo}", configuration = {FeignConfig.class})
public interface ExampleRest {

    @GetMapping("status")
    public StatusDto status();
}
