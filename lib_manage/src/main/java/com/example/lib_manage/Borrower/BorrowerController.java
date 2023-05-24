package com.example.lib_manage.Borrower;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/borrowers")
public class BorrowerController {
    @Autowired
    private BorrowerRepository BorrowerRepository;
    @GetMapping("/count")
    public Long getBorrowerCount() {
        return BorrowerRepository.count();
    }
    @PostMapping
    public Borrower addBorrower(@RequestBody Borrower borrower) {
        return BorrowerRepository.save(borrower);
    }
}
