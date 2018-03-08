//
//  IndexDetailViewController.swift
//  veriParkAkif
//
//  Created by Akif_PC on 8.03.2018.
//  Copyright © 2018 akif demirezen. All rights reserved.
//

import UIKit

class IndexDetailViewController: BaseController {

    @IBOutlet weak var labelOfSymbolName: CustomLabel!
    @IBOutlet weak var labelOfPrice: CustomLabel!
    @IBOutlet weak var labelOfChange: CustomLabel!
    @IBOutlet weak var labelOfHighest: CustomLabel!
    @IBOutlet weak var labelOfLowest: CustomLabel!
    @IBOutlet weak var labelOfEnd: CustomLabel!
    @IBOutlet weak var labelOfVolume: CustomLabel!
    @IBOutlet weak var labelOfAmount: CustomLabel!
    @IBOutlet weak var labelOfTitle: CustomLabel!
    
    var infoIndex = ResponseModelIndexInfo()
    var graphDateList = [ResponseModelPeriod]()
    var modelPeriod  = ModelOfPeriod()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.labelOfSymbolName.text = self.infoIndex.symbol
        self.labelOfTitle.text = self.infoIndex.symbol
        self.labelOfPrice.text = String(self.infoIndex.price)
        self.labelOfChange.text = String(self.infoIndex.difference)
        self.labelOfHighest.text = String(self.infoIndex.dayPeakPrice)
        self.labelOfLowest.text = String(self.infoIndex.dayLowestPrice)
        self.labelOfEnd.text = String(self.infoIndex.hour)
        self.labelOfVolume.text = String(self.infoIndex.volume)
        self.labelOfAmount.text = String(self.infoIndex.total)
        
        self.modelPeriod.periodDelegate = self
        self.modelPeriod.encryptedData = encryptedData
        self.modelPeriod.choosenSymbol = self.infoIndex.symbol
        self.modelPeriod.sendDataToService()
        self.indicatorShow(status: true)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
extension IndexDetailViewController : PeriodDelegate{
    func getPeriod(isCorrect: Bool, data: [ResponseModelPeriod], message: String) {
        self.indicatorShow(status: false)
        if isCorrect{
            self.graphDateList = data
            print(self.graphDateList[0].date)
        }
        else{
            
        }
    }
    
}

