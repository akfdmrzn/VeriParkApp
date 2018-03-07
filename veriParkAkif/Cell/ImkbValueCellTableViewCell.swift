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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
