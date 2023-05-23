package com.example.lib_manage.Borrower;
import com.example.lib_manage.Book.Book;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

@RestController
@RequestMapping("/borrowers")
public class BorrowerController {
    @Autowired
    private BorrowerRepository BorrowerRepository;

    @PostMapping
    public Borrower addBorrower(@RequestBody Borrower borrower) {
        return BorrowerRepository.save(borrower);
    }
    @DeleteMapping("/delete/{id}")
    public void deleteBorrower(@PathVariable Long id) {
        Borrower borrower = BorrowerRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Borrower not found"));
        BorrowerRepository.delete(borrower);
    }
}
