//
//  CategoryHeader.swift
//  ShoppingMart
//
//  Created by Manish Ankat on 19/09/22.
//

import UIKit

class CategoryHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var lblCaterogryCount: UILabel!
    @IBOutlet weak var imgvExpand: UIImageView!
    @IBOutlet weak var btnClicked: UIButton!
    
    func configureCell(model: Category) {
        self.lblCategoryName.text = model.catName
        self.lblCaterogryCount.text = "\(model.catItem?.count ?? 0)"
        if model.isOpened {
            self.imgvExpand.image = UIImage(named: "icn_arrow_down")
        } else {
            self.imgvExpand.image = UIImage(named: "icn_arrow_right")
        }
    }

}
