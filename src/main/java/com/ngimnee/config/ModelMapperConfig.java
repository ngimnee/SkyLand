package com.ngimnee.config;

import com.ngimnee.entity.BuildingEntity;
import com.ngimnee.model.dto.BuildingDTO;
import org.modelmapper.ModelMapper;
import org.modelmapper.PropertyMap;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ModelMapperConfig {

    @Bean
    public ModelMapper modelMapper() {
        ModelMapper mapper = new ModelMapper();

        mapper.addMappings(new PropertyMap<BuildingDTO, BuildingEntity>() {
            @Override
            protected void configure() {
                skip(destination.getUsers());
                skip(destination.getOrder());
                skip(destination.getRentAreas());
            }
        });

        return mapper;
    }
}
