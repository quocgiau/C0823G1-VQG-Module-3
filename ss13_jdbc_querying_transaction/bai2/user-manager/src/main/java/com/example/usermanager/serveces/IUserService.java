package com.example.usermanager.serveces;

import com.example.usermanager.models.User;

import java.util.List;

public interface IUserService {
    List<User> getList();
    void add(User user);
    void edit(User user);
    void delete(int id);
}
