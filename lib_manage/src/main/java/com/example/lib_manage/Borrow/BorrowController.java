package com.example.lib_manage.Borrow;

import com.example.lib_manage.Book.Book;

import com.example.lib_manage.Borrower.Borrower;
import com.example.lib_manage.Borrower.BorrowerRepository;
import jakarta.validation.Valid;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/borrows")
public class BorrowController {

    @Autowired
    private com.example.lib_manage.Borrower.BorrowerRepository BorrowerRepository;
    @Autowired
    private com.example.lib_manage.Borrow.BorrowRepository BorrowRepository;
    @Autowired
    private com.example.lib_manage.Book.BookRepository BookRepository;


    @GetMapping()
    public List<BorrowInfo> getBorrowInfo() {
        List<Borrow> borrows = BorrowRepository.findAll();
        List<BorrowInfo> borrowInfos = new ArrayList<>();

        for (Borrow borrow : borrows) {
            borrowInfos.add(borrow.toBorrowInfo());
        }

        return borrowInfos;
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


//    @PostMapping("/addBorrow") //Thêm ticket mượn sách
//public Borrow addBorrow(@RequestBody @Valid Borrow borrow) {
//        if (borrow.getBook() == null) {
//            throw new IllegalArgumentException("Book is required");
//        }
//        if (borrow.getBorrower() == null) {
//            throw new IllegalArgumentException("Borrower is required");
//        }
//
//        // Kiểm tra Borrow không null
//
//    Long personId = borrow.getBorrower().getId();
//    Long bookId = borrow.getBook().getId();
//
//    Borrower borrower = BorrowerRepository.findById(personId)
//            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Borrower not found"));
//
//    Book book = BookRepository.findById(bookId)
//            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));
//
//    if (book.getQuantity() <= 0) {
//        throw new IllegalArgumentException("Out of stock");
//    }
//
//    book.setQuantity(book.getQuantity() - 1);
//    BookRepository.save(book);
//
//    borrow.setBorrower(borrower);
//    borrow.setBook(book);
//    borrow.setBorrowDate(LocalDate.now());
//
//    return BorrowRepository.save(borrow);
//}
    @PostMapping("/returnBook") // Yêu cầu trả sách
    public Borrow returnBook(@RequestBody @Valid Borrow borrow) {
        Long borrowId = borrow.getId();
        Borrow existingBorrow = BorrowRepository.findById(borrowId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Borrower not found"));
//        Hibernate.initialize(borrowId);
        if (existingBorrow.getReturnDate() != null) {
            throw new IllegalArgumentException("Book already returned");
        }

        existingBorrow.setReturnDate(LocalDate.now());

        Book book = existingBorrow.getBook();
        book.setQuantity(book.getQuantity() + 1);
        BookRepository.save(book);

        return BorrowRepository.save(existingBorrow);
    }
//    @GetMapping("/books-by-borrower/{borrowerId}")
//    public List<Book> getBooksByBorrower(@PathVariable Long borrowerId) {
//        List<Borrow> borrows = BorrowRepository.findByBorrowerId(borrowerId);
//        List<Book> books = new ArrayList<>();
//
//        for (Borrow borrow : borrows) {
//            books.add(borrow.getBook());
//        }
//
//        return books;
//    }
@GetMapping("/books-by-borrower/{borrowerId}")
public List<Book> getBooksByBorrower(@PathVariable Long borrowerId) {
    List<Borrow> borrows = BorrowRepository.findByBorrowerId(borrowerId);
    List<Book> books = new ArrayList<>();

    for (Borrow borrow : borrows) {
        if (borrow.getReturnDate() == null) {
            books.add(borrow.getBook());
        }
    }

    return books;
}

//    @PostMapping("/returnBook") // Trả sách
//    public void returnBook(@RequestBody @Valid Borrow borrow) {
//        Book book = borrow.getBook();
//
//        if (book != null) {
//            Long bookId = book.getId();
//            Optional<Book> optionalBook = BookRepository.findById(bookId);
//
//            if (optionalBook.isPresent()) {
//                Book existingBook = optionalBook.get();
//                int quantity = existingBook.getQuantity();
//
//                existingBook.setQuantity(quantity + 1);
//                BookRepository.save(existingBook);
//            } else {
//                throw new IllegalArgumentException("Book not found");
//            }
//        }
//        BorrowRepository.delete(borrow);
//    }
    @PutMapping("/update/{id}")
    public Borrow updateBorrow(@PathVariable Long id , @Valid @RequestBody Borrow updateBorrow)   {
        Borrow borrow = BorrowRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));
        borrow.setBorrowDate(updateBorrow.getBorrowDate());
        borrow.setDueDate(updateBorrow.getDueDate());
        borrow.setReturnDate(updateBorrow.getReturnDate());

        return BorrowRepository.save(borrow);
    }
//
}
