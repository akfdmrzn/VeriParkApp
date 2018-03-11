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

    @IBOutlet weak var imageViewOfState: UIImageView!
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
        self.imageViewOfState.image = self.infoIndex.imageOfState
        
        self.modelPeriod.periodDelegate = self
        self.modelPeriod.encryptedData = encryptedData
        self.modelPeriod.choosenSymbol = self.infoIndex.symbol
        self.modelPeriod.sendDataToService()
        self.indicatorShow(status: true)
        
        
    }

    func setMyManualDataForGraph(){
 
        //Yalnızca grafikte gösterilecek Veriler servisten boş olarak geldiği için burada manual olarak atama yapıyorum.
        let data = [
            (x: 00.03, y: 0),
            (x: 01.03, y: 3.1),
            (x: 04.03, y: 2),
            (x: 05.03, y: 4.2),
            (x: 06.03, y: 5),
            (x: 07.03, y: 9),
            (x: 08.3, y: 8)
        ]
        let series = ChartSeries(data: data)
        series.area = true
        viewOfChart.add(series)
       
        
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

