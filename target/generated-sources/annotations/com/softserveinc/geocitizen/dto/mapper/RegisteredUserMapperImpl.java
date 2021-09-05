package com.softserveinc.geocitizen.dto.mapper;

import com.softserveinc.geocitizen.dto.RegisteredUserDTO;
import com.softserveinc.geocitizen.entity.User;
import javax.annotation.Generated;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2021-08-31T20:34:08+0300",
    comments = "version: 1.2.0.Final, compiler: javac, environment: Java 11.0.12 (Red Hat, Inc.)"
)
@Component
public class RegisteredUserMapperImpl implements RegisteredUserMapper {

    @Override
    public RegisteredUserDTO userToRegisteredUserDto(User user) {
        if ( user == null ) {
            return null;
        }

        RegisteredUserDTO registeredUserDTO = new RegisteredUserDTO();

        registeredUserDTO.setLogin( user.getLogin() );
        if ( user.getId() != null ) {
            registeredUserDTO.setId( user.getId() );
        }

        return registeredUserDTO;
    }
}
