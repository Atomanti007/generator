package {{CLASS_PACKAGE}}.controller;

import {{CLASS_PACKAGE}}.dto.ExampleDto;
import {{CLASS_PACKAGE}}.entity.ExampleEntity;
import {{CLASS_PACKAGE}}.mapper.ExampleMapper;
import {{CLASS_PACKAGE}}.repository.ExampleRepository;
import {{CLASS_PACKAGE}}.service.ExampleRest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RestController;


@Slf4j
@RestController
public class ExampleController implements ExampleRest {

    private ExampleMapper exampleMapper;
    private ExampleRepository exampleRepository;

    public ExampleController(ExampleMapper exampleMapper, ExampleRepository exampleRepository) {
        this.exampleMapper = exampleMapper;
        this.exampleRepository = exampleRepository;
    }

    @Override
    public ExampleDto check() {
        ExampleEntity exampleEntity = new ExampleEntity();
        exampleEntity.setStatus("OK");

        ExampleEntity result = exampleRepository.findById(1L)
            .orElse(exampleEntity);

        return exampleMapper.entityToDto(result);
    }
}
