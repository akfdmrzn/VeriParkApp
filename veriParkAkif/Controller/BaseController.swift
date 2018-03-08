//
//  BaseController.swift
//  veriParkAkif
//
//  Created by Akif_PC on 8.03.2018.
//  Copyright © 2018 akif demirezen. All rights reserved.
//

import UIKit
import NVActivityIndicatorView



class BaseController: UIViewController {
    
    var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
    var blurEffectView : UIVisualEffectView?
    var indicator :  NVActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func indicatorShow(status : Bool){
        if !status{
            self.blurEffectView?.removeFromSuperview()
            indicator?.stopAnimating()
        }
        else{
            self.blurEffectView =  UIVisualEffectView(effect: self.blurEffect)
            self.blurEffectView?.frame = view.bounds
            self.blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.view.addSubview(blurEffectView!)
            
            let color = UIColor(red: 238/255, green: 173/255, blue: 14/255, alpha: 1.0)
            let frame = CGRect(x: (self.view.frame.width/2)*0.7, y: (self.view.frame.height/2)*0.7, width: self.view.frame.width/3, height: self.view.frame.height/3)
            self.indicator =  NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.ballSpinFadeLoader, color: color, padding: NVActivityIndicatorView.DEFAULT_PADDING )
            
            self.view.addSubview(indicator!)
            indicator?.startAnimating()
        }
    }
    
}
