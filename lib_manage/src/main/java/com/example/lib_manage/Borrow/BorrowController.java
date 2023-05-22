package com.example.lib_manage.Borrow;

import com.example.lib_manage.Book.Book;
import com.example.lib_manage.Borrower.Borrower;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(path = "/borrows")
public class BorrowController {
    @Autowired
    private com.example.lib_manage.Borrow.BorrowRepository BorrowRepository;
    @GetMapping
    public List<Borrow> getBorrows() {
        return BorrowRepository.findAll();
    }

//    @PostMapping("/addBorrow")
//    public ResponseEntity<Borrow> addBorrow(@RequestBody Borrow borrow) {
//        Borrow createdBorrow = BorrowRepository.save(borrow);
//        return new ResponseEntity<>(createdBorrow, HttpStatus.CREATED);
//    }
        @PostMapping("/addBorrow")
        public Borrow addBorrow(@RequestBody @Valid Borrow borrow) {
            return BorrowRepository.save(borrow);
}
}
//    @GetMapping("/{id}")
//    public Book getBookById(@PathVariable Long id) {
//        return BookRepository.findById(id)
//                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));
//    }
//    @PostMapping("/add")
//    public Book addBook(@RequestBody @Valid Book book) {
//        return BookRepository.save(book);
//    }
//
//    //        @PutMapping("/{id}/quantity")
////        public Book updateBookQuantity(@PathVariable Long id, @RequestParam int quantity) {
////            Book book = BookRepository.findById(id)
////                    .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));
////
////            book.setQuantity(quantity);
////            return BookRepository.save(book);
////        }
//    @PutMapping("/{id}/quantity/{quantity}")
//    public Book updateBookQuantity(@PathVariable Long id, @PathVariable int quantity) {
//        Book book = BookRepository.findById(id)
//                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));
//
//        book.setQuantity(quantity);
//        return BookRepository.save(book);
//    }
//
//    @DeleteMapping("/{id}")
//    public void deleteBook(@PathVariable Long id) {
//        Book book = BookRepository.findById(id)
//                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));
//
//        BookRepository.delete(book);
//    }
//}
