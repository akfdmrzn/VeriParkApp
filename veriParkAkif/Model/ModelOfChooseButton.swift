//
//  ModelOfChooseButton.swift
//  veriParkAkif
//
//  Created by akif demirezen on 11/03/2018.
//  Copyright © 2018 akif demirezen. All rights reserved.
//

import UIKit

class ModelOfChooseButton: NSObject {

    var chooseImkbList = InfoChooseButton()
    
}
struct InfoChooseButton{
    var nameList : [String] = ["Hisse Ve Endeksler","IMKB Yükselenler","IMKB Düşenler","IMKB Hacme Göre -30","IMKB Hacme Göre -50","IMKB Hacme Göre -100"]
    var idList : [Int] = [0,1,2,3,4,5]
    var imageList : [UIImage] = [#imageLiteral(resourceName: "stats"),#imageLiteral(resourceName: "rising-bar-graph-with-arrow-up"),#imageLiteral(resourceName: "bars-chart-down"),#imageLiteral(resourceName: "thirty"),#imageLiteral(resourceName: "fifty"),#imageLiteral(resourceName: "hundread")]
}
