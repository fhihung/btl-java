package com.example.librarymanage.demo.Book;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/books")
public class BookController {

    @Autowired
    private BookRepository bookRepository;

    @GetMapping
    public List<BookItem> getAllBooks() {
        return bookRepository.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<BookItem> getBookById(@PathVariable("id") Long id) {
        BookItem book = bookRepository.findById(id).orElse(null);
        if (book != null) {
            return ResponseEntity.ok().body(book);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping("/add")
    public BookItem addBook(@Valid @RequestBody BookItem book) {
        return bookRepository.save(book);
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<BookItem> updateBook(@PathVariable("id") Long id, @RequestBody BookItem bookDetails) {
        BookItem book = bookRepository.findById(id).orElse(null);
        if (book != null) {
            book.setTitle(bookDetails.getTitle());
            book.setAuthor(bookDetails.getAuthor());
            book.setQuantity(bookDetails.getQuantity());
            bookRepository.save(book);
            return ResponseEntity.ok().body(book);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<HttpStatus> deleteBook(@PathVariable("id") Long id) {
        BookItem book = bookRepository.findById(id).orElse(null);
        if (book != null) {
            bookRepository.delete(book);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/borrow")
    public ResponseEntity<String> borrowBook(@RequestParam Long bookId, @RequestParam Long borrowerId) {
        BookItem book = bookRepository.findById(bookId).orElse(null);
        if (book != null && book.getQuantity() > 0) {
            book.setQuantity(book.getQuantity() - 1);
            book.setBorrowerId(borrowerId);
            bookRepository.save(book);
            return ResponseEntity.ok().body("Borrowed successfully");
        } else {
            return ResponseEntity.badRequest().body("Cannot borrow this book");
        }
    }
}
