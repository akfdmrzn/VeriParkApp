//
//  ImkbDetailTableViewCell.swift
//  veriParkAkif
//
//  Created by Akif_PC on 7.03.2018.
//  Copyright © 2018 akif demirezen. All rights reserved.
//

import UIKit

class ImkbDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewOfProcess: UIImageView!
    @IBOutlet weak var viewForBorder: UIView!
    @IBOutlet weak var labelOfProcessName: CustomLabel!
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil)   }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewForBorder.layer.borderWidth = 3.0
        self.viewForBorder.layer.borderColor  = UIColor(red: 200.0/255.0, green:94.0/255.0 , blue: 66.0/255.0, alpha: 1.0).cgColor
        self.viewForBorder.layer.cornerRadius = 5.0
        self.labelOfProcessName.clipsToBounds = true
        self.labelOfProcessName.layer.cornerRadius = 5.0
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

