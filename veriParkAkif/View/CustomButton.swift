//
//  CustomButton.swift
//  KonusarakOgren
//
//  Created by akif demirezen on 19/07/2017.
//  Copyright © 2017 KonusarakOgren. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    
//    override func setTitle(_ title: String?, for state: UIControlState) {
//        title
//    }
    
    var fontName = "HelveticaNeue"
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var buttonTextFontSize: CGFloat = 0 {
        didSet {
            titleLabel?.font = UIFont(name: fontName, size: buttonTextFontSize * UIScreen.main.bounds.size.height/667)
        }
    }
    
    @IBInspectable var isBold: Bool = true {
        didSet {
            if isBold {
                fontName = "HelveticaNeue-Bold"
            } else {
                fontName = "HelveticaNeue"
            }
            
            titleLabel?.font = UIFont(name: fontName, size: buttonTextFontSize * UIScreen.main.bounds.size.height/667)
        }
    }
    
 
    
    func returnTextFont()-> String {
        if isBold == true {
            return "HelveticaNeue-Bold"
        } else {
            return "HelveticaNeue-Bold"
        }
    }
    
}
