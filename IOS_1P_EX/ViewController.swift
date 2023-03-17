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
        performSegue(withIdentifier: "juegoSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let envioJuego = segue.destination as? ViewControllerDificultad
        else{return}
        envioJuego.Juego = Juego
    }
}

