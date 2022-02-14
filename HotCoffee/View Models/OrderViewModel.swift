//
//  OrderView.swift
//  HotCoffee
//
//  Created by Metin Atalay on 12.02.2022.
//

import Foundation
import UIKit


class OrderListViewModel {
    var ordersViewModel: [OrderViewModel]
    
    init(){
        self.ordersViewModel = [OrderViewModel]()
    }
}
extension OrderListViewModel {
    func orderViewModel(at index: Int) -> OrderViewModel {
        return self.ordersViewModel[index]
    }
}


struct OrderViewModel {
    let order: Order
}

extension OrderViewModel {
    var name : String {
        return self.order.name
    }
    var coffeeName: String {
        return self.order.coffeeName
    }
    var total: Double {
        return self.order.total
    }
    var size: String {
        return self.order.size.rawValue.capitalized
    }
}
