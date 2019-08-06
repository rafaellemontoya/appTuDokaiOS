//
//  ActividadCapacitacion.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/31/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import Foundation
import UIKit

class ActividadCapacitacion: Codable {
    private var descripcion: String
    private var fotos: [UIImage]
    private var urlFotos: [String]
    
    enum CodingKeys: String, CodingKey {
        case descripcion
        case urlFotos

    }
    init() {
        descripcion = "";
        fotos = [];
        urlFotos = []
    }
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        urlFotos = []
        
        descripcion=""
        
        fotos = []
        
    }
    func setDescripcion(descripcion: String){
        self.descripcion = descripcion
    }
    func getDescripcion()->String{
        return self.descripcion
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
    func setUrlFotos(urls: [String]){
        urlFotos = urls
    }
}
