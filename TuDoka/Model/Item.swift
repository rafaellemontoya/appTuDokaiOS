//
//  Item.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/16/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import Foundation
import UIKit

class Item: Codable{
    private var key: String;
    private var nombre: String;
    private var codigo: String;
    private var unidades: Int;
    private var pais: String;
    private var fotos: [UIImage]
    private var urlFotos: [String]
    private var descripcionDano: String
    
    init(){
        self.key = ""
        self.nombre = ""
        self.codigo = ""
        self.unidades = 0
        self.pais = ""
        self.fotos = []
        self.descripcionDano = ""
        self.urlFotos = []
    }
    init(key: String, nombre: String,codigo: String, pais: String) {
        self.unidades = 0;
        self.fotos = [];
        self.key = key;
        self.nombre = nombre;
        self.codigo = codigo;
        self.pais = pais;
        self.descripcionDano = ""
        self.urlFotos = []
    }
    enum CodingKeys: String, CodingKey {
        case nombre
        case codigo
        case unidades
        case descripcionDano
        case urlFotos
    }
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        nombre = try values.decode([String].self, forKey: .nombre) as! String
        codigo = try values.decode([String].self, forKey: .codigo) as! String
        unidades = try values.decode([Int].self, forKey: .unidades) as! Int
        descripcionDano = try values.decode([String].self, forKey: .descripcionDano) as! String
        urlFotos = []
        
        pais=""
        fotos=[]
        key = ""
        
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
        return descripcionDano
    }
    func setDescripcionDano(descripcion: String){
        self.descripcionDano = descripcion
    }
    func getKey()->String{
        return key
    }
    func setKey(key: String){
        self.key = key
    }
    func getPais()->String{
        return pais
    }
    func setPais(pais: String){
        self.pais = pais
    }
    func addUrl(url: String){
        urlFotos.append(url)
    }
    func getUrl()->[String]{
        return urlFotos
    }
    func addUrls(urls: [String]){
        urlFotos = urls
    }
}
