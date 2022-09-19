//
//  CartViewModel.swift
//  ShoppingMart
//
//  Created by Manish Ankat on 19/09/22.
//

import Foundation
import UIKit

class CartViewModel {
    
    var cartCatgories = [Category]()
    
    func loadFromBundle(fileName: String) {
            if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decodedResult = try! JSONDecoder().decode([String:[Item]].self, from: data)
                    var arrayCategories = [Category]()
                    for value in decodedResult {
                        let category = Category(name: value.key, items: value.value)
                        arrayCategories.append(category)
                    }
                    self.cartCatgories = arrayCategories
                } catch {
                    print("error:\(error)")
                }
            }
        }
    
    func totalAmount() -> Double {
        var amount = 0.0
        for category in cartCatgories {
            if let items = category.catItem {
                for item in items {
                    if item.quatity > 0 {
                        amount = amount + (Double(item.quatity) * (item.price ?? 0))
                    }
                }
            }
        }
        
        return amount
    }
}
