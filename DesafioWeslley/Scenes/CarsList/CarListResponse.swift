//
//  CarListResponse.swift
//  DesafioWeslley
//
//  Created by Gabriel Carvalho on 02/11/22.
//

import UIKit

struct CarModel: Codable {
    
    let id: Int
    let nome: String
    let tipo: String
    let descricao: String
    let urlFoto: String?
    let urlVideo: URL?
    let latitude: String?
    let longitude: String?
    
    
}


