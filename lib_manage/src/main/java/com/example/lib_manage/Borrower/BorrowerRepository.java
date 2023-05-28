package com.example.lib_manage.Borrower;


import com.example.lib_manage.Book.Book;
import com.example.lib_manage.Borrow.Borrow;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BorrowerRepository extends JpaRepository<Borrower, Long> {
    List<Borrower> findByFullNameContainingIgnoreCase(String name);
    List<Borrower> findByAddressContainingIgnoreCase(String address);
    List<Borrower> findByEmailContainingIgnoreCase(String email);

    List<Borrower> findByPhoneNumberContainingIgnoreCase(String phone);
}