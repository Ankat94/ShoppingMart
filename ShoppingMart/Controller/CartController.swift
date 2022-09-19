//
//  ViewController.swift
//  ShoppingMart
//
//  Created by Manish Ankat on 19/09/22.
//

import UIKit

class CartController: UIViewController {
    
    @IBOutlet weak var tblv: UITableView!
    @IBOutlet weak var lblPlaceOrder: UIButton!
    @IBOutlet weak var btnPlaceOrder: UIButton!
    
    let vm = CartViewModel()
    var openedIndex = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblv.register(UINib(nibName: "CategoryCell", bundle: .main), forCellReuseIdentifier: "mycell")
        self.tblv.register(UINib(nibName: "CategoryHeader", bundle: .main), forHeaderFooterViewReuseIdentifier: "myheader")
        self.initialization()
    }
    
    // MARK: - Initialization
    
    func initialization() {
        self.vm.loadFromBundle(fileName: "menu")
    }
    
    func updateUI() {
        let amount = self.vm.totalAmount()
        if amount > 0 {
            btnPlaceOrder.setTitle("Place Order ₹ \(self.vm.totalAmount())", for: .normal)
        }
        else {
            btnPlaceOrder.setTitle("Cart is Empty", for: .normal)
        }

    }
    
    @IBAction func btnSectionClicked(_ sender: UIButton) {
        if self.openedIndex >= 0 {
            if sender.tag == openedIndex {
                self.vm.cartCatgories[sender.tag].isOpened = !self.vm.cartCatgories[sender.tag].isOpened
            } else {
                self.vm.cartCatgories[sender.tag].isOpened = true
                self.vm.cartCatgories[openedIndex].isOpened = false
            }
        } else {
            self.vm.cartCatgories[sender.tag].isOpened = true
        }
        self.openedIndex = sender.tag
        self.tblv.reloadData()
    }
}

extension CartController: ItemQuantityListener {
    func itemQuantityChanged(indexpath: IndexPath, model: Item) {
        if self.vm.cartCatgories.count > indexpath.section, self.vm.cartCatgories[indexpath.section].catItem != nil, self.vm.cartCatgories[indexpath.section].catItem?.count ?? 0 > indexpath.row {
            self.vm.cartCatgories[indexpath.section].catItem?[indexpath.row] = model
            self.updateUI()
        }
    }
}

extension CartController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.vm.cartCatgories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.vm.cartCatgories[section].isOpened {
            return self.vm.cartCatgories[section].catItem?.count ?? 0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let model = self.vm.cartCatgories[indexPath.section].catItem?[indexPath.row] {
            let mycell: CategoryCell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! CategoryCell
            mycell.delegate = self
            mycell.configureCell(model: model, indexPath: indexPath)
            return mycell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: CategoryHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "myheader") as! CategoryHeader
        header.configureCell(model: self.vm.cartCatgories[section])
        header.btnClicked.tag = section
        header.btnClicked.addTarget(self, action: #selector(btnSectionClicked(_:)), for: .touchUpInside)
        return header
    }
}


extension CartController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
