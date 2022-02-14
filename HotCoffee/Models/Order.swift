//
//  Order.swift
//  HotCoffee
//
//  Created by Metin Atalay on 12.02.2022.
//

import Foundation



enum CoffeeSize : String, Codable,CaseIterable {
    case small
    case Medium
    case large
}


struct Order: Codable {
    let name: String
    let coffeeName: String
    let total: Double
    let size: CoffeeSize
}


extension Order {
    
    static var all : Resource<[Order]> = {
        guard let url = URL(string: serviceURL) else {
            fatalError("print fatal error")
        }
        
        return Resource<[Order]>(url: url)
    }()
    
    static func create(vm: AddCoffeeOrderViewModel) -> Resource<Order?> {
        let order = Order(vm)
        
        guard let url = URL(string: serviceURL) else {
            fatalError("print fatal error")
        }
        
        guard let data = try? JSONEncoder().encode( order) else {
            fatalError("encoding fatal error")
        }
        
        var resource = Resource<Order?>(url: url)
        resource.httpMethod = .post
        resource.body = data
        
        return resource
        
    }
    
}


extension Order {
    init?(_ vm:AddCoffeeOrderViewModel  ){
        self.name = vm.name!
        self.coffeeName = vm.coffeeName!
        self.size = CoffeeSize(rawValue: vm.selectedSize!)!
        self.total = 20.2
    }
    
    
}
