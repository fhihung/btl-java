package com.example.lib_manage.Borrow;

import com.example.lib_manage.Book.Book;
import com.example.lib_manage.Borrower.Borrower;
import jakarta.validation.Valid;
import com.example.lib_manage.Borrow.BorrowRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/borrows")
public class BorrowController {
    @Autowired
    private com.example.lib_manage.Borrow.BorrowRepository BorrowRepository;

    @GetMapping
    public List<Borrow> getBorrows() {
        return BorrowRepository.findAll();
    }

    @PostMapping("/add")
    public Borrow addBorrow(@RequestBody @Valid Borrow borrow) {
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