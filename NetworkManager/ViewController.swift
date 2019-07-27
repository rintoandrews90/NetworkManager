//
//  ViewController.swift
//  NetworkManager
//
//  Created by Rinto Andrews on 25/07/19.
//  Copyright © 2019 Rinto Andrews. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        makeGETRequest()
    }
    
    private func makeGETRequest(){
        NetworkManager.shared.dataTask(serviceURL: "todos/1", httpMethod: .get, parameters: nil) { (response, error) in
            if response != nil {
                print(response)
            }
            if error != nil {
                print("Error Occoured")
            }
        }
    }
    
    private func makePOSTRequest(){
        NetworkManager.shared.dataTask(serviceURL: "create", httpMethod: .post, parameters: ["name":"rinto","salary":"456","age":"23"]) { (response, error) in
            if response != nil {
                print(response)
            }
            if error != nil {
                print("Error Occoured")
            }
        }
    }
}

