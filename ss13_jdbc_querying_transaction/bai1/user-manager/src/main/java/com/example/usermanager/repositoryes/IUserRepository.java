package com.example.usermanager.repositoryes;

import com.example.usermanager.models.User;

import java.sql.SQLException;
import java.util.List;

public interface IUserRepository {
    List<User> getList();
    void add(User user);
    void edit(User user);
    void delete(int id);

}
