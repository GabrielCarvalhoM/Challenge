//
//  Api.swift
//  DesafioWeslley
//
//  Created by Gabriel Carvalho on 01/11/22.
//

import Foundation

enum Urls {
    static let base = "https://carros-springboot.herokuapp.com/api/v2"
}

final class Api {
    
    func execute<T:Codable>(model:T.Type, method: String, headers: [String:String], body: Data?, endPoint: String, completion: @escaping (Result<T,Error>) -> Void) {
        
        guard let url = URL(string: Urls.base + endPoint) else { return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method
        headers.compactMap( {$0} ).forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, reponse, error in
            guard let data = data, error == nil else {
                                
                return
            }
            do {
                let response = try JSONDecoder().decode(model, from: data)
                DispatchQueue.main.async {
                    completion(.success(response))

                }
            }
            catch {
                DispatchQueue.main.async {
                    completion(.failure(error))

                }
            }
        }
        task.resume()
    }
    
}
