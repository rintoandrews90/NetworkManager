//
//  NetworkManager.swift
//  NetworkManager
//
//  Created by Rinto Andrews on 25/07/19.
//  Copyright © 2019 Rinto Andrews. All rights reserved.
//

import Foundation

enum HttpMethod:String{
    case get = "get"
    case post = "post"
}

let BaseURL : String = "http://dummy.restapiexample.com/api/v1/"

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func dataTask(serviceURL:String,httpMethod:HttpMethod,parameters:[String:String]?,completion:@escaping (AnyObject?, Error?) -> Void) -> Void {
       
        requestResource(serviceURL: serviceURL, httpMethod: httpMethod, parameters: parameters, completion: completion)
    }
    
    private func requestResource(serviceURL:String,httpMethod:HttpMethod,parameters:[String:String]?,completion:@escaping (AnyObject?, Error?) -> Void) -> Void {
        
        var request = URLRequest(url: URL(string:"\(BaseURL)\(serviceURL)")!)
       
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod.rawValue
        
        if (parameters != nil) {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters!, options: .prettyPrinted)
        }
        
        let sessionTask = URLSession(configuration: .default).dataTask(with: request) { (data, response, error) in
            
            if (data != nil){
                let result = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                completion (result as AnyObject, nil)
            }
                
            if (error != nil) {
                completion (nil,error!)
            }
        }
        sessionTask.resume()
    }
}
