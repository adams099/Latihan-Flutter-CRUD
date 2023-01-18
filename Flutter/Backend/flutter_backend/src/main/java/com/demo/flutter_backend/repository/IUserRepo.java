package com.demo.flutter_backend.repository;

import java.util.List;

import com.demo.flutter_backend.model.User;

public interface IUserRepo {
    public User insertUser(User user);

    public List<User> getAllUser();

    public User deleteUser(int id);

    public User getUserById(int id);

    public User updateUser(int id, User user);
}
