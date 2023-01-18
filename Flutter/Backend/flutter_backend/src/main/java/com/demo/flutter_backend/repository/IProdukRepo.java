package com.demo.flutter_backend.repository;

import java.util.List;

import com.demo.flutter_backend.model.Produk;

public interface IProdukRepo {
    public Produk insertProduk(Produk produk);

    public List<Produk> getAllProduk();
}
