package hu.kzsolt.storesync.cacheman.downloader.service;

import hu.kzsolt.storesync.cacheman.downloader.dto.StatusDto;
import hu.kzsolt.storesync.common.feign.FeignConfig;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

@FeignClient(name = "cacheman-downloaderExample", url = "${url.cacheman-downloader}", configuration = {FeignConfig.class})
public interface ExampleRest {

    @GetMapping("status")
    public StatusDto status();
}
