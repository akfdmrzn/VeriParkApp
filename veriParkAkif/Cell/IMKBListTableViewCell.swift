//
//  IMKBListTableViewCell.swift
//  veriParkAkif
//
//  Created by akif demirezen on 10/03/2018.
//  Copyright © 2018 akif demirezen. All rights reserved.
//

import UIKit

class IMKBListTableViewCell: UITableViewCell {
    @IBOutlet weak var labelSymbol: CustomLabel!
    @IBOutlet weak var labelName: CustomLabel!
    
    @IBOutlet weak var labelGain: CustomLabel!
    @IBOutlet weak var labelFund: CustomLabel!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil)   }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWithItem(item : ResponseModelIMKBList){
        self.labelSymbol.text(name: item.symbol)
        self.labelName.text(name: item.name)
        self.labelGain.text(name: item.gain)
        self.labelFund.text(name: item.fund)
        
    }
    
    
}
