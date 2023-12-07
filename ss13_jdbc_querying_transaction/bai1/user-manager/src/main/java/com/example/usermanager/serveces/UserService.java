package com.example.usermanager.serveces;

import com.example.usermanager.models.User;
import com.example.usermanager.repositoryes.IUserRepository;
import com.example.usermanager.repositoryes.UserRepository;

import java.util.List;

public class UserService implements IUserService {
    private static IUserRepository repository = new UserRepository();
    @Override
    public List<User> getList() {
        return repository.getList();
    }

    @Override
    public void add(User user) {
        repository.add(user);
    }

    @Override
    public void edit(User user) {
        repository.edit(user);
    }

    @Override
    public void delete(int id) {
        repository.delete(id);
    }
}
