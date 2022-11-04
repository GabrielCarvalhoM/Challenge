//
//  LoginResponse.swift
//  DesafioWeslley
//
//  Created by Gabriel Carvalho on 01/11/22.
//

import Foundation

//MARK: Optei por receber apenas o token aqui pois foi a única coisa que utilizaria desse response

struct LoginResponse: Codable {
    
    let token: String?

}
