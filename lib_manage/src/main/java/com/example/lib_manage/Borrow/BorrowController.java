package com.example.lib_manage.Borrow;

import com.example.lib_manage.Book.Book;
import com.example.lib_manage.Borrower.Borrower;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDate;
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

    @PostMapping("/addBorrow") //Thêm ticket mượn sách
    public Borrow addBorrow(@RequestBody @Valid Borrow borrow) {
        Book book = borrow.getBook();

        if (book != null) {
            Long bookId = book.getId();
            Optional<Book> optionalBook = BookRepository.findById(bookId);

            if (optionalBook.isPresent()) {
                Book existingBook = optionalBook.get();
                int quantity = existingBook.getQuantity();

                if (quantity == 0) {
                    throw new IllegalArgumentException("Out of stock");
                }

                existingBook.setQuantity(quantity - 1);
                BookRepository.save(existingBook);
            } else {
                throw new IllegalArgumentException("Book not found");
            }
        }
        return BorrowRepository.save(borrow);
    }
    @PutMapping("/{id}/borrowDate/{borrowDate}") // sửa ngày mượn
    public Borrow updateBorrowDate(@PathVariable Long id, @PathVariable LocalDate borrowDate) {
        Borrow borrow = BorrowRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));

        borrow.setBorrowDate(borrowDate);
        return BorrowRepository.save(borrow);
    }
    @PutMapping("/{id}/dueDate/{dueDate}") // sửa thời gian còn lại phải trả
    public Borrow updateDueDate(@PathVariable Long id, @PathVariable LocalDate dueDate) {
        Borrow borrow = BorrowRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));

        borrow.setDueDate(dueDate);
        return BorrowRepository.save(borrow);
    }
    @PutMapping("/{id}/returnDate/{returnDate}") // sửa ngày trả
    public Borrow updateReturnDate(@PathVariable Long id, @PathVariable LocalDate returnDate) {
        Borrow borrow = BorrowRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));

        borrow.setReturnDate(returnDate);
        return BorrowRepository.save(borrow);
    }
}
