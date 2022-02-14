//
//  AddCoffeeOrderViewModel.swift
//  HotCoffee
//
//  Created by Metin Atalay on 12.02.2022.
//

import Foundation

struct AddCoffeeOrderViewModel {
    
    var name: String?
   // var coffeeName: String?
    
    var coffeeName: String?
    
    var size: [String] {
        return CoffeeSize.allCases.map { $0.rawValue.capitalized }
    }
    
    var selectedSize : String?
    
}
