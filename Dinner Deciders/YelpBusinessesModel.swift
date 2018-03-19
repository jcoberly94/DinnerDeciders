//
//  YelpBusinessesModel.swift
//  Dinner Deciders
//
//  Created by Justin Coberly on 3/10/18.
//  Copyright © 2018 Justin Coberly. All rights reserved.
//

import Foundation

class YelpBusinessesModel {
    
    let id: String
    let name: String
    let imageUrl: String
    let isClosed: Bool
    let url: String
    let reviewCount: String
    let categories: String
    let rating: Double
    let logitude: Double
    let latitude: Double
    let transactions: String
    let address: String
    let phone: String
    let displayPhone: String
    let price: String
    
    // Only available through search results not direct business queries
    var distance: String
    
    // Detail properties
    var reviews: [YelpReview]
    
    init(id: String, name: String, imageUrl: String, isClosed: Bool, url: String, reviewCount: String, categories: String, rating: Double, logitude: Double, latitude: Double, transactions: String, address: String, phone: String, displayPhone: String, price: String, distance: String) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.isClosed = isClosed
        self.url = url
        self.reviewCount = reviewCount
        self.categories = categories
        self.rating = rating
        self.logitude = logitude
        self.latitude = latitude
        self.transactions = transactions
        self.address = address
        self.phone = phone
        self.displayPhone = displayPhone
        self.price = price
        self.distance = distance
        self.reviews = []
    }

}
