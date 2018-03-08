//
//  ModelOfPeriod.swift
//  veriParkAkif
//
//  Created by akif demirezen on 09/03/2018.
//  Copyright © 2018 akif demirezen. All rights reserved.
//

import UIKit
import AEXML
import Alamofire
import SWXMLHash

protocol  PeriodDelegate : class{
    func getPeriod(isCorrect: Bool, data : [ResponseModelPeriod],message : String)
}


class ModelOfPeriod: ConnectionDelegate {

    var encryptedData : String = ""
    var postConnection = PostConnection()
    var periodDelegate : PeriodDelegate?
    var choosenSymbol : String = ""
    
    init() {
        self.postConnection.delegate = self
        self.encryptedData = ""
        self.choosenSymbol = ""
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
        son.addChild(name: "RequestedSymbol", value: self.choosenSymbol, attributes: [:])
        son.addChild(name: "Period", value: "Month", attributes: [:])
        
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
        
        var periodList : [ResponseModelPeriod] = []
        let myXml = SWXMLHash.parse(xmlData)
        let body =  myXml["soap:Envelope"]["soap:Body"]["GetForexStocksandIndexesInfoResponse"]["GetForexStocksandIndexesInfoResult"]["RequestResult"]["Success"].element
        if !Bool((body?.text)!)! {
            self.periodDelegate?.getPeriod(isCorrect: false, data: [], message: "")
        }
        for elem in myXml["soap:Envelope"]["soap:Body"]["GetForexStocksandIndexesInfoResponse"]["GetForexStocksandIndexesInfoResult"]["StocknIndexesResponseList"]["StocknIndexesGraphicInfos"]["StockandIndexGraphic"].all {
           
            let model = ResponseModelPeriod()
            
            if let price = elem["Price"].element?.text{
                model.price = Double(price)!
            }
            if let date = elem["Date"].element!.text as? String {
                model.date = date
            }
            periodList.append(model)
            
        }
        self.periodDelegate?.getPeriod(isCorrect: true, data: periodList, message: "")
        
    }
    func getError(errMessage: String) {
        print("service error")
    }
}
