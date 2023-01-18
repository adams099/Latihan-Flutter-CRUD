package com.demo.flutter_backend.service;

import java.util.List;

import com.demo.flutter_backend.model.Produk;

public interface IProdukService {
    public Produk insertProduk(Produk produk);

    public List<Produk> getAllProduk();
}
