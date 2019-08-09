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
    private var foto: UIImage?
    private var urlFoto: String
    
    enum CodingKeys: String, CodingKey {
        case descripcion
        case urlFoto

    }
    init() {
        descripcion = "";
        urlFoto = ""
    }
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        urlFoto = ""
        descripcion=""
        
        
        
    }
    func setDescripcion(descripcion: String){
        self.descripcion = descripcion
    }
    func getDescripcion()->String{
        return self.descripcion
    }
    func getPhotos()->UIImage{
        return foto!
    }
    
    func addPhoto(foto: UIImage){
        self.foto = foto
    }
   
    func setUrlFotos(urls: String){
        urlFoto = urls
    }
    
    func getUrlFoto()->String{
        return urlFoto
    }
    
}
