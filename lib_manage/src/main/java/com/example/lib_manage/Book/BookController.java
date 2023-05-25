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
    @GetMapping("/search/title/{title}")
    public List<Book> searchBooksByTitle(@PathVariable String title) {
        return BookRepository.findByTitleContainingIgnoreCase(title);
    }
    @GetMapping("/search/publisher/{publisher}")
    public List<Book> searchBooksByPublisher(@PathVariable String publisher) {
        return BookRepository.findByPublisherContainingIgnoreCase(publisher);
    }

    @GetMapping("/search/author/{author}")
    public List<Book> searchBooksByAuthor(@PathVariable String author) {
        return BookRepository.findByAuthorContainingIgnoreCase(author);
    }
    @GetMapping("/count")
    public Long getBookCount() {
        return BookRepository.count();
    }
        @GetMapping("/{id}")
        public Book getBookById(@PathVariable Long id) {
            return BookRepository.findById(id)
                    .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));
        }
        @PostMapping("/add")//them du lieu
        public Book addBook(@RequestBody @Valid Book book) {
            return BookRepository.save(book);
        }


        @PutMapping("/{id}/quantity/{quantity}") //sua quatity
        public Book updateBookQuantity(@PathVariable Long id, @PathVariable int quantity) {
            Book book = BookRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));

            book.setQuantity(quantity);
            return BookRepository.save(book);
        }
        @PutMapping("/{id}/publicationYear/{publicationYear}")//sua publicationYear
        public Book updateBookPublicationYear(@PathVariable Long id, @PathVariable int publicationYear) {
        Book book = BookRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));

        book.setPublicationYear(publicationYear);
        return BookRepository.save(book);
    }
        @PutMapping("/{id}/title/{title}") // sua title
        public Book updateBookTitle(@PathVariable Long id, @PathVariable String title) {
            Book book = BookRepository.findById(id)
                    .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));

            book.setTitle(title);
            return BookRepository.save(book);
    }
    @PutMapping("/{id}/author/{author}") // sua author
    public Book updateBookAuthor(@PathVariable Long id, @PathVariable String author) {
        Book book = BookRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));
        book.setAuthor(author);
        return BookRepository.save(book);
    }
    @PutMapping("/{id}/publisher/{publisher}")//sua publisher
    public Book updateBookPublisher(@PathVariable Long id, @PathVariable String publisher) {
        Book book = BookRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));
        book.setPublisher(publisher);
        return BookRepository.save(book);
    }
        @DeleteMapping("/{id}")
        public void deleteBook(@PathVariable Long id) {
            Book book = BookRepository.findById(id)
                    .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Book not found"));

            BookRepository.delete(book);
        }
    }
