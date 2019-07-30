//
//  FotosResumenTableViewCell.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/18/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class FotosResumenTableViewCell: UITableViewCell {

    var resumenItems: ResumenItemsVC?
    var resumenItemsDevolucion: ResumenItemsDevolucionVC?
    

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
        if(resumenItems != nil){
            self.resumenItems!.perfomZoomInForStartingImageView(startingImageView: imageView!)
        }else if(resumenItemsDevolucion != nil){
            self.resumenItemsDevolucion!.perfomZoomInForStartingImageView(startingImageView: imageView!)
        }
        
    }
    @objc func eliminar(tapGesture: UITapGestureRecognizer){
        if(resumenItems != nil){
           self.resumenItems!.eliminarFoto(cell: self)
        }else if(resumenItemsDevolucion != nil){
            self.resumenItemsDevolucion!.eliminarFoto(cell: self)
        }
        
        
    }

}
