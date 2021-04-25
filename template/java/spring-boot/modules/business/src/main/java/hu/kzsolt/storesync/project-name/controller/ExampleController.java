package {{package}}.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author Kulifay Zsolt
 * Created at 2021. 03. 22.
 */
@Slf4j
@RestController
public class ExampleController {

    @GetMapping("status")
    public String status() {
        return "OK";
    }
}
