//
//  ImkbValueCellTableViewCell.swift
//  veriParkAkif
//
//  Created by Akif_PC on 7.03.2018.
//  Copyright © 2018 akif demirezen. All rights reserved.
//

import UIKit

class ImkbValueCellTableViewCell: UITableViewCell {
    @IBOutlet weak var labelSymbolName: CustomLabel!
    @IBOutlet weak var imageViewOfState: UIImageView!
    @IBOutlet weak var labelTime: CustomLabel!
    @IBOutlet weak var labelSell: CustomLabel!
    @IBOutlet weak var labelBuy: CustomLabel!
    @IBOutlet weak var labelVolume: CustomLabel!
    @IBOutlet weak var labelDifference: CustomLabel!
    @IBOutlet weak var labelPrice: CustomLabel!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil)   }
    var user = UserModel()
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureWithItem(item : ResponseModelIndexInfo){
        
        self.labelSymbolName.text(name: item.symbol)
        self.labelBuy.text(name :String(item.buying))
        self.labelSell.text(name :String(item.selling))
        self.labelTime.text(name :String(item.hour))
        self.labelDifference.text(name :String(item.difference))
        self.labelPrice.text(name :"\(String(item.price)) TL")
        self.labelVolume.text(name :String(item.volume))
        self.imageViewOfState.image = item.imageOfState
        
    }
    
    
}

