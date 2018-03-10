//
//  UserModel.swift
//  veriParkAkif
//
//  Created by Akif_PC on 9.03.2018.
//  Copyright © 2018 akif demirezen. All rights reserved.
//

import UIKit

class UserModel: NSObject {
 
    
   private var _nightModeEnabled : Bool = false
    
    var nightModeEnabled : Bool {
        get {
            if let nightModeEnabled = UserDefaults.standard.value(forKey: "nightModeEnabled") as? Bool {
                return nightModeEnabled
            }
            else {
                return false
            }
        }
        set {
            self._nightModeEnabled = newValue
            UserDefaults.standard.set(self._nightModeEnabled, forKey: "nightModeEnabled")
        }
    }
}
