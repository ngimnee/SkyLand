package com.ngimnee.converter.blog;

import com.ngimnee.entity.BlogEntity;
import com.ngimnee.model.dto.BlogDTO;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class BlogConverter {
    @Autowired
    private ModelMapper modelMapper;

    public BlogEntity toBlogEntity(BlogDTO blogDTO) {
        return modelMapper.map(blogDTO, BlogEntity.class);
    }

    public BlogDTO toBlogDTO(BlogEntity blogEntity) {
        return modelMapper.map(blogEntity, BlogDTO.class);
    }

    public void updateEntityFromDTO(BlogDTO blogDTO, BlogEntity blogEntity) {
        modelMapper.getConfiguration().setPropertyCondition(context -> context.getSource() != null);
        modelMapper.map(blogDTO, blogEntity);
    }
}
