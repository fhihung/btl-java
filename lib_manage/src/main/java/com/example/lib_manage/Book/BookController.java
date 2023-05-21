package com.example.lib_manage.Book;

import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@RestController
    @RequestMapping(path = "/books")
    public class BookController {
        @Autowired
        private BookRepository BookRepository;
    @GetMapping()
    public List<Book> getBooks() {
        return BookRepository.findAll();
    }
        @GetMapping("/{id}")
        public Book getBookById(@PathVariable Long id) {
            return BookRepository.findById(id)
                    .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));
        }
        @PostMapping("/add")
        public Book addBook(@RequestBody @Valid Book book) {
            return BookRepository.save(book);
        }

//        @PutMapping("/{id}/quantity")
//        public Book updateBookQuantity(@PathVariable Long id, @RequestParam int quantity) {
//            Book book = BookRepository.findById(id)
//                    .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));
//
//            book.setQuantity(quantity);
//            return BookRepository.save(book);
//        }
@PutMapping("/{id}/quantity/{quantity}")
public Book updateBookQuantity(@PathVariable Long id, @PathVariable int quantity) {
    Book book = BookRepository.findById(id)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));

    book.setQuantity(quantity);
    return BookRepository.save(book);
}

        @DeleteMapping("/{id}")
        public void deleteBook(@PathVariable Long id) {
            Book book = BookRepository.findById(id)
                    .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));

            BookRepository.delete(book);
        }
    }
