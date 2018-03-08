//
//  ModelEncrypt.swift
//  veriParkAkif
//
//  Created by Akif_PC on 8.03.2018.
//  Copyright © 2018 akif demirezen. All rights reserved.
//

import UIKit
import AEXML
import Alamofire
import SWXMLHash


protocol  EncryptDelegate : class{
    func isEncrypted(isCorrect: Bool, data : String,message : String)
}

class ModelEncrypt : ConnectionDelegate {
    var sendParameterDate : String = ""
    var postConnection = PostConnection()
    var encryptDelegate : EncryptDelegate?
   
    init() {
        self.postConnection.delegate = self
        self.sendParameterDate = self.getCurrentDate()
    }
    func sendDataToService() {
        //Request Settings
        let soapRequest = AEXMLDocument()
        let envelopeAttributes =   ["xmlns:xsi":"http://www.w3.org/2001/XMLSchema-instance",
                                    "xmlns:xsd":"http://www.w3.org/2001/XMLSchema",
                                    "xmlns:soap":"http://schemas.xmlsoap.org/soap/envelope/"]
        let envelope = soapRequest.addChild(name: "soap:Envelope", attributes: envelopeAttributes)
        let body = envelope.addChild(name: "soap:Body")
        let geoIp = body.addChild(name:"Encrypt", attributes:["xmlns":"http://tempuri.org/"])
        geoIp.addChild(name: "request", value: self.sendParameterDate, attributes: [:])
        let soapLenth = String(soapRequest.xml.characters.count)
        let theURL = URL(string: "http://mobileexam.veripark.com/mobileforeks/service.asmx")
        var mutableR = URLRequest(url: theURL!)
        mutableR.httpMethod = "POST"
        mutableR.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        mutableR.addValue("http://tempuri.org/Encrypt", forHTTPHeaderField: "SOAPAction")
        mutableR.addValue(soapLenth, forHTTPHeaderField: "Content-Length")
        mutableR.httpBody = soapRequest.xml.data(using: String.Encoding.utf8)
       
        postConnection.makePostConnection(url: "http://mobileexam.veripark.com/mobileforeks/service.asmx", urlRequest: mutableR, httpMethod: "POST")
        
    }
    func getDataFromService(xmlData: String) {
        let xml = SWXMLHash.parse(xmlData)
            if let body =  xml["soap:Envelope"]["soap:Body"]["EncryptResponse"]["EncryptResult"].element{
                self.encryptDelegate?.isEncrypted(isCorrect: true, data: body.text , message: "")
            }
            else{
                self.encryptDelegate?.isEncrypted(isCorrect: false, data: "", message: "")
            }
    }
    func getError(errMessage: String) {
        print("service error")
    }
   
    //Get Current Date For Encrypt Data
    func getCurrentDate() -> String {
        let date = Date()
        var calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day,.hour,.minute], from: date)
        var year : Int =  components.year!
        var month : String = ""
        var day : String = ""
        var hour : String = ""
        var minutes : String = ""
        if components.month! < 10 {
            month = "0\(components.month!)"
        }
        else{
            month = String(components.month!)
        }
        if components.day! < 10 {
            day = "0\(components.day!)"
        }
        else{
            day = String(components.day!)
        }
        if components.hour! < 10 {
            hour = "0\(components.hour!)"
        }
        else{
            hour = String(components.hour!)
        }
        if components.minute! < 10 {
            minutes = "0\(components.minute!)"
        }
        else{
            minutes = String(components.minute!)
        }
        return "RequestIsValid\(day):\(month):\(year) \(hour):\(minutes)"
    }
}



