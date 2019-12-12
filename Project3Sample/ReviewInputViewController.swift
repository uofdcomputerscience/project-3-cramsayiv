//
//  ReviewInputViewController.swift
//  Project3Sample
//
//  Created by Russell Mirabelli on 11/16/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class ReviewInputViewController: UIViewController {

    
    @IBOutlet weak var reviewText: UITextField!
    @IBOutlet weak var reviewerName: UITextField!
    @IBOutlet weak var bookID: UITextField!
    @IBOutlet weak var myReview: UITextView!
    
    
    let reviewService = ReviewService.shared
    
    override func viewDidLoad() {
        
    }
    func inputsAreValid (text1: String, text2: String, text3: String, text4: String) -> Bool {
        if  text1.isEmpty || text2.isEmpty || text3.isEmpty {
            return false
        }
        return true
    }
    
    
    func createReview (review: Review) {
        reviewService.createReview(review: review) {
        }
    }
    
    
    @IBAction func submitReview(_ sender: Any) {
        

        let title: String = reviewText.text!
        let author: String = reviewerName.text!
        let id = bookID.text!
        let review: String = myReview.text!
        
        if title.isEmpty || author.isEmpty || id.isEmpty || review.isEmpty {
            
            let alertController = UIAlertController(title: "ERROR", message:
                    "Upload Failed. Please fill all required fields", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            createReview (review: Review (id: nil,
                            bookId: Int (String (bookID!.text!))!,
                            date: nil,
                            reviewer: String(reviewerName.text!),
                            title: String (reviewText.text!),
                            body: String(myReview.text!)))
            
            let controller = UIAlertController(title: "Success", message: "You have posted your review!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
                    self.dismiss(animated: true, completion: nil)
            }
            controller.addAction(okAction)
            present(controller, animated: true)
            
            reviewText.text = ""
            reviewerName.text = ""
            bookID.text = ""
            myReview.text = ""
                
    
            let alertController = UIAlertController(title: "Success!", message:
                "Upload complete", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
