//
//  BusinessDetailViewController.swift
//  Dinner Deciders
//
//  Created by Justin Coberly on 3/11/18.
//  Copyright © 2018 Justin Coberly. All rights reserved.
//

import UIKit
import MapKit

class BusinessDetailViewController: UITableViewController {
    
    var business: YelpBusinessesModel?
    
    lazy var dataSource: YelpReviewsDataSource = {
        return YelpReviewsDataSource(data: [])
    }()
    
    
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var ratingsCount: UILabel!
    @IBOutlet weak var starRating: UIImageView!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var currentHoursStatusLabel: UILabel!
    @IBAction func getDirections(_ sender: Any) {
        let lat = business?.latitude
        let long = business?.logitude
        let coordinate = CLLocationCoordinate2DMake(lat!, long!)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = business?.name ?? "Restaurant"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }

    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        businessName.text = business?.name
        price.text = business?.price
        ratingsCount.text = "(\(business?.reviewCount ?? "None"))"
        categoriesLabel.text = "Category: \(business?.categories ?? "None")"
        let reviewStar = getRating(rating: (business?.rating)!)
        starRating.image = UIImage(named: reviewStar)
        if let isClosed = business?.isClosed {
            if isClosed {
                print(isClosed)
                currentHoursStatusLabel.text = "Closed"
                currentHoursStatusLabel.textColor = UIColor(red: 209/255.0, green: 47/255.0, blue: 27/255.0, alpha: 1.0)
            } else {
                currentHoursStatusLabel.text = "Open"
                currentHoursStatusLabel.textColor = UIColor(red: 2/255.0, green: 192/255.0, blue: 97/255.0, alpha: 1.0)
            }
        }
    }
    
    func getRating(rating: Double)-> String {
        let wholeRating = rating * 10
        switch wholeRating {
        case 0...9:
            return "extra_large_0"
        case 10...14:
            return "extra_large_1"
        case 15...19:
            return "extra_large_1_half"
        case 20...24:
            return "extra_large_2"
        case 25...29:
            return "extra_large_2_half"
        case 30...34:
            return "extra_large_3"
        case 35...39:
            return "extra_large_3_half"
        case 40...44:
            return "extra_large_4"
        case 45...49:
            return "extra_large_4_half"
        default:
            return "extra_large_5"
        }
        
    }
    
    // MARK: - Table View
    
    func setupTableView() {
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
    }

}
