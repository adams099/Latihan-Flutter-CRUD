package com.demo.flutter_backend.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.flutter_backend.model.User;
import com.demo.flutter_backend.repository.IUserRepo;
import com.demo.flutter_backend.service.IUserService;

@Service
public class UserService implements IUserService {
    @Autowired
    IUserRepo userRepository;

    @Override
    public User insertUser(User user) {
        return userRepository.insertUser(user);
    }

    @Override
    public List<User> getAllUser() {
        return userRepository.getAllUser();
    }

    @Override
    public User deleteUser(int id) {
        return userRepository.deleteUser(id);
    }

    @Override
    public User getUserById(int id) {
        return userRepository.getUserById(id);
    }

    @Override
    public User updateUser(int id, User user) {
        return userRepository.updateUser(id, user);
    }
}
