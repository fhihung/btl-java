package com.example.lib_manage.Borrower;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDate;

@RestController
@RequestMapping("/borrowers")
public class BorrowerController {
    @Autowired
    private BorrowerRepository BorrowerRepository;

    @PostMapping
    public Borrower addBorrower(@RequestBody Borrower borrower) {
        return BorrowerRepository.save(borrower);
    }
    @GetMapping("/{id}")//hien thongtin voi muc tim kiem id
    public Borrower getBorrowerById(@PathVariable Long id) {
        return BorrowerRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));
    }
    @DeleteMapping("/delete/{id}")//xoa
    public void deleteBorrower(@PathVariable Long id) {
        Borrower borrower = BorrowerRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Borrower not found"));
        BorrowerRepository.delete(borrower);
    }
    @PutMapping("/{id}/fullName/{fullName}")
    public Borrower updateBorrowerFullName(@PathVariable Long id, @PathVariable String fullName) {
        Borrower borrower = BorrowerRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));

        borrower.setFullName(fullName);
        return BorrowerRepository.save(borrower);
    }
    @PutMapping("/{id}/address/{address}")
    public Borrower updateBorrowerAddress(@PathVariable Long id, @PathVariable String address) {
        Borrower borrower = BorrowerRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));

        borrower.setAddress(address);
        return BorrowerRepository.save(borrower);
    }
    @PutMapping("/{id}/phoneNumber/{phoneNumber}")
    public Borrower updateBorrowerPhoneNumber(@PathVariable Long id, @PathVariable String phoneNumber) {
        Borrower borrower = BorrowerRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));

        borrower.setPhoneNumber(phoneNumber);
        return BorrowerRepository.save(borrower);
    }
    @PutMapping("/{id}/email/{email}")
    public Borrower updateBorrowerEmail(@PathVariable Long id, @PathVariable String email) {
        Borrower borrower = BorrowerRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));

        borrower.setEmail(email);
        return BorrowerRepository.save(borrower);
    }
    @PutMapping("/{id}/cardExpirationDate/{cardExpirationDate}")
    public Borrower updateCardExpirationDate(@PathVariable Long id, @PathVariable LocalDate cardExpirationDate) {
        Borrower borrower = BorrowerRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));

        borrower.setCardExpirationDate(cardExpirationDate);
        return BorrowerRepository.save(borrower);
    }
}
