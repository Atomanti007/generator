package {{CLASS_PACKAGE}}.repository;

import {{CLASS_PACKAGE}}.entity.ExampleEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface ExampleRepository extends JpaRepository<ExampleEntity, Long> {

}
