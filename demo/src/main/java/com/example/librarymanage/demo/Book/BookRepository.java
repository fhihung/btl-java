package com.example.librarymanage.demo.Book;

import org.springframework.data.jpa.repository.JpaRepository;

public interface BookRepository extends JpaRepository<BookItem, Long> {
}