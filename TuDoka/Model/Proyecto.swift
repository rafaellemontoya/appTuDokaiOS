//
//  Proyecto.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/15/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import Foundation

class Proyecto{
    var key: String;
    var nombre: String;
    var numero: String;
    var pais: String;
    var keyCliente: String
    
    init(key: String, nombre: String,numero: String, pais: String, keyCliente: String) {
        self.key = key;
        self.nombre = nombre;
        self.numero = numero;
        self.pais = pais;
        self.keyCliente = keyCliente;
    }
}
