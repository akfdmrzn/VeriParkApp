//
//  ModelIndexInfo.swift
//  veriParkAkif
//
//  Created by Akif_PC on 8.03.2018.
//  Copyright © 2018 akif demirezen. All rights reserved.
//

import UIKit
import AEXML
import Alamofire
import SWXMLHash

protocol  IndexInfoDelegate : class{
    func IndexInfoDelegate(isCorrect: Bool, data : [ResponseModelIndexInfo],message : String)
}
class ModelIndexInfo: ConnectionDelegate {

    var encryptedData : String = ""
    var postConnection = PostConnection()
    var indexInfoDelegate : IndexInfoDelegate?
    
    init() {
        self.postConnection.delegate = self
        self.encryptedData = ""
    }
    func sendDataToService() {
        
        let soapRequest = AEXMLDocument()
        let envelopeAttributes =   ["xmlns:xsi":"http://www.w3.org/2001/XMLSchema-instance","xmlns:xsd":"http://www.w3.org/2001/XMLSchema",
                                    "xmlns:soap":"http://schemas.xmlsoap.org/soap/envelope/"]
        let envelope = soapRequest.addChild(name: "soap:Envelope", attributes: envelopeAttributes)
        let body = envelope.addChild(name: "soap:Body")
        let geoIp = body.addChild(name:"GetForexStocksandIndexesInfo", attributes:["xmlns":"http://tempuri.org/"])
        let son = geoIp.addChild(name: "request",  attributes: [:])
      
        son.addChild(name: "RequestKey", value: self.encryptedData, attributes: [:])
        son.addChild(name: "Period", value: "Day", attributes: [:])
      
        let soapLenth = String(soapRequest.xml.characters.count)
        let theURL = URL(string: "http://mobileexam.veripark.com/mobileforeks/service.asmx")
     
        var mutableR = URLRequest(url: theURL!)
        mutableR.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        mutableR.addValue("http://tempuri.org/GetForexStocksandIndexesInfo", forHTTPHeaderField: "SOAPAction")
        mutableR.addValue(soapLenth, forHTTPHeaderField: "Content-Length")
        mutableR.httpMethod = "POST"
        mutableR.httpBody = soapRequest.xml.data(using: String.Encoding.utf8)
        postConnection.makePostConnection(url: "http://mobileexam.veripark.com/mobileforeks/service.asmx", urlRequest: mutableR, httpMethod: "POST")
        
    }
    func getDataFromService(xmlData: String) {
     
        var indexInfoList : [ResponseModelIndexInfo] = []
        let myXml = SWXMLHash.parse(xmlData)
        let body =  myXml["soap:Envelope"]["soap:Body"]["GetForexStocksandIndexesInfoResponse"]["GetForexStocksandIndexesInfoResult"]["RequestResult"]["Success"].element
        if !Bool((body?.text)!)! {
                self.indexInfoDelegate?.IndexInfoDelegate(isCorrect: false, data: [], message: "")
            }
            for elem in myXml["soap:Envelope"]["soap:Body"]["GetForexStocksandIndexesInfoResponse"]["GetForexStocksandIndexesInfoResult"]["StocknIndexesResponseList"]["StockandIndex"].all {
             
                var model = ResponseModelIndexInfo()
                if let symbol = elem["Symbol"].element!.text as? String {
                    model.symbol = symbol
                }
                if let hour = elem["Hour"].element?.text {
                    if hour != ""{
                        model.hour = Int(hour)!
                    }
                }
                if let price = elem["Price"].element?.text{
                    model.price = Double(price)!
                }
                if let difference =  elem["Difference"].element?.text{
                    model.difference = Double(difference)!
                    if (elem["Difference"].element?.text.contains("-"))!{
                        model.imageOfState = #imageLiteral(resourceName: "chevron-arrow-down")
                    }
                    else{
                        model.imageOfState = #imageLiteral(resourceName: "chevron-arrow-up")
                    }
                }
                if let volume = elem["Volume"].element?.text{
                    model.volume = Double(volume)!
                }
                if let buying =  elem["Buying"].element?.text{
                    model.buying = Double(buying)!
                }
                if let selling = elem["Selling"].element?.text{
                    model.selling = Double(selling)!
                }
                if let daypeakPrice = elem["DayPeakPrice"].element?.text{
                    model.dayPeakPrice = Double(daypeakPrice)!
                }
                if let daylowestPrice = elem["DayLowestPrice"].element?.text{
                    model.dayLowestPrice = Double(daylowestPrice)!
                }
                if let total =  elem["Total"].element?.text{
                    model.total = Int(total)!
                }
                if let isIndex = elem["IsIndex"].element?.text{
                    model.isIndex = Bool(isIndex)!
                }
               indexInfoList.append(model)
            }
        self.indexInfoDelegate?.IndexInfoDelegate(isCorrect: true, data: indexInfoList, message: "")
    }
    func getError(errMessage: String) {
        print("service error")
    }
}
