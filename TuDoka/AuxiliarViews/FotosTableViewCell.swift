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
        }else if(resumenFotos != nil){
            self.resumenFotos!.perfomZoomInForStartingImageView(startingImageView: imageView!)
        }
        
    }
    @objc func eliminar(tapGesture: UITapGestureRecognizer){
        
        self.resumenFotos!.eliminarFoto(cell: self)
        
    }

}
