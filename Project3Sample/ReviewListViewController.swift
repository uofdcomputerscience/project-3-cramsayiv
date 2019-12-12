//
//  ReviewListViewController.swift
//  Project3Sample
//
//  Created by Russell Mirabelli on 11/16/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

class ReviewListViewController: UIViewController {
    
    @IBOutlet weak var myReviews: UITableView!
    
    let reviewService = ReviewService.shared
    
    override func viewDidLoad() {
        
        fetchReviews()
        myReviews.dataSource = self
        
    }
    
    func fetchReviews () {
        
        reviewService.fetchReviews { [weak self] in
            DispatchQueue.main.async {
                self?.myReviews.reloadData()
            }
        }
    }
}

extension ReviewListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviewService.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let my_review = reviewService.reviews[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewCell
        cell.config (review: my_review, service: self.reviewService)
        return cell
    }
}
