//
//  ViewControllerPreguntados.swift
//  IOS_1P_EX
//
//  Created by Javier Mejia on 16/03/23.
//

import UIKit

class ViewControllerPreguntados: UIViewController {
    @IBOutlet weak var dificultadEtiqueta: UILabel!
    @IBOutlet weak var scoreEtiqueta: UILabel!
    @IBOutlet weak var vidasEtiqueta: UILabel!
    @IBOutlet weak var preguntaEtiqueta: UILabel!
    @IBOutlet weak var rachaEtiqueta: UILabel!
    @IBOutlet weak var imgPregunta: UIImageView!
    @IBOutlet weak var ciertoBtn: UIButton!
    @IBOutlet weak var falsoBtn: UIButton!
    @IBOutlet weak var comenzarBtn: UIButton!
    
    var Dificultad:String?
    var vidas:Int = 0
    var score:Int = 0
    var racha:Int = 0
    var respuesta = ""
    var preguntasArreglo = ["¿La película Avatar fue dirigida por James Cameron?","¿Jurassic Park es una película de terror?", "En la película El Señor de los Anillos: El Retorno del Rey, ¿Frodo destruye el Anillo?","¿La película Harry Potter y la Piedra Filosofal fue dirigida por Christopher Nolan?","¿La película Forrest Gump está basada en una novela del mismo nombre?","¿El Padrino es una película de ciencia ficción?","En la película El Rey León, ¿Mufasa es el padre de Simba?","¿La película El Exorcista fue dirigida por Steven Spielberg?","¿La película Los Vengadores está basada en un cómic de Marvel?","¿Titanic es una película de ciencia ficción?","¿Goku es un superheroe de Marvel?","¿Loki es hermano de Thor?"]
    var respuestasArreglo = ["CIERTO","FALSO","CIERTO","FALSO","CIERTO","FALSO","CIERTO","FALSO","CIERTO","FALSO","FALSO","CIERTO"]
    var imagenesArreglo = ["avatar","jurassic","frodo","harry","forrest","padrino","mufasa","exorcista","vengadores","titanic","goku","loki"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dificultadEtiqueta.text = Dificultad
        deshabilitarBotones()
    }
    
    func deshabilitarBotones(){
        comenzarBtn.isHidden = false
        ciertoBtn.isHidden = true
        falsoBtn.isHidden = true
        inicializarArreglos()
    }
    
    func inicializarArreglos(){
        preguntasArreglo = ["¿La película Avatar fue dirigida por James Cameron?","¿Jurassic Park es una película de terror?", "En la película El Señor de los Anillos: El Retorno del Rey, ¿Frodo destruye el Anillo?","¿La película Harry Potter y la Piedra Filosofal fue dirigida por Christopher Nolan?","¿La película Forrest Gump está basada en una novela del mismo nombre?","¿El Padrino es una película de ciencia ficción?","En la película El Rey León, ¿Mufasa es el padre de Simba?","¿La película El Exorcista fue dirigida por Steven Spielberg?","¿La película Los Vengadores está basada en un cómic de Marvel?","¿Titanic es una película de ciencia ficción?","¿Goku es un superheroe de Marvel?","¿Loki es hermano de Thor?"]
        respuestasArreglo = ["CIERTO","FALSO","CIERTO","FALSO","CIERTO","FALSO","CIERTO","FALSO","CIERTO","FALSO","FALSO","CIERTO"]
        imagenesArreglo = ["avatar","jurassic","frodo","harry","forrest","padrino","mufasa","exorcista","vengadores","titanic","goku","loki"]
        racha = 0
        rachaEtiqueta.text = String(racha)
    }
    
    @IBAction func comenzar(_ sender: Any) {
        comenzarBtn.isHidden = true
        if Dificultad == "Facil"{
            vidas = 3
            score = 0
            vidasEtiqueta.text = String(vidas)
            lanzarJuego()
        } else if Dificultad == "Intermedio" {
            vidas = 2
            score = 0
            vidasEtiqueta.text = String(vidas)
            lanzarJuego()
        } else if Dificultad == "Dificil" {
            vidas = 1
            score = 0
            vidasEtiqueta.text = String(vidas)
            lanzarJuego()
        }
        ciertoBtn.isHidden = false
        falsoBtn.isHidden = false
    }
    
    func lanzarJuego(){
        let random = Int.random(in: 0...preguntasArreglo.count-1)
        preguntaEtiqueta.text = preguntasArreglo[random]
        respuesta = respuestasArreglo[random]
        imgPregunta.image = UIImage(named: imagenesArreglo[random])
        preguntasArreglo.remove(at: random)
        imagenesArreglo.remove(at: random)
        respuestasArreglo.remove(at: random)
    }
    
    
    @IBAction func validarBtn(_ sender: UIButton) {
        let tituloBtn = sender.currentTitle ?? ""
        if Dificultad == "Facil" {
            if score == 5 {
                let alert = UIAlertController(title: "Felicidades", message: "Has ganado el juego", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
                deshabilitarBotones()
                score = 0
                scoreEtiqueta.text = String(score)
            } else if vidas == 0 {
                let alert = UIAlertController(title: "Perdiste", message: "Has perdido el juego", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
                deshabilitarBotones()
                score = 0
                scoreEtiqueta.text = String(score)
            } else {
                if tituloBtn == respuesta {
                    score += 1
                    racha += 1
                    scoreEtiqueta.text = String(score)
                    rachaEtiqueta.text = String(racha)
                } else {
                    racha = 0
                    vidas -= 1
                    scoreEtiqueta.text = String(score)
                    rachaEtiqueta.text = String(racha)
                    vidasEtiqueta.text = String(vidas)
                }
                lanzarJuego()
            }
        } else  if Dificultad == "Intermedio" {
            if score == 7 {
                let alert = UIAlertController(title: "Felicidades", message: "Has ganado el juego", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
                deshabilitarBotones()
                score = 0
                scoreEtiqueta.text = String(score)
            } else if vidas == 0 {
                let alert = UIAlertController(title: "Perdiste", message: "Has perdido el juego", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
                deshabilitarBotones()
                score = 0
                scoreEtiqueta.text = String(score)
            } else {
                if tituloBtn == respuesta {
                    score += 1
                    racha += 1
                    scoreEtiqueta.text = String(score)
                    rachaEtiqueta.text = String(racha)
                } else {
                    racha = 0
                    vidas -= 1
                    scoreEtiqueta.text = String(score)
                    rachaEtiqueta.text = String(racha)
                    vidasEtiqueta.text = String(vidas)
                }
                lanzarJuego()
            }
        } else if Dificultad == "Dificil" {
            if score == 10 {
                let alert = UIAlertController(title: "Felicidades", message: "Has ganado el juego", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
                deshabilitarBotones()
                score = 0
                scoreEtiqueta.text = String(score)
            } else if vidas == 0 {
                let alert = UIAlertController(title: "Perdiste", message: "Has perdido el juego", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
                deshabilitarBotones()
                score = 0
                scoreEtiqueta.text = String(score)
            } else {
                if tituloBtn == respuesta {
                    score += 1
                    racha += 1
                    scoreEtiqueta.text = String(score)
                    rachaEtiqueta.text = String(racha)
                } else {
                    racha = 0
                    vidas -= 1
                    scoreEtiqueta.text = String(score)
                    rachaEtiqueta.text = String(racha)
                    vidasEtiqueta.text = String(vidas)
                }
                lanzarJuego()
            }
        }
    }
}
