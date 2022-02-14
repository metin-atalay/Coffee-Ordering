//
//  AddOrderViewController.swift
//  HotCoffee
//
//  Created by Metin Atalay on 10.02.2022.
//

import Foundation
import UIKit

protocol AddViewControllerDelegete{
    func save(order : Order, viewController: UIViewController)
    func close (viewController: UIViewController)
}

class AddOrderViewController : UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    private var vm = AddCoffeeOrderViewModel()
    private var coffeeSizesSegmentedControl = UISegmentedControl()
    @IBOutlet weak var nameTextFiled: UITextField!
    var pageDelegate:AddViewControllerDelegete!
    
    let coffeeName = ["HOT Coffe", "Cool Coffe", "Warm Cofffe"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        self.coffeeSizesSegmentedControl = UISegmentedControl(items: self.vm.size)
        self.coffeeSizesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.coffeeSizesSegmentedControl)
        
        self.coffeeSizesSegmentedControl.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 20).isActive = true
        
        self.coffeeSizesSegmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffeeName.count
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeTableViewCell", for: indexPath)
        
        cell.textLabel?.text = coffeeName[indexPath.row]
        
        return cell
    }
    
    @IBAction func save(){
        let name = nameTextFiled.text
        var selectedSize = self.coffeeSizesSegmentedControl.titleForSegment(at: self.coffeeSizesSegmentedControl.selectedSegmentIndex)
        
        guard let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("table view has not selected")
        }
        
        self.vm.coffeeName = coffeeName[indexPath.row]
        self.vm.selectedSize = selectedSize
        self.vm.name = name
        
        Webservice().load(resource: Order.create(vm: self.vm)) { result in
    
            switch result {
            case .success(let order):
                print(order)
                if let pageDel  = self.pageDelegate {
                 //   pageDel.save(order: order!, viewController: self)
                }
            case .failure(let error):
                print(error)
               
            }
            
            DispatchQueue.main.async {
                if let pageDel  = self.pageDelegate {
                    pageDel.save(order: Order(self.vm)!, viewController: self)
                }
            }
          
            
        }
        
    }
    
    @IBAction func close() {
        
        if let pageDel  = self.pageDelegate {
            pageDel.close(viewController: self)
        }
        
    }
    
  
    
    @IBOutlet weak var tableView: UITableView!
}
    
