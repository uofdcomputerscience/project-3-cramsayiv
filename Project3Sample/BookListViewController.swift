//
//  BookListViewController.swift
//  Project3Sample
//
//  Created by Russell Mirabelli on 11/16/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let bookService = BookService.shared
    
    override func viewDidLoad() {
        fetchBooks()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    
    func fetchBooks() {
        bookService.fetchBooks { [weak self] in
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.bookService.books.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let my_book = bookService.books[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell") as! BookCell
        cell.config (book: my_book, service: self.bookService)
        
        return cell
        
    }
}
