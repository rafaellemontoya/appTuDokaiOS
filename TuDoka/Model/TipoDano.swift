//
//  TipoDano.swift
//  TuDoka
//
//  Created by Rafael Montoya on 8/6/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import Foundation

class TipoDano {
    var key: String
    var clasificacionEquipo: String
    var tipoDano: String
    var pais: String
    
    init(){
        key = ""
        clasificacionEquipo = ""
        pais = ""
        tipoDano = ""
    }
    enum CodingKeys: String, CodingKey {
        case key
        case clasificacionEquipo
        case tipoDano
        
    }
    
    required init(from decoder:Decoder) throws {
        key = ""
        clasificacionEquipo=""
        pais = ""
        tipoDano = ""
        
    }
}
