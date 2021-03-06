//
//  YelpReviewsDataSource.swift
//  Dinner Deciders
//
//  Created by Justin Coberly on 3/11/18.
//  Copyright © 2018 Justin Coberly. All rights reserved.
//

import Foundation
import UIKit

class YelpReviewsDataSource: NSObject, UITableViewDataSource {
    private var data: [YelpReview]
    
    init(data: [YelpReview]) {
        self.data = data
        super.init()
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.reuseIdentifier, for: indexPath) as! ReviewCell
        
        let review = object(at: indexPath)

        cell.reviewLabel.text = review.text
        let url = URL(string: review.url)
        
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        cell.userImageView.image = UIImage(data: data!) ?? #imageLiteral(resourceName: "anonymous")
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Reviews"
    }
    
    // MARK: Helpers
    
    func update(_ object: YelpReview, at indexPath: IndexPath) {
        data[indexPath.row] = object
    }
    
    func updateData(_ data: [YelpReview]) {
        self.data = data
    }
    
    func object(at indexPath: IndexPath) -> YelpReview {
        return data[indexPath.row]
    }
}
