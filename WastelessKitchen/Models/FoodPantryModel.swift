//
//  FoodPantryModel.swift
//  WastelessKitchen
//
//  Created by Krystal Campbell on 12/18/19.
//  Copyright © 2019 God. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore

struct FoodPantry {
    
    let userID: String
    let foodName: String
    let expirationDate: String
    let dateCreated: String
    let photoUrl: String
    
    init(user: User, foodName: String, expirationDate: String, dateCreated: String, photoUrl: String) {
        
        self.userID = user.uid
        self.foodName = foodName
        self.expirationDate = expirationDate
        self.dateCreated = dateCreated
        self.photoUrl = photoUrl
        
    }
    
    init?(from dict: [String: Any], id: String){
        
        let userID = dict["userID"] as? String ?? "no user ID"
        let foodName = dict["foodName"] as? String ?? "no user ID"
        let expirationDate = dict["expirationDate"] as? String ?? "no user ID"
        let dateCreated = dict["dateCreated"] as? String ?? "no user ID"
        let photoUrl = dict["photoUrl"] as? String ?? "no user ID"
        
        self.userID = userID
        self.foodName = foodName
        self.expirationDate = expirationDate
        self.dateCreated = dateCreated
        self.photoUrl = photoUrl
    }
    
    
}

