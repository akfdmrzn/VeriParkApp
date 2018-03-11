//
//  LeftMenuViewController.swift
//  veriParkAkif
//
//  Created by Akif_PC on 7.03.2018.
//  Copyright © 2018 akif demirezen. All rights reserved.
//

import UIKit

class LeftMenuViewController: UIViewController {

    var user = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if user.nightModeEnabled{
            self.view.backgroundColor = UIColor.black
        }
        else{
            self.view.backgroundColor = UIColor.white
        }
        
        
    }
   
    
    @IBAction func btnAct(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

}
