//
//  ImkbDetailTableViewCell.swift
//  veriParkAkif
//
//  Created by Akif_PC on 7.03.2018.
//  Copyright © 2018 akif demirezen. All rights reserved.
//

import UIKit

class ImkbDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var labelOfProcessName: CustomLabel!
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil)   }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
