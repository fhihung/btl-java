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
    public  Borrower updateBorrower(@PathVariable Long id , @Valid @RequestBody Borrower updateBorrower){
        Borrower borrower = BorrowerRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Borrower not found"));
        borrower.setAddress(updateBorrower.getAddress());
        borrower.setFullName(updateBorrower.getFullName());
        borrower.setPhoneNumber(updateBorrower.getPhoneNumber());
        borrower.setEmail(borrower.getEmail());

        return BorrowerRepository.save(borrower);
    }

}
