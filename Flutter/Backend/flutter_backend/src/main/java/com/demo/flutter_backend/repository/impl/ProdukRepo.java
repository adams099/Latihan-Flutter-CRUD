package com.demo.flutter_backend.repository.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.demo.flutter_backend.model.Produk;
import com.demo.flutter_backend.repository.IProdukRepo;

@Repository
public class ProdukRepo implements IProdukRepo {
    @Autowired
    JdbcTemplate jdbcTemplate;

    @Override
    public Produk insertProduk(Produk produk) {
        String query = "INSERT INTO tb_produk(nama, harga, qty) "
                + "VALUES(?, ?, ?)";
        jdbcTemplate.update(query, new Object[] { produk.getNama(), produk.getHarga(), produk.getQty() });
        return produk;
    }

    @Override
    public List<Produk> getAllProduk() {
        String query = "SELECT * FROM tb_produk ORDER BY nama ASC";
        return jdbcTemplate.query(query, new BeanPropertyRowMapper<>(Produk.class));
    }
}
