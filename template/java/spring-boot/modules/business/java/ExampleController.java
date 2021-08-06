package {{CLASS_PACKAGE}}.controller;

{{#IS_DB}}
import {{CLASS_PACKAGE}}.entity.ExampleEntity;
import {{CLASS_PACKAGE}}.repository.ExampleRepository;
import {{CLASS_PACKAGE}}.mapper.ExampleMapper;
{{/IS_DB}}
import {{CLASS_PACKAGE}}.dto.ExampleDto;
import {{CLASS_PACKAGE}}.service.ExampleRest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RestController;


@Slf4j
@RestController
public class ExampleController implements ExampleRest {

    {{#IS_DB}}
    private ExampleMapper exampleMapper;
    private ExampleRepository exampleRepository;

    public ExampleController(ExampleMapper exampleMapper, ExampleRepository exampleRepository) {
        this.exampleMapper = exampleMapper;
        this.exampleRepository = exampleRepository;
    }
    {{/IS_DB}}

    @Override
    public ExampleDto check() {
        {{#IS_DB}}
        ExampleEntity exampleEntity = new ExampleEntity();
        exampleEntity.setStatus("OK");

        ExampleEntity result = exampleRepository.findById(1L)
            .orElse(exampleEntity);

        return exampleMapper.entityToDto(result);
        {{/IS_DB}}
        {{^IS_DB}}
        return new ExampleDto("OK");
        {{/IS_DB}}
    }
}
