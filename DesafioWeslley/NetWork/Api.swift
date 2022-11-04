//
//  Api.swift
//  DesafioWeslley
//
//  Created by Gabriel Carvalho on 01/11/22.
//

import Foundation
import UIKit

// MARK: Chamada Api genérica para conseguir realizar tanto o Post do login quanto o Get das informações da Api reutilizando a mesma função. -


final class Api {
    
    func execute<T:Codable>(model:T.Type, method: String, headers: [String:String], body: Data?, url: String, completion: @escaping (Result<T,Error>) -> Void) {
        
        guard let url = URL(string: url) else { return }
        
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
    
    // MARK: Função apenas para chamada das imagens, não consegui fazer todas as adaptações necessárias na função acima para que ela servisse para as imagens
    // MARK: Alem do tipo UIImage/UIImageView não ser nativamente conformado com decodable, então fiz dessa forma e chamei direto na customCell ja passando o
    // MARK: Retorno dela dentro da propriedade Image na minha Célula usando o cellForRowAt
    
    func fetchImage(url: String, completion: @escaping (UIImage?) -> Void ) {
     
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return }
                let image = UIImage(data: data)
                    completion(image)
        }.resume()
    }
    
}

