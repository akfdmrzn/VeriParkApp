//
//  NavigationBarSetup.swift
//  veriParkAkif
//
//  Created by akif demirezen on 10/03/2018.
//  Copyright © 2018 akif demirezen. All rights reserved.
//

import UIKit

protocol NavigationBarSetUpProtocol: class {
    // Add more param if needed
    func setupNavigationBar(color: UIColor,textColor : UIColor)
}
extension NavigationBarSetUpProtocol where Self: MainPageViewController {
    // Default implementation
    func setupNavigationBar(color: UIColor,textColor : UIColor) {
        self.navigationController?.navigationBar.barTintColor = color
        self.navigationController?.navigationBar.tintColor = textColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: textColor]
        
    }
    
}

