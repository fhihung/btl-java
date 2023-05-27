package com.example.lib_manage.Borrower;

//package com.example.lib_manage.Book;

import com.example.lib_manage.Borrow.Borrow;
import jakarta.persistence.*;

import java.util.List;


@Entity
@Table(name = "borrowers")
public class Borrower {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String fullName;

    @Column(nullable = false)
    private String address;

    @Column(nullable = false)
    private String phoneNumber;

    @Column(nullable = false)
    private String email;

//    @OneToMany(mappedBy = "borrower", fetch = FetchType.LAZY)
//    private List<Borrow> borrows;
//
//    public List<Borrow> getBorrows() {
//        return borrows;
//    }
//
//    public void setBorrows(List<Borrow> borrows) {
//        this.borrows = borrows;
//    }
// Getters and setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

}