package {{CLASS_PACKAGE}}.mapper;

import hu.kzsolt.storesync.common.mapping.MappingBase;
import {{CLASS_PACKAGE}}.dto.ExampleDto;
import {{CLASS_PACKAGE}}.entity.ExampleEntity;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;



@Mapper
public interface ExampleMapper extends MappingBase<ExampleDto, ExampleEntity> {

    ExampleMapper INSTANCE = Mappers.getMapper(ExampleMapper.class);
}
