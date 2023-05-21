//package com.example.lib_manage.Book;
//
//import jakarta.persistence.*;
//
//import java.time.LocalDate;
//
//@Entity
//@Table(name = "borrowers")
//public class Borrower {
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private Long id;
//
//    @Column(nullable = false)
//    private String fullName;
//
//    @Column(nullable = false)
//    private String address;
//
//    @Column(nullable = false)
//    private String phoneNumber;
//
//    @Column(nullable = false)
//    private String email;
//
//    @Column(nullable = false)
//    private LocalDate cardExpirationDate;
//
//    @Column(nullable = false)
//    private int numberOfBooksBorrowed;
//
//    // Getters and setters
//}