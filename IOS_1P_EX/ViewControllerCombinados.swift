//
//  ViewControllerCombinados.swift
//  IOS_1P_EX
//
//  Created by Javier Mejia on 16/03/23.
//

import UIKit

class ViewControllerCombinados: UIViewController {
    var preguntasArreglo = ["¿La película Avatar fue dirigida por James Cameron?","¿Jurassic Park es una película de terror?", "En la película El Señor de los Anillos: El Retorno del Rey, ¿Frodo destruye el Anillo?","¿La película Harry Potter y la Piedra Filosofal fue dirigida por Christopher Nolan?","¿La película Forrest Gump está basada en una novela del mismo nombre?","¿El Padrino es una película de ciencia ficción?","En la película El Rey León, ¿Mufasa es el padre de Simba?","¿La película El Exorcista fue dirigida por Steven Spielberg?","¿La película Los Vengadores está basada en un cómic de Marvel?","¿Titanic es una película de ciencia ficción?","¿Goku es un superheroe de Marvel?","¿Loki es hermano de Thor?"]
    var respuestasArreglo = ["CIERTO","FALSO","CIERTO","FALSO","CIERTO","FALSO","CIERTO","FALSO","CIERTO","FALSO","FALSO","CIERTO"]
    var imagenesArreglo = ["avatar","jurassic","frodo","harry","forrest","padrino","mufasa","exorcista","vengadores","titanic","goku","loki"]
    
    @IBOutlet weak var Turno: UILabel!
    @IBOutlet weak var ImagenPreguntas: UIImageView!
    @IBOutlet weak var Tablero: UIImageView!
    @IBOutlet weak var Preguntas: UILabel!
    @IBOutlet weak var BtnVerdadero: UIButton!
    @IBOutlet weak var BtnFalso: UIButton!
    @IBOutlet weak var BtnExtra: UIButton!
    @IBOutlet weak var PosicionActual2: UILabel!
    @IBOutlet weak var PosicionActual1: UILabel!
    @IBOutlet weak var Dado: UIImageView!
    @IBOutlet weak var BtnDado: UIButton!
    @IBOutlet weak var BtnReiniciar: UIButton!
    
    @IBOutlet weak var Numero1Etiqueta: UILabel!
    @IBOutlet weak var Numero2Etiqueta: UILabel!
    @IBOutlet weak var operacionEtiqueta: UILabel!
    
    @IBOutlet weak var VidasEtiqueta1: UILabel!
    @IBOutlet weak var VidasEtiqueta2: UILabel!
    
    @IBOutlet weak var P1p1: UIImageView!
    @IBOutlet weak var P1p2: UIImageView!
    @IBOutlet weak var P1p3: UIImageView!
    @IBOutlet weak var P1p4: UIImageView!
    @IBOutlet weak var P1p5: UIImageView!
    @IBOutlet weak var P1p6: UIImageView!
    @IBOutlet weak var P1p7: UIImageView!
    @IBOutlet weak var P1p8: UIImageView!
    @IBOutlet weak var P1p9: UIImageView!
    @IBOutlet weak var P2p1: UIImageView!
    @IBOutlet weak var P2p2: UIImageView!
    @IBOutlet weak var P2p3: UIImageView!
    @IBOutlet weak var P2p4: UIImageView!
    @IBOutlet weak var P2p5: UIImageView!
    @IBOutlet weak var P2p6: UIImageView!
    @IBOutlet weak var P2p7: UIImageView!
    @IBOutlet weak var P2p8: UIImageView!
    @IBOutlet weak var P2p9: UIImageView!
    
    @IBOutlet weak var turnoImg: UIImageView!
    
    var casillaActual1: Int = 0
    var casillaActual2: Int = 0
    var jugadorActual: Int = Int.random(in: 1...2)
    var dado: Int = 0
    var respuesta: String = ""
    var signo = ["+", "-", "x", "/"]
    var numero1 = 0
    var numero2 = 0
    var respuesta1 = 0
    var respuesta2 = 0
    var respuestaCorrecta = 0
    var operacion = "+"
    var vidasJugador1 = 3
    var vidasJugador2 = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        BtnReiniciar.isHidden = true
        BtnReiniciar.isEnabled = false
        [P1p1,P1p2,P1p3,P1p4,P1p5,P1p6,P1p7,P1p8,P1p9,P2p1,P2p2,P2p3,P2p4,P2p5,P2p6,P2p7,P2p8,P2p9].forEach{$0?.isHidden = true}
    }
    
    @IBAction func LanzarDado(_ sender: UIButton){
        dado = Int.random(in: 1...6)
        Dado.image = UIImage(named: String(dado))
        DeterminarPregunta()
        BtnReiniciar.isHidden = true
        BtnReiniciar.isEnabled = false
        [BtnFalso,BtnVerdadero].forEach{$0?.isHidden = false}
    }
    
    func DeclaraVidas(){
        if(jugadorActual == 1){
            vidasJugador1 -= 1
            VidasEtiqueta1.text = "Vidas: \(vidasJugador1)"
            if(vidasJugador1 == 0){
                Perdiste()
            }
        }else{
            vidasJugador2 -= 1
            VidasEtiqueta2.text = "Vidas: \(vidasJugador2)"
            if(vidasJugador2 == 0){
                Perdiste()
            }
        }
    }
    
    @IBAction func ChecarRespuestas(_ sender: UIButton) {
        BtnFalso.isEnabled = false
        BtnExtra.isEnabled = false
        BtnVerdadero.isEnabled = false
        BtnFalso.isOpaque = true
        BtnExtra.isOpaque = true
        BtnVerdadero.isOpaque = true
        
        let aux: String = sender.currentTitle ?? ""
        if(aux == respuesta){
            DeterminarCasilla()
        }else{
            DeclaraVidas()
        }
        
        EsconderImagenes()
    }
    
    func EsconderImagenes (){
        Tablero.isHidden = false
        ImagenPreguntas.isHidden = true
        [BtnExtra,BtnFalso,BtnVerdadero].forEach{$0?.isHidden = true}
    }
    
    @IBAction func CambioJugador(){
        BtnFalso.isEnabled = true
        BtnExtra.isEnabled = true
        BtnVerdadero.isEnabled = true
        BtnFalso.isOpaque = false
        BtnExtra.isOpaque = false
        BtnVerdadero.isOpaque = false
        
        if(jugadorActual == 1){
            jugadorActual = 2
        }else{
            jugadorActual = 1
        }
        Turno.text = "Turno \(jugadorActual)"
    }
    
    func MoverFicha(){
        [P1p1,P1p2,P1p3,P1p4,P1p5,P1p6,P1p7,P1p8,P1p9,P2p1,P2p2,P2p3,P2p4,P2p5,P2p6,P2p7,P2p8,P2p9].forEach{$0?.isHidden = true}
        switch casillaActual1{
        case 1:
            P1p1.isHidden = false
            [P1p2,P1p3,P1p4,P1p5,P1p6,P1p7,P1p8,P1p9].forEach{$0?.isHidden = true}
        case 2:
            P1p2.isHidden = false
            [P1p1,P1p3,P1p4,P1p5,P1p6,P1p7,P1p8,P1p9].forEach{$0?.isHidden = true}
        case 3:
            P1p3.isHidden = false
            [P1p1,P1p2,P1p4,P1p5,P1p6,P1p7,P1p8,P1p9].forEach{$0?.isHidden = true}
        case 4:
            P1p4.isHidden = false
            [P1p1,P1p2,P1p3,P1p5,P1p6,P1p7,P1p8,P1p9].forEach{$0?.isHidden = true}
        case 5:
            P1p5.isHidden = false
            [P1p1,P1p2,P1p3,P1p4,P1p6,P1p7,P1p8,P1p9].forEach{$0?.isHidden = true}
        case 6:
            P1p6.isHidden = false
            [P1p1,P1p2,P1p3,P1p4,P1p5,P1p7,P1p8,P1p9].forEach{$0?.isHidden = true}
        case 7:
            P1p7.isHidden = false
            [P1p1,P1p2,P1p3,P1p4,P1p5,P1p6,P1p8,P1p9].forEach{$0?.isHidden = true}
        case 8:
            P1p8.isHidden = false
            [P1p1,P1p2,P1p3,P1p4,P1p5,P1p6,P1p7,P1p9].forEach{$0?.isHidden = true}
        case 9:
            P1p9.isHidden = false
            [P1p1,P1p2,P1p3,P1p4,P1p5,P1p6,P1p7,P1p8].forEach{$0?.isHidden = true}
        default:
            [P1p1,P1p2,P1p3,P1p4,P1p5,P1p6,P1p7,P1p8,P1p9,P2p1,P2p2,P2p3,P2p4,P2p5,P2p6,P2p7,P2p8,P2p9].forEach{$0?.isHidden = true}
        }
        
        switch casillaActual2{
        case 1:
            P2p1.isHidden = false
            [P2p2,P2p3,P2p4,P2p5,P2p6,P2p7,P2p8,P2p9].forEach{$0?.isHidden = true}
        case 2:
            P2p2.isHidden = false
            [P2p1,P2p3,P2p4,P2p5,P2p6,P2p7,P2p8,P2p9].forEach{$0?.isHidden = true}
        case 3:
            P2p3.isHidden = false
            [P2p1,P2p2,P2p4,P2p5,P2p6,P2p7,P2p8,P2p9].forEach{$0?.isHidden = true}
        case 4:
            P2p4.isHidden = false
            [P2p1,P2p2,P2p3,P2p5,P2p6,P2p7,P2p8,P2p9].forEach{$0?.isHidden = true}
        case 5:
            P2p5.isHidden = false
            [P2p1,P2p2,P2p3,P2p4,P2p6,P2p7,P2p8,P2p9].forEach{$0?.isHidden = true}
        case 6:
            P2p6.isHidden = false
            [P2p1,P2p2,P2p3,P2p4,P2p5,P2p7,P2p8,P2p9].forEach{$0?.isHidden = true}
        case 7:
            P2p7.isHidden = false
            [P2p1,P2p2,P2p3,P2p4,P2p5,P2p6,P2p8,P2p9].forEach{$0?.isHidden = true}
        case 8:
            P2p8.isHidden = false
            [P2p1,P2p2,P2p3,P2p4,P2p5,P2p6,P2p7,P2p9].forEach{$0?.isHidden = true}
        case 9:
            P2p9.isHidden = false
            [P2p1,P2p2,P2p3,P2p4,P2p5,P2p6,P2p7,P2p8].forEach{$0?.isHidden = true}
        default:
            [P1p1,P1p2,P1p3,P1p4,P1p5,P1p6,P1p7,P1p8,P1p9,P2p1,P2p2,P2p3,P2p4,P2p5,P2p6,P2p7,P2p8,P2p9].forEach{$0?.isHidden = true}
        }
    }
    
    //Determina si la pregunta va a ser de matematicas o no y setea los botones
    func DeterminarPregunta(){
        
        if(dado%2 == 0){
            //Matematik
            BtnExtra.isHidden = false
            BtnExtra.isEnabled = true
            ImagenPreguntas.isHidden = true
            Tablero.isHidden = false
            BtnFalso.isOpaque = true
            BtnExtra.isOpaque = true
            BtnVerdadero.isOpaque = true
            
            Numero1Etiqueta.isHidden = false
            Numero2Etiqueta.isHidden = false
            operacionEtiqueta.isHidden = false
            Preguntas.isHidden=true
            
            LanzarMatematica()
        }else{
            //Preguntados
            BtnExtra.isHidden = true
            BtnExtra.isEnabled = false
            ImagenPreguntas.isHidden = false
            Tablero.isHidden = true
            BtnVerdadero.setTitle("CIERTO", for: .normal)
            BtnFalso.setTitle("FALSO", for: .normal)
            Preguntas.isHidden=false
            
            Numero1Etiqueta.isHidden = true
            Numero2Etiqueta.isHidden = true
            operacionEtiqueta.isHidden = true
            
            let random = Int.random(in: 0...preguntasArreglo.count-1)
            Preguntas.text = preguntasArreglo[random]
            respuesta = respuestasArreglo[random]
            ImagenPreguntas.image = UIImage(named: imagenesArreglo[random])
            preguntasArreglo.remove(at: random)
            respuestasArreglo.remove(at: random)
            imagenesArreglo.remove(at: random)
        }
        
        if(preguntasArreglo.count == 1){
            ReiniciarArreglos()
        }
    }
    
    //Determina en que casilla se encuentra el jugador
    func DeterminarCasilla(){
        if(jugadorActual == 1){
            casillaActual1 = casillaActual1 + dado
            if(casillaActual1 > 9){
                let aux: Int = casillaActual1 - 9
                casillaActual1 = casillaActual1 - aux
            }
            PosicionActual1.text = "Player 1: \(casillaActual1)"
        }else{
            casillaActual2 = casillaActual2 + dado
            if(casillaActual2 > 9){
                let aux: Int = casillaActual2 - 9
                casillaActual2 = casillaActual2 - aux
            }
            PosicionActual2.text = "Player 2: \(casillaActual2)"
        }
        
        if(casillaActual1 == 9 || casillaActual2 == 9){
            Victoria(jugadorActual: jugadorActual)
            BtnReiniciar.isHidden = false
            BtnReiniciar.isEnabled = true
        }
        
        MoverFicha()
    }
    
    //Determina si se ha gando
    func Victoria(jugadorActual: Int){
        ImagenPreguntas.image = UIImage(named: "ganaste")
        BtnExtra.isHidden = true
        BtnFalso.isHidden = true
        BtnVerdadero.isHidden = true
        BtnExtra.isEnabled = false
        BtnFalso.isEnabled = false
        BtnVerdadero.isEnabled = false
        BtnDado.isEnabled = false
        BtnDado.isHidden = true
        
        if(casillaActual1 == 9){
            let alert = UIAlertController(title: "Ganaste", message: "Has ganado el juego, Jugador 1", preferredStyle: .alert)
            let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Ganaste", message: "Has ganado el juego, Jugador 2", preferredStyle: .alert)
            let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func ReiniciarArreglos(){
        preguntasArreglo = ["¿La película Avatar fue dirigida por James Cameron?","¿Jurassic Park es una película de terror?", "En la película El Señor de los Anillos: El Retorno del Rey, ¿Frodo destruye el Anillo?","¿La película Harry Potter y la Piedra Filosofal fue dirigida por Christopher Nolan?","¿La película Forrest Gump está basada en una novela del mismo nombre?","¿El Padrino es una película de ciencia ficción?","En la película El Rey León, ¿Mufasa es el padre de Simba?","¿La película El Exorcista fue dirigida por Steven Spielberg?","¿La película Los Vengadores está basada en un cómic de Marvel?","¿Titanic es una película de ciencia ficción?","¿Goku es un superheroe de Marvel?","¿Loki es hermano de Thor?"]
        respuestasArreglo = ["CIERTO","FALSO","CIERTO","FALSO","CIERTO","FALSO","CIERTO","FALSO","CIERTO","FALSO","FALSO","CIERTO"]
        imagenesArreglo = ["avatar","jurassic","frodo","harry","forrest","padrino","mufasa","exorcista","vengadores","titanic","goku","loki"]
    }
    
    @IBAction func ReiniciarJuego(_ sender: Any) {
        ReiniciarArreglos()
        BtnExtra.isHidden = true
        BtnFalso.isHidden = false
        BtnVerdadero.isHidden = false
        BtnExtra.isEnabled = false
        BtnFalso.isEnabled = true
        BtnVerdadero.isEnabled = true
        BtnDado.isEnabled = true
        BtnDado.isHidden = false
        BtnReiniciar.isHidden = true
        casillaActual2 = 0
        casillaActual1 = 0
        dado = 0
        vidasJugador1 = 3
        vidasJugador2 = 3
        respuesta = ""
        jugadorActual = Int.random(in: 1...2)
        [P1p1,P1p2,P1p3,P1p4,P1p5,P1p6,P1p7,P1p8,P1p9,P2p1,P2p2,P2p3,P2p4,P2p5,P2p6,P2p7,P2p8,P2p9].forEach{$0?.isHidden = true}
    }
    
    // Aqui Matematica
    func LanzarMatematica(){
        numero1 = Int.random(in: 0...100)
        numero2 = Int.random(in: 0...100)
        let operando = Int.random(in: 0...3)
        operacion = signo[operando]
        operacionEtiqueta.text = String(operacion)
        Numero1Etiqueta.text = String(numero1)
        Numero2Etiqueta.text = String(numero2)
        respuestaCorrecta = calcularRespuesta(n1: (numero1), n2: (numero2), op: (operacion))
        respuesta = String(respuestaCorrecta)
        respuesta1 = Int.random(in: 0...200)
        respuesta2 = Int.random(in: 0...200)
        let botonCorrecto = Int.random(in: 1...3)
        if botonCorrecto == 1 {
            BtnVerdadero.setTitle(String(respuestaCorrecta), for: .normal)
            BtnFalso.setTitle(String(respuesta1), for: .normal)
            BtnExtra.setTitle(String(respuesta2), for: .normal)
        } else if botonCorrecto == 2 {
            BtnVerdadero.setTitle(String(respuesta1), for: .normal)
            BtnFalso.setTitle(String(respuestaCorrecta), for: .normal)
            BtnExtra.setTitle(String(respuesta2), for: .normal)
        } else {
            BtnVerdadero.setTitle(String(respuesta1), for: .normal)
            BtnFalso.setTitle(String(respuesta2), for: .normal)
            BtnExtra.setTitle(String(respuestaCorrecta), for: .normal)
        }
        VidasEtiqueta1.text = "Vidas: \(vidasJugador1)"
        VidasEtiqueta2.text = "Vidas: \(vidasJugador2)"
        turnoImg.image = UIImage(named: "player\(jugadorActual)")
        print(jugadorActual)
    }
    
    func calcularRespuesta(n1:Int, n2:Int, op:String) -> Int {
            var resultado = 0
            if op == "+" {
                resultado = n1 + n2
            } else if op == "-" {
                resultado = n1 - n2
            } else if op == "x" {
                resultado = n1 * n2
            } else {
                resultado = n1 / n2
            }
            return resultado
    }
    
    func Perdiste(){
        if(vidasJugador1 == 0){
            let alert = UIAlertController(title: "Perdiste", message: "Jugador 1 ha perdido", preferredStyle: .alert)
            let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Perdiste", message: "Jugador 2 has perdido", preferredStyle: .alert)
            let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }

}

