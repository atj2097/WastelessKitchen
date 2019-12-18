//
//  APIProtocol.swift
//  WastelessKitchen
//
//  Created by God on 12/18/19.
//  Copyright © 2019 God. All rights reserved.
//

import Foundation
protocol FoodData {
    var imgURL: String {get}
    var foodName: String {get}
    var foodDesc: String {get}
    var expDate: String {get}
}
