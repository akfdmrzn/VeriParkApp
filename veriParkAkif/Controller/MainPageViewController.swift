//
//  MainPageViewController.swift
//  veriParkAkif
//
//  Created by Akif_PC on 8.03.2018.
//  Copyright © 2018 akif demirezen. All rights reserved.
//

import UIKit

class MainPageViewController: BaseController {
    
    
    var modelEncrypt = ModelEncrypt()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modelEncrypt.encryptDelegate = self
        self.modelEncrypt.sendDataToService()
    }
}
extension MainPageViewController : EncryptDelegate{
    func isEncrypted(isCorrect: Bool, data: String, message: String) {
        if isCorrect{
            print(data)
            encryptedData = data
            
        }
        else{
            print("error data")
        }
    }
}
