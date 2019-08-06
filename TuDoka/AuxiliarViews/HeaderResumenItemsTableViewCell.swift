//
//  HeaderResumenItemsTableViewCell.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/18/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class HeaderResumenItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var nombreItem: UILabel!
    
    @IBOutlet weak var codigoItem: UILabel!
    
    @IBOutlet weak var unidadesItemLB: UILabel!
    
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
    }
    
    func agregarHeader(item: ActividadCapacitacion){
        nombreItem.text = item.getDescripcion()
    }

}
