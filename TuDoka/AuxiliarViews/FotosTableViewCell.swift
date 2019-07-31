//
//  FotosTableViewCell.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/18/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class FotosTableViewCell: UITableViewCell {

    var resumenFotos: ResumenFotosVC?
    var fotosItemDevolucion: FotosItemDevolucionVC?
    var fotosItemDano: FotosItemDanoVC?
    @IBOutlet weak var fotoIV: UIImageView!
    
    @IBOutlet weak var eliminarBTN: UIButton!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func agregarCelda(image: UIImage){
        fotoIV.image = image
        
        fotoIV.isUserInteractionEnabled = true
        fotoIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomImagen)))
        
        eliminarBTN.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(eliminar)))
    }
    @objc func zoomImagen(tapGesture: UITapGestureRecognizer){
        let imageView = tapGesture.view as? UIImageView
        if(resumenFotos != nil){
            self.resumenFotos!.perfomZoomInForStartingImageView(startingImageView: imageView!)
        }else if(fotosItemDevolucion != nil){
            self.fotosItemDevolucion!.perfomZoomInForStartingImageView(startingImageView: imageView!)
        }else if(fotosItemDano != nil){
            self.fotosItemDano!.perfomZoomInForStartingImageView(startingImageView: imageView!)
        }
        
    }
    @objc func eliminar(tapGesture: UITapGestureRecognizer){
        if(resumenFotos != nil){
            self.resumenFotos!.eliminarFoto(cell: self)
        }else if(fotosItemDevolucion != nil){
            self.fotosItemDevolucion!.eliminarFoto(cell: self)
        }else if(fotosItemDano != nil){
            self.fotosItemDano!.eliminarFoto(cell: self)
        }
        
        
    }

}
