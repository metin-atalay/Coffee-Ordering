//
//  OrdersTableViewController.swift
//  HotCoffee
//
//  Created by Metin Atalay on 10.02.2022.
//

import Foundation
import UIKit

class OrdersTableViewController : UITableViewController, AddViewControllerDelegete {
    func save(order: Order, viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
        
        let orderVM = OrderViewModel(order: order)
        self.orderListViewModel.ordersViewModel.append(orderVM)
        
        self.tableView.insertRows(at: [IndexPath.init(row:  self.orderListViewModel.ordersViewModel.count - 1, section: 0)], with: .automatic)
        
    }
    
    func close(viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    
    var orderListViewModel = OrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders()
    }
    
    private func populateOrders() {
        Webservice().load(resource: Order.all) { result in
            
            switch result {
            case .success(let orders) :
                self.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                print(orders)
                
                //  DispatchQueue.main.async {
                self.tableView.reloadData()
                //  }
                
            case .failure(let error) :
                print(error)
            }
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderListViewModel.ordersViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let vm = self.orderListViewModel.orderViewModel(at: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath)
        
        
        cell.textLabel?.text = vm.name
        cell.detailTextLabel?.text = vm.size
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        guard let navC = segue.destination as? UINavigationController,
              let addCofVC = navC.viewControllers.first as? AddOrderViewController else {
                  fatalError("perform seque")
              }
        
        addCofVC.pageDelegate = self
        
    }
    
    
}
