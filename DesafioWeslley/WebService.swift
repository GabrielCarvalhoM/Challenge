//
//  WebService.swift
//  DesafioWeslley
//
//  Created by Gabriel Carvalho on 31/10/22.
//

import Foundation


class WebService {
    
    var controller: LoginViewController?
    
    func makeLogin() {
        
        guard let url = URL(string: "https://carros-springboot.herokuapp.com/api/v2/login") else { return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String:AnyHashable] = [
            "username": "\(controller?.loginTextFiled.text)",
            "password": "\(controller?.passWordTextFiled.text)"
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("success: \(response)")
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
        
    
    
}

