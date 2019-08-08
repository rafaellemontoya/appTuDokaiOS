//
//  HeaderResumenItemsTableViewCell.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/18/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class HeaderResumenItemsTableViewCell: UITableViewCell {

    
    var resumenItems: ResumenItemsVC?
    var resumenItemsDevolucion: ResumenItemsDevolucionVC?
    var resumenItemsDano: ResumenItemsDanoVC?
    var resumenCapacitacion: ResumenCapacitacionVC?
    var resumenSeguimiento: ResumenSeguimientoViewController?
    
    
    @IBOutlet weak var nombreItem: UILabel!
    
    @IBOutlet weak var codigoItem: UILabel!
    
    @IBOutlet weak var unidadesItemLB: UILabel!
    
    @IBOutlet weak var eliminarBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func agregarHeader(item: Item){
        nombreItem.text = item.getNombre()
        codigoItem.text = item.getCodigo()
        unidadesItemLB.text = "Unidades: " + String(item.getUnidades())
        
        eliminarBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(eliminar)))
    }
    
    func agregarHeader(item: ActividadCapacitacion){
        nombreItem.text = item.getDescripcion()
    }
    
    @objc func eliminar(tapGesture: UITapGestureRecognizer){
        if(resumenItems != nil){
            self.resumenItems!.eliminarItem(cell: self)
        }
//        else if(resumenItemsDevolucion != nil){
//            self.resumenItemsDevolucion!.eliminarFoto(cell: self)
//        }else if(resumenItemsDano != nil){
//            self.resumenItemsDano!.eliminarFoto(cell: self)
//        }else if(resumenCapacitacion != nil){
//            self.resumenCapacitacion!.eliminarFoto(cell: self)
//        }else if(resumenSeguimiento != nil){
//            self.resumenSeguimiento!.eliminarFoto(cell: self)
//        }
        
        
    }

}
