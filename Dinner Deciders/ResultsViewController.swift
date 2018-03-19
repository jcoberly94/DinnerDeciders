//
//  ResultsViewController.swift
//  Dinner Deciders
//
//  Created by Justin Coberly on 3/10/18.
//  Copyright © 2018 Justin Coberly. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ResultsViewController: UIViewController, CLLocationManagerDelegate {
    
    let yelpAPIKey = "MHH1g6v7wNU2t-SGtsDx9wUgn9e3RvPso1EHzBzfXy-XAV6vyD8IbZN3yKeXdQlxFH82zAjtfj9p3aQCJ3TZXK6TZ4sfnOAofp-0JzEEuQpUOfSTgiwDUOy-6iiUWnYx"
    let yelpURL = "https://api.yelp.com/v3/businesses/search"
    let locationManager = CLLocationManager()
    var business: YelpBusinessesModel!
    
    var personOneResult = ""
    var personTwoResult = ""
    
    var businessList = [YelpBusinessesModel]()
    
    let dataSource = BusinessTableView()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = dataSource
        locationManager.delegate = self
        self.tableView.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 75
       
    }

    func formatData(choice: String) -> String {
        switch choice {
        case "Asian Fusion":
            return "asian_fusion"
        case "Barbeque":
            return "bbq"
        case "Breakfast & Brunch":
            return "breakfast_brunch"
        case "Fast Food":
            return "hotdogs"
        case "Steakhouses":
            return "steak"
        case "Indian":
            return "indpak"
        default:
            return choice.lowercased()
        }
    }
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.10, longitudeDelta: 0.10))
            
            mapView.setRegion(region, animated: true)
            let myAnnotation: MKPointAnnotation = MKPointAnnotation()
            myAnnotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
            myAnnotation.title = "Current location"
            mapView.addAnnotation(myAnnotation)
            
            /***************************/
            personOneResult = formatData(choice: personOneResult)
            personTwoResult = formatData(choice: personTwoResult)
            
            let yelpParams : [String : String] = ["categories" : "\(personOneResult),\(personTwoResult)", "latitude" : latitude, "longitude" : longitude, "radius" : "16000"]
            getYelpData(url: yelpURL, parameters: yelpParams)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func getYelpData(url: String, parameters: [String : String]) {
        let headers = ["Authorization": "Bearer \(yelpAPIKey)"]
        Alamofire.request(url, method: .get, parameters: parameters, headers: headers).responseJSON {
            response in
            if response.result.isSuccess {
                let yelpJSON : JSON = JSON(response.result.value!)
                self.updateYelpData(json: yelpJSON)
            } else {
                print("ERROR")
            }
        }
    }
    
    func updateYelpData(json: JSON) {
        if let result = json["businesses"][0]["name"].string {
            
            let businessCount = json["businesses"].count
            for index in 0...businessCount-1 {
                let newBusiness = YelpBusinessesModel(id: json["businesses"][index]["id"].stringValue, name: json["businesses"][index]["name"].stringValue, imageUrl: json["businesses"][index]["image_url"].stringValue, isClosed: json["businesses"][index]["is_closed"].boolValue, url: "URL", reviewCount: json["businesses"][index]["review_count"].stringValue, categories: json["businesses"][index]["categories"][0]["title"].stringValue, rating: json["businesses"][index]["rating"].doubleValue, logitude: json["businesses"][index]["coordinates"]["longitude"].doubleValue, latitude: json["businesses"][index]["coordinates"]["latitude"].doubleValue, transactions: "TRANSACTIONS", address: "MYADDRESS", phone: json["businesses"][index]["phone"].stringValue, displayPhone: json["businesses"][index]["display_phone"].stringValue, price: json["businesses"][index]["price"].stringValue, distance: json["businesses"][index]["distance"].stringValue)
                businessList.append(newBusiness)
            }
            dataSource.update(with: businessList)
            tableView.reloadData()
            addBusinessMarkers()
        } else {
            print("failed to unwrap result")
        }
    }
    
    func addBusinessMarkers() {
        for index in businessList {
            let myAnnotation: MKPointAnnotation = MKPointAnnotation()
            myAnnotation.coordinate = CLLocationCoordinate2DMake(index.latitude, index.logitude);
            myAnnotation.title = index.name
            mapView.addAnnotation(myAnnotation)
        }
    }
}

extension ResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let business = dataSource.object(at: indexPath)
        let businessDetailsUrl = "https://api.yelp.com/v3/businesses/\(business.id)/reviews"
        let headers = ["Authorization": "Bearer \(yelpAPIKey)"]
        Alamofire.request(businessDetailsUrl, method: .get, headers: headers).responseJSON {
            response in
            if response.result.isSuccess {
                let yelpJSON : JSON = JSON(response.result.value!)
                if let result = yelpJSON["reviews"][0]["text"].string {
                    let reviewCount = yelpJSON["reviews"].count
                    for index in 0...reviewCount-1 {
                        let review = YelpReview(url: yelpJSON["reviews"][index]["user"]["image_url"].stringValue, text: yelpJSON["reviews"][index]["text"].stringValue, rating: yelpJSON["reviews"][index]["rating"].intValue, name: yelpJSON["reviews"][index]["user"]["name"].stringValue)
                        business.reviews.append(review)
                    }
                }
                self.dataSource.update(business, at: indexPath)
                self.performSegue(withIdentifier: "showBusiness", sender: nil)
            } else {
                print("ERROR")
            }
        }
    }
}

// MARK: - Navigation
extension ResultsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBusiness" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let business = dataSource.object(at: indexPath)
                let detailController = segue.destination as! BusinessDetailViewController
                detailController.business = business
                detailController.dataSource.updateData(business.reviews)
            }
        }
    }
}

