//
//  IndexDetailViewController.swift
//  veriParkAkif
//
//  Created by Akif_PC on 8.03.2018.
//  Copyright © 2018 akif demirezen. All rights reserved.
//

import UIKit
import SwiftChart


class IndexDetailViewController: BaseController {

    @IBOutlet weak var viewOfChart: Chart!
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
    var modelPeriod  = ModelOfPeriod() //Servisteki model
    var modelPeriodMonth = ModelOfPeriodMonth() //Elle kendim data girdiğim model
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modelPeriodMonth.createDate()
        self.setMyManualDataForGraph()
        
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

    func setMyManualDataForGraph(){
        
        
//        let data = [
//            (x: self.modelPeriodMonth.dateList[0].price, y: self.modelPeriodMonth.dateList[0].date),
//            (x: self.modelPeriodMonth.dateList[1].price, y: self.modelPeriodMonth.dateList[1].date),
//            (x: self.modelPeriodMonth.dateList[2].price, y: self.modelPeriodMonth.dateList[2].date),
//            (x: self.modelPeriodMonth.dateList[3].price, y: self.modelPeriodMonth.dateList[3].date),
//            (x: self.modelPeriodMonth.dateList[4].price, y: self.modelPeriodMonth.dateList[4].date),
//            (x: self.modelPeriodMonth.dateList[5].price, y: self.modelPeriodMonth.dateList[5].date),
//            (x: self.modelPeriodMonth.dateList[6].price, y: self.modelPeriodMonth.dateList[6].date),
//            (x: self.modelPeriodMonth.dateList[7].price, y: self.modelPeriodMonth.dateList[7].date)
//        ]
        let series = ChartSeries([0, 6, 2, 8, 4, 7, 3, 10, 8])
        series.area = true
        self.viewOfChart.add(series)
        

        self.viewOfChart.xLabels = [self.modelPeriodMonth.dateList[0].date,self.modelPeriodMonth.dateList[1].date,self.modelPeriodMonth.dateList[2].date,self.modelPeriodMonth.dateList[3].date,self.modelPeriodMonth.dateList[4].date,self.modelPeriodMonth.dateList[5].date,self.modelPeriodMonth.dateList[6].date,self.modelPeriodMonth.dateList[7].date]
        self.viewOfChart.xLabelsFormatter = { String(Int(round($1))) + " Mart" }
    }
}
extension IndexDetailViewController : PeriodDelegate{
    func getPeriod(isCorrect: Bool, data: [ResponseModelPeriod], message: String) {
        self.indicatorShow(status: false)
        if isCorrect{
            self.graphDateList = data
            
        }
        else{
            
        }
    }
    
}

