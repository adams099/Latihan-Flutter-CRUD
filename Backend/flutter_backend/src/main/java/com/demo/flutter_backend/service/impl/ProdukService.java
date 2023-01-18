package com.demo.flutter_backend.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.flutter_backend.model.Produk;
import com.demo.flutter_backend.repository.IProdukRepo;
import com.demo.flutter_backend.service.IProdukService;

@Service
public class ProdukService implements IProdukService {
    @Autowired
    IProdukRepo userRepository;

    @Override
    public Produk insertProduk(Produk produk) {
        return userRepository.insertProduk(produk);
    }

    @Override
    public List<Produk> getAllProduk() {
        return userRepository.getAllProduk();
    }
}
