package com.demo.flutter_backend.repository.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.demo.flutter_backend.model.User;
import com.demo.flutter_backend.repository.IUserRepo;

@Repository
public class UserRepo implements IUserRepo {
    @Autowired
    JdbcTemplate jdbcTemplate;

    @Override
    public User insertUser(User user) {
        String query = "INSERT INTO tb_user(email, nama, password, gender) "
                + "VALUES(?, ?, ?, ?)";
        jdbcTemplate.update(query,
                new Object[] { user.getEmail(), user.getNama(), user.getPassword(), user.getGender() });
        return user;
    }

    @Override
    public List<User> getAllUser() {
        String query = "SELECT * FROM tb_user";
        return jdbcTemplate.query(query, new BeanPropertyRowMapper<>(User.class));
    }

    @Override
    public User deleteUser(int id) {
        String query = "SELECT * FROM tb_user WHERE id = ?";
        var result = jdbcTemplate.queryForObject(query, new BeanPropertyRowMapper<>(User.class), id);

        query = "DELETE FROM tb_user WHERE id = ?";
        jdbcTemplate.update(query, id);

        return result;
    }

    @Override
    public User getUserById(int id) {
        String query = "SELECT * FROM tb_user WHERE id = ?";
        return jdbcTemplate.queryForObject(query, new BeanPropertyRowMapper<>(User.class), id);
    }

    @Override
    public User updateUser(int id, User user) {
        String query = "UPDATE tb_user SET email  = ?, nama  = ?, password  = ?, gender  = ? WHERE id = ?";

        jdbcTemplate.update(query,
                new Object[] { user.getEmail(), user.getNama(), user.getPassword(), user.getGender(), id });

        return user;
    }
}
