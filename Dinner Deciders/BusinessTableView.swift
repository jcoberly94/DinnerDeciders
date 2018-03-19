//
//  BusinessTableView.swift
//  Dinner Deciders
//
//  Created by Justin Coberly on 3/11/18.
//  Copyright © 2018 Justin Coberly. All rights reserved.
//
import Foundation
import UIKit

class BusinessTableView: NSObject, UITableViewDataSource {
    
    private var data = [YelpBusinessesModel]()
    
    override init() {
        super.init()
    }
    
    // MARK: Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath)
        
        let business = object(at: indexPath)
        cell.textLabel?.text = business.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Restaurants"
        default: return nil
        }
    }

// MARK: Helpers
    func object(at indexPath: IndexPath) -> YelpBusinessesModel {
        return data[indexPath.row]
    }

    func update(with data: [YelpBusinessesModel]) {
        self.data = data
    }

    func update(_ object: YelpBusinessesModel, at indexPath: IndexPath) {
        data[indexPath.row] = object
    }
    
}
