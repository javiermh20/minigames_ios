//
//  ViewController.swift
//  IOS_1P_EX
//
//  Created by Macbook pro on 16/03/23.
//

import UIKit

class ViewController: UIViewController {

    var Juego: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func enviarJuego(_ sender: UIButton) {
        Juego = sender.currentTitle ?? ""
        if Juego == "Combina2" {
            performSegue(withIdentifier: "combinadosSegue", sender: self)
        } else {
            performSegue(withIdentifier: "juegoSegue", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if Juego == "Combina2" {
            guard segue.destination is ViewControllerCombinados
            else{return}
        } else {
            guard let envioJuego = segue.destination as? ViewControllerDificultad
            else{return}
            envioJuego.Juego = Juego
        }
    }
}

