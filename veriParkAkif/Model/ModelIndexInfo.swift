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
    func IndexInfoDelegate(isCorrect: Bool, data : ResponseModelIndexInfo,message : String)
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
     
            let myXml = SWXMLHash.parse(xmlData)
            let body =  myXml["soap:Envelope"]["soap:Body"]["GetForexStocksandIndexesInfoResponse"]["GetForexStocksandIndexesInfoResult"]["RequestResult"]["Success"].element
        
        if !Bool(body.text) {
                self.indexInfoDelegate?.getError(isCorrect: true)
            }
            for elem in myXml["soap:Envelope"]["soap:Body"]["GetForexStocksandIndexesInfoResponse"]["GetForexStocksandIndexesInfoResult"]["StocknIndexesResponseList"]["StockandIndex"].all {
                let model = ResponseModelIndexInfo()
                if let symbol = elem["Symbol"].element!.text as? String {
                    model.symbol = symbol
                }
                if elem["Hour"].element?.text != "" {
                    model.hour = Int(elem["Hour"].element!.text)!
                }
                if elem["Price"].element?.text != "" {
                    model.price = Double(elem["Price"].element!.text)!
                }
                if elem["Difference"].element?.text != "" {
                    model.difference = Double(elem["Difference"].element!.text)!
                    if (elem["Difference"].element?.text.contains("-"))!{
                        model.imageOfState = #imageLiteral(resourceName: "arrred")
                    }
                    else{
                        model.imageOfState = #imageLiteral(resourceName: "arrgreen")
                    }
                }
                if elem["Volume"].element?.text != "" {
                    model.volume = Double(elem["Volume"].element!.text)!
                    
                }
                if let buying =  elem["Buying"].element?.text as? Double{
                    model.buying = buying
                }
                if elem["Selling"].element?.text != "" {
                    model.selling = Double(elem["Selling"].element!.text)!
                }
                if elem["DayPeakPrice"].element?.text != "" {
                    model.dayPeakPrice = Double(elem["DayPeakPrice"].element!.text)!
                }
                if elem["DayLowestPrice"].element?.text != "" {
                    model.dayLowestPrice = Double(elem["DayLowestPrice"].element!.text)!
                }
                if elem["Total"].element?.text != "" {
                    model.total = Int(elem["Total"].element!.text)!
                }
                if elem["IsIndex"].element?.text != "" {
                    model.isIndex = Bool(elem["IsIndex"].element!.text)!
                }
                
                self.tempItemOfIndex.append(model)
                
            }
            self.indexDelegate?.didRecieveDataUpdate(model: self.tempItemOfIndex)
     
            
        
    }
    func getError(errMessage: String) {
        
    }
}
