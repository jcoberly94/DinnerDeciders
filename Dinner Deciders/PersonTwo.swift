//
//  PersonTwo.swift
//  Dinner Deciders
//
//  Created by Justin Coberly on 3/10/18.
//  Copyright © 2018 Justin Coberly. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON

//protocol personTwoDelegate {
//    
//}

class PersonTwo: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
//    var delegate : personTwoDelegate?
    var choiceOne = ""
    var choiceTwo = ""
    
    var yelpCategories = ["Random", "American","Asian Fusion", "Barbeque", "Breakfast & Brunch", "Burgers", "Cafes", "Chinese", "Fast Food", "French", "Greek", "Indian", "Italian", "Japanese", "Korean", "Mediterranean", "Mexican", "Peruvian", "Pizza", "Sandwiches", "Seafood", "Southern", "Spanish", "Steakhouses", "Taiwanese", "Thai", "Vegan", "Vegetarian", "Vietnamese"]
    
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return yelpCategories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return yelpCategories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choiceTwo = yelpCategories[row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResults" {
            if choiceTwo == "" || choiceTwo == "Random" {
                choiceTwo = yelpCategories[Int(arc4random_uniform(UInt32(yelpCategories.count)))]
                print(choiceTwo)
            }
            let destinationVC = segue.destination as! UINavigationController
            let targetVC = destinationVC.topViewController as! ResultsViewController
            targetVC.personOneResult = choiceOne
            targetVC.personTwoResult = choiceTwo
            
        }
    }
    
}


