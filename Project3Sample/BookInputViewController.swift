//
//  BookInputViewController.swift
//  Project3Sample
//
//  Created by Russell Mirabelli on 11/16/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class BookInputViewController: UIViewController {
    
    @IBOutlet weak var myTitle: UITextField!
    @IBOutlet weak var myAuthor: UITextField!
    @IBOutlet weak var myDate: UITextField!
    @IBOutlet weak var myImage: UITextField!
    
    let bookService = BookService.shared
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        myTitle.delegate = self
        myAuthor.delegate = self
        myDate.delegate = self
        myImage.delegate = self
        
    }
    
    @IBAction func submitBook(_ sender: Any) {
        
        let title: String = myTitle.text!
        let author: String = myAuthor.text!
        let date: String = myDate.text!
        
        if title.isEmpty || author.isEmpty || date.isEmpty {
           
            let alertController = UIAlertController(title: "ERROR", message:
                    "Upload Failed. Please fill all required fields", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
            
        } else {

            createBook(book: Book(id: nil,
                             title: String (myTitle.text!),
                             author: String (myAuthor.text!),
                             published: String (myDate.text!),
                             imageURLString: String (myImage.text!)))

            let alertController = UIAlertController(title: "Success!", message:
                    "Upload complete", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
            
            myTitle.text = ""
            myAuthor.text = ""
            myDate.text = ""
            myImage.text = ""

        }
    }
    
    func createBook(book: Book) {
        bookService.createBook(book: book) {
            print("book created")
        }
    }
}

extension BookInputViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         if textField == myTitle {
            myAuthor.becomeFirstResponder()
         }
         if textField == myAuthor {
            myDate.becomeFirstResponder()
         }
         if textField == myDate {
            myImage.becomeFirstResponder()
         }
         return true
    }
}
