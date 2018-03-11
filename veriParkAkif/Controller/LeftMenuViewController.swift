//
//  LeftMenuViewController.swift
//  veriParkAkif
//
//  Created by Akif_PC on 7.03.2018.
//  Copyright © 2018 akif demirezen. All rights reserved.
//

import UIKit

class LeftMenuViewController: UIViewController {

    @IBOutlet weak var switchMode: UISwitch!
    var user = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.switchMode.isUserInteractionEnabled = true
        if user.nightModeEnabled{
            self.switchMode.isOn = true
        }
        else{
            self.switchMode.isOn = false
        }
        self.switchMode.isUserInteractionEnabled = true
        switchMode.addTarget(self, action: #selector(self.switchChanged(_:)), for: UIControlEvents.valueChanged)
        
        
    }
    @objc func switchChanged(_ mySwitch: UISwitch) {
        if switchMode.isOn {
            user.nightModeEnabled = true
            self.updateFocusIfNeeded()
        } else {
            user.nightModeEnabled = false
            self.updateFocusIfNeeded()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

}
