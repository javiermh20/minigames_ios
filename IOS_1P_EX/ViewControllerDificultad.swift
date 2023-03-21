//
//  ViewControllerDificultad.swift
//  IOS_1P_EX
//
//  Created by Javier Mejia on 16/03/23.
//

import UIKit

class ViewControllerDificultad: UIViewController {

    var Juego:String?
    var dificultad:String?
    @IBOutlet weak var juegoEtiqueta: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        juegoEtiqueta.text = Juego
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func enviarDificultad(_ sender: UIButton) {
        dificultad = sender.currentTitle ?? ""
        if Juego == "MatematiK" {
            performSegue(withIdentifier: "matematicaSegue", sender: self)
        } else if Juego == "Pregunta2"{
            performSegue(withIdentifier: "preguntadosSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if Juego == "MatematiK" {
            guard let dificultadEnvio = segue.destination as? ViewControllerMatematicas
            else{return}
            dificultadEnvio.Dificultad = dificultad
        } else if Juego == "Pregunta2" {
            guard let dificultadEnvio = segue.destination as? ViewControllerPreguntados
            else{return}
            dificultadEnvio.Dificultad = dificultad
        } 
    }
    
}
