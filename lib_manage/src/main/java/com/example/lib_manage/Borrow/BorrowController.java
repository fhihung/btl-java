package com.example.lib_manage.Borrow;

import com.example.lib_manage.Book.Book;
import com.example.lib_manage.Borrower.Borrower;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/borrows")
public class BorrowController {
    @Autowired
    private com.example.lib_manage.Borrow.BorrowRepository BorrowRepository;
    @Autowired
    private com.example.lib_manage.Book.BookRepository BookRepository;
    @GetMapping
    public List<Borrow> getBorrows() {
        return BorrowRepository.findAll();
    }

    @PostMapping("/add")
    public Borrow addBorrow(@RequestBody @Valid Borrow borrow) {
        Book book = borrow.getBook();
        Long id = book.getId();
        if(book != null){
            Optional<Book> optionalBook = BookRepository.findById(id);
            if(optionalBook.isPresent()){
                Book existingBook = optionalBook.get();
                if(existingBook.getQuantity()==0){
                    throw new IllegalArgumentException("het sach trong kho");
                }
                existingBook.setQuantity(existingBook.getQuantity()-1);
                BookRepository.save(existingBook);
            }
        }
        return BorrowRepository.save(borrow);
    }
}
//
//    @GetMapping
//    public List<Borrow> getBorrows() {
//        return BorrowRepository.findAll();
//    }
//
//    //    @PostMapping("/addBorrow")
////    public ResponseEntity<Borrow> addBorrow(@RequestBody Borrow borrow) {
////        Borrow createdBorrow = BorrowRepository.save(borrow);
////        return new ResponseEntity<>(createdBorrow, HttpStatus.CREATED);
////    }
//    @PostMapping
//    public Borrow addBorrow(@RequestBody @Valid Borrow borrow) {
//        return BorrowRepository.save(borrow);
//    }
//}