//
//  PostConnection.swift
//  Swift3ServiceConnection
//
//  Created by Mac on 2.12.2016.
//  Copyright © 2016 Mac. All rights reserved.
//

import Foundation
import Alamofire

class PostConnection
{
    var delegate : ConnectionDelegate?
    func makePostConnection( url: String ,urlRequest : URLRequest, httpMethod : String)
    {
        Alamofire.request(urlRequest)
            .responseString { response in
                if let xmlString = response.result.value {
                    print("Response : \(xmlString)")
                    self.delegate?.getDataFromService(xmlData: xmlString)
                }
        }
    }
}
