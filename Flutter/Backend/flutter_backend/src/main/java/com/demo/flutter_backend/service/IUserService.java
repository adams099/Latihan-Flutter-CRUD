package com.demo.flutter_backend.service;

import java.util.List;

import com.demo.flutter_backend.model.User;

public interface IUserService {
    public User insertUser(User user);

    public List<User> getAllUser();

    public User deleteUser(int id);

    public User getUserById(int id);

    public User updateUser(int id, User user);
}
