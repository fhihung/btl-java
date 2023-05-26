package com.example.lib_manage.Borrower;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BorrowerRepository extends JpaRepository<Borrower, Long> {
    List<Borrower> findByFullNameContainingIgnoreCase(String fullName);
    List<Borrower> findByIDContainingIgnoreCase(Long id);
    List<Borrower> findByPhoneNumberContainingIgnoreCase(String phoneNumber);
    List<Borrower> findByEmailContainingIgnoreCase(String email);
}