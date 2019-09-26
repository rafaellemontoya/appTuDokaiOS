//
//  RemisionTableViewCell.swift
//  TuDoka
//
//  Created by Rafael Montoya on 9/13/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class RemisionTableViewCell: UITableViewCell {
    
    var agregarRemision: AgregarRemisionVC?
    var numerosDevolucion: NumerosDevolucionViewController?

    @IBOutlet weak var numeroRemisionLB: UILabel!
    
    @IBOutlet weak var eliminarBTN: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func agregarCelda(value: String){
        numeroRemisionLB.text = value
        
        eliminarBTN.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(eliminar)))
    }
    @objc func eliminar(tapGesture: UITapGestureRecognizer){
        if(agregarRemision != nil){
            self.agregarRemision!.eliminarItem(cell: self)
        }else if(numerosDevolucion != nil){
            self.numerosDevolucion!.eliminarItem(cell: self)
        }
    }
}
