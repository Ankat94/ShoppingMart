//
//  CartModel.swift
//  ShoppingMart
//
//  Created by Manish Ankat on 19/09/22.
//

import Foundation

struct Category: Codable {
    var catName: String?
    var catItem: [Item]?
    var isOpened = false
    
    init(name: String, items: [Item]) {
        self.catName = name
        self.catItem = items
    }
}

struct Item: Codable {
    var name: String?
    var price: Double?
    var instock: Bool?
    var quatity = 0
    
    enum CodingKeys: String, CodingKey {
            case name, price, instock
        }
}
