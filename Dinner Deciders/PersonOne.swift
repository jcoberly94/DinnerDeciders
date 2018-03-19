//
//  PersonOne.swift
//  Dinner Deciders
//
//  Created by Justin Coberly on 3/9/18.
//  Copyright © 2018 Justin Coberly. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PersonOne: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var choice = ""
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
        choice = yelpCategories[row]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextPerson" {
            if choice == "" || choice == "Random" {
                choice = yelpCategories[Int(arc4random_uniform(UInt32(yelpCategories.count)))]
                print(choice)
            }
            let destinationVC = segue.destination as! PersonTwo
            destinationVC.choiceOne = choice
        }
    }
    
}

