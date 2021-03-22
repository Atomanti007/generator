package hu.kzsolt.storesync.{{package}}.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

/**
 * @author Kulifay Zsolt
 * Created at 2020. 11. 09.
 */
@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class StatusDto {
    private String status;
}
