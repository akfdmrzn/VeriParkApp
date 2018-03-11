//
//  ModelImkbList.swift
//  veriParkAkif
//
//  Created by akif demirezen on 10/03/2018.
//  Copyright © 2018 akif demirezen. All rights reserved.
//

import UIKit
import AEXML
import Alamofire
import SWXMLHash

protocol  ImkbListDelegate : class{
    func getImkbList(isCorrect: Bool, data : [ResponseModelIMKBList],message : String)
}
class ModelImkbList: ConnectionDelegate {
    
    var encryptedData : String = ""
    var imkbType : Int = 0
    var imkbListName : String = ""
    var imkbName : String = ""
    var postConnection = PostConnection()
    var imkbListDelegate : ImkbListDelegate?
    
    init() {
        self.postConnection.delegate = self
        self.encryptedData = ""
        self.imkbType = 0
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
        
        var imkbListArray : [ResponseModelIMKBList] = []
        let myXml = SWXMLHash.parse(xmlData)
        let body =  myXml["soap:Envelope"]["soap:Body"]["GetForexStocksandIndexesInfoResponse"]["GetForexStocksandIndexesInfoResult"]["RequestResult"]["Success"].element
        if !Bool((body?.text)!)! {
            self.imkbListDelegate?.getImkbList(isCorrect: false, data: [], message: "")
        }
        
        switch self.imkbType {
        case 3:
            print("akifimkb30")
            self.imkbListName = "IMKB30List"
            self.imkbName = "IMKB30"
            
        case 4:
            print("akifimkb50")
            self.imkbListName = "IMKB50List"
            self.imkbName = "IMKB50"
        case 5:
            print("akifimkb100")
            self.imkbListName = "IMKB100List"
            self.imkbName = "IMKB100"
        default:
            break;
        }
        for elem in myXml["soap:Envelope"]["soap:Body"]["GetForexStocksandIndexesInfoResponse"]["GetForexStocksandIndexesInfoResult"][imkbListName][imkbName].all{
            let model = ResponseModelIMKBList()
                if let symbol = elem["Symbol"].element?.text{
                model.symbol = symbol
                }
                if let name = elem["Name"].element?.text{
                model.name = name
                }
                if let gain = elem["Gain"].element?.text{
                model.gain = gain
                }
                if let fund = elem["Fund"].element?.text{
                model.fund = fund
                }
                imkbListArray.append(model)
            }
        self.imkbListDelegate?.getImkbList(isCorrect: true, data: imkbListArray, message: "")
    }
    func getError(errMessage: String) {
        print("service error")
    }
}
