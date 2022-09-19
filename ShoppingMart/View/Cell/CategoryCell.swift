//
//  CategoryCell.swift
//  ShoppingMart
//
//  Created by Manish Ankat on 19/09/22.
//

import UIKit

protocol ItemQuantityListener {
    func itemQuantityChanged(indexpath: IndexPath, model: Item)
}

class CategoryCell: UITableViewCell {

    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblItemPrice: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var vQauntity: UIStackView!
    
    var indexpath: IndexPath?
    var model: Item?
    var delegate: ItemQuantityListener?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(model: Item, indexPath: IndexPath) {
        self.model = model
        self.lblItemName.text = model.name
        self.lblItemPrice.text = "₹ \(model.price ?? 0)"
        self.lblQuantity.text = "\(self.model?.quatity ?? 0)"
        self.showAddView(show: model.quatity == 0)
        self.indexpath = indexPath
        if !(model.instock ?? true) {
            self.btnAdd.layer.borderColor = UIColor.darkGray.cgColor
            self.btnAdd.tintColor = UIColor.darkGray
        } else {
            self.btnAdd.layer.borderColor = UIColor.orange.cgColor
            self.btnAdd.tintColor = UIColor.orange
        }
    }
    
    func updateQuantity() {
        self.lblQuantity.text = "\(self.model?.quatity ?? 0)"
        if let delegate = self.delegate, let indexpath = self.indexpath, let model = self.model {
            delegate.itemQuantityChanged(indexpath: indexpath, model: model)
        }
    }
    
    func showAddView(show: Bool) {
        self.btnAdd.isHidden = !show
        self.vQauntity.isHidden = show
    }
    
    @IBAction func btnAddClicked(_ sender: Any) {
        if self.model != nil, (self.model?.instock ?? true) {
            self.model?.quatity = 1
            self.updateQuantity()
            self.showAddView(show: false)
        }
        
    }
    
    @IBAction func btnMinusClicked(_ sender: Any) {
        if self.model != nil {
            var qty = (self.model?.quatity ?? 1)
            qty = qty - 1
            self.model?.quatity = qty
            self.updateQuantity()
            self.showAddView(show: qty == 0)
        }
    }
    
    @IBAction func btnPlusClicked(_ sender: Any) {
        if self.model != nil {
            var qty = (self.model?.quatity ?? 1)
            qty = qty + 1
            self.model?.quatity = qty
            self.updateQuantity()
        }
    }
}
