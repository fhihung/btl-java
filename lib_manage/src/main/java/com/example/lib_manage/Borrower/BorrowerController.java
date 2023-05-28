package com.example.lib_manage.Borrower;
import com.example.lib_manage.Book.Book;
import com.example.lib_manage.Borrow.Borrow;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.List;


@RestController
@RequestMapping("/borrowers")
public class BorrowerController {
    @Autowired
    private com.example.lib_manage.Book.BookRepository BookRepository;
    @Autowired
    private BorrowerRepository BorrowerRepository;
    @GetMapping("/count") // Lay so luong nguoi muon
    public Long getBorrowerCount() {
        return BorrowerRepository.count();
    }
    @GetMapping()
    public List<Borrower> getBorrowers() {
        return BorrowerRepository.findAll();
    }
    @GetMapping("/{id}") // Lay thong tin nguoi muon theo id
    public Borrower getBorrowerById(@PathVariable Long id) {
        return BorrowerRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Borrower not found"));
    }
    @GetMapping("/search/name/{name}")
    public List<Borrower> searchBorrowersByName(@PathVariable String name) {
        return BorrowerRepository.findByFullNameContainingIgnoreCase(name);
    }

    @GetMapping("/search/address/{address}")
    public List<Borrower> searchBorrowersByAddress(@PathVariable String address) {
        return BorrowerRepository.findByAddressContainingIgnoreCase(address);
    }

    @GetMapping("/search/email/{email}")
    public List<Borrower> searchBorrowersByEmail(@PathVariable String email) {
        return BorrowerRepository.findByEmailContainingIgnoreCase(email);
    }

    @GetMapping("/search/phone/{phone}")
    public List<Borrower> searchBorrowersByPhone(@PathVariable String phone) {
        return BorrowerRepository.findByPhoneNumberContainingIgnoreCase(phone);
    }
//    @GetMapping("/search/id/{id}")
//    public List<Borrower> searchBooksByID(@PathVariable Long id) {
//        return BorrowerRepository.findByIdContainingIgnoreCase(id);
//    }
//    @GetMapping("/search/fullName/{fullName}")
//    public List<Borrower> searchBooksByFullName(@PathVariable String fullName) {
//        return BorrowerRepository.findByFullNameContainingIgnoreCase(fullName);
//    }
//    @GetMapping("/search/phoneNumber/{phoneNumber}")
//    public List<Borrower> searchBooksByPhoneNumber(@PathVariable String phoneNumber) {
//        return BorrowerRepository.findByPhoneNumberContainingIgnoreCase(phoneNumber);
//    }
//    @GetMapping("/search/email/{email}")
//    public List<Borrower> searchBooksByEmail(@PathVariable String email) {
//        return BorrowerRepository.findByEmailContainingIgnoreCase(email);
//    }
//@GetMapping("/{id}/borrowed-books")
//public List<Book> getBorrowedBooksByBorrowerId(@PathVariable Long id) {
//    Borrower borrower = BorrowerRepository.findById(id)
//            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Borrower not found"));
//
//    List<Book> borrowedBooks = new ArrayList<>();
//
//    for (Borrow borrow : borrower.getBorrows()) {
//        Book book = borrow.getBook();
//        borrowedBooks.add(book);
//    }
//
//    return borrowedBooks;
//}

    @PostMapping("/add") // Them nguoi muon
    public Borrower addBorrower(@RequestBody Borrower borrower) {
        return BorrowerRepository.save(borrower);
    }
//    @GetMapping("/{id}") // Lay thong tin nguoi muon theo id
//    public Borrower getBorrowerById(@PathVariable Long id) {
//        return BorrowerRepository.findById(id)
//                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));
//    }
    @DeleteMapping("/delete/{id}") //Xoa nguoi muon
    public void deleteBorrower(@PathVariable Long id) {
        Borrower borrower = BorrowerRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Borrower not found"));
        BorrowerRepository.delete(borrower);
    }
    @PutMapping("/update/{id}")
    public Borrower updateBorrower(@PathVariable Long id, @Valid @RequestBody Borrower updatedBorrower) {
        Borrower borrower = BorrowerRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Borrower not found"));
        borrower.setFullName(updatedBorrower.getFullName());
        borrower.setAddress(updatedBorrower.getAddress());
        borrower.setPhoneNumber(updatedBorrower.getPhoneNumber());
        borrower.setEmail(updatedBorrower.getEmail());

        return BorrowerRepository.save(borrower);
    }

}
