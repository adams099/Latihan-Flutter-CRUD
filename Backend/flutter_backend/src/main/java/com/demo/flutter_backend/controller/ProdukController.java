package com.demo.flutter_backend.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.demo.flutter_backend.model.Produk;
import com.demo.flutter_backend.service.IProdukService;

@RestController
@CrossOrigin(origins = "http://localhost:8080")
@RequestMapping("/api/produk")
public class ProdukController {
    @Autowired
    IProdukService produkService;

    @PostMapping("/insert")
    public Produk insertProduk(@RequestBody Produk produk) {
        return produkService.insertProduk(produk);
    }

    @GetMapping("/getAll")
    public List<Produk> getAllProduk() {
        return produkService.getAllProduk();
    }
}
