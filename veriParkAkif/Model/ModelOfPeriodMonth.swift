//
//  ModelOfPeriodMonth.swift
//  veriParkAkif
//
//  Created by Akif_PC on 9.03.2018.
//  Copyright © 2018 akif demirezen. All rights reserved.
//

import UIKit



// Dökümanda en sondaki , price ve date dönen servis true  request is succesfully complted dönmesine rağmen price ve date değerleri gelmediğinden dolayı, uygulamada grafği nasıl kullandığımı görmeniz için Sadece bu kısımda kendi oluşturduğum datayı kullanacağım.
// NOTT :  Detay Sayfasındaki her değer doğru yalnızca grafikteki değerler manual

class ModelOfPeriodMonth : NSObject {

    var price : Double = 0.0
    var date : Double = 0.0
    var dateList : [ModelOfPeriodMonth] = []
    
    func generateRandomNumber(min min: Int, max: Int) -> Int {
        let randomNum = Int(arc4random_uniform(UInt32(max) - UInt32(min)) + UInt32(min))
        return randomNum
    }
    func  createDate(){
        for index in 1...8{
            let model = ModelOfPeriodMonth()
            self.price = Double(self.generateRandomNumber(min: 10, max: 50))
            self.date = Double("1\(index)")!
            self.dateList.append(model)
        }
    }
    
}
