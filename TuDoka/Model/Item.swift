//
//  Item.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/16/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import Foundation
import UIKit

class Item{
    private var key: String;
    private var nombre: String;
    private var codigo: String;
    private var unidades: Int;
    private var pais: String;
    private var fotos: [UIImage]
    private var descripcionDano: String?
    
    init(key: String, nombre: String,codigo: String, pais: String) {
        self.unidades = 0;
        self.fotos = [];
        self.key = key;
        self.nombre = nombre;
        self.codigo = codigo;
        self.pais = pais;
        
    }
    
    func getNombre()->String{
        return nombre
    }
    func setNombre(nombre: String){
        self.nombre = nombre
    }
    
    func getCodigo()->String{
        return codigo
    }
    func setCodigo(codigo: String){
        self.codigo = codigo
    }
    
    func getUnidades()->Int{
        return unidades
    }
    func setUnidades(unidades: Int){
        self.unidades = unidades
    }
    
    func getPhotos()->[UIImage]{
        return fotos
    }
    
    func addPhoto(foto: UIImage){
        self.fotos.append(foto)
    }
    func eliminarFoto(foto: Int){
        
        self.fotos.remove(at: foto)
        
    }
    func getDescripcionDano()->String{
        return descripcionDano!
    }
    func setDescripcionDano(descripcion: String){
        self.descripcionDano = descripcion
    }
}
