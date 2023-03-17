//
//  ViewControllerMatematicas.swift
//  IOS_1P_EX
//
//  Created by Javier Mejia on 16/03/23.
//

import UIKit

class ViewControllerMatematicas: UIViewController {
    
    var Dificultad:String?
    @IBOutlet weak var dificultadEtiqueta: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        dificultadEtiqueta.text = Dificultad
        // Do any additional setup after loading the view.
    }

}
