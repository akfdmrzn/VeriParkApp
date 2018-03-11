//
//  TabBarSetup.swift
//  veriParkAkif
//
//  Created by akif demirezen on 10/03/2018.
//  Copyright © 2018 akif demirezen. All rights reserved.
//

import UIKit

protocol TabbarSetupControl: class {
    // Add more param if needed
    func setupTabBar(color: UIColor)
}
extension TabbarSetupControl where Self: MainPageViewController {
    // Default implementation
    func setupTabBar(color: UIColor) {
        self.tabBarController?.tabBar.barTintColor = color
    }
    
}

