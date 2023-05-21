package com.example.lib_manage.Borrow;

//package com.example.lib_manage.Book;

import com.example.lib_manage.Book.Book;
import com.example.lib_manage.Borrower.Borrower;
import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "borrows")
public class Borrow {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "book_id", nullable = false)
    private Book book;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "borrower_id", nullable = false)
    private Borrower borrower;

    @Column(nullable = false)
    private LocalDate borrowDate;

    @Column(nullable = false)
    private LocalDate dueDate;

    private LocalDate returnDate;

    // Getters and setters
}