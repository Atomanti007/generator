package {{CLASS_PACKAGE}}.entity;

import lombok.Data;
import lombok.Generated;

import javax.persistence.*;


@Generated
@Entity
@Data
@Table(name = "EXAMPLE")
public class ExampleEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "ID", nullable = false)
    private Long id;
    @Column(name = "STATUS")
    private String status;

}



