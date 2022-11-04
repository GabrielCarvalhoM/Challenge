//
//  CarListResponse.swift
//  DesafioWeslley
//
//  Created by Gabriel Carvalho on 02/11/22.
//

import UIKit

//MARK: Aqui precisei colocar os 4 últimos como opcionais pois em alguns casos retornavam null, para o caso das imagens coloquei uma para os casos onde ela estivesse null no GET.

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


