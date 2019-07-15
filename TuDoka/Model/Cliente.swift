//
//  Cliente.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/4/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import Foundation
import Firebase

class Cliente{
    var key: String;
    var nombre: String;
    var numero: String;
    var pais: String;
    
    var foto: String?;
    init(key: String, nombre: String,numero: String, pais: String) {
        self.key = key;
        self.nombre = nombre;
        self.numero = numero;
        self.pais = pais;
    }
    /*init?(snapshot: QuerySnapshot) {
        for document in snapshot.documents{
            print("\(document.documentID) => \(document.data())")
        }
        
    }*/
        
        
    
}
