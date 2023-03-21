import UIKit

class ViewControllerMatematicas: UIViewController {
    @IBOutlet weak var scoreEtiqueta: UILabel!
    @IBOutlet weak var vidasEtiqueta: UILabel!
    @IBOutlet weak var numero1Etiqueta: UILabel!
    @IBOutlet weak var numero2Etiqueta: UILabel!
    @IBOutlet weak var operandoEtiqueta: UILabel!
    @IBOutlet weak var btnRes1: UIButton!
    @IBOutlet weak var btnRes2: UIButton!
    @IBOutlet weak var btnRes3: UIButton!
    @IBOutlet weak var imgRespuesta: UIImageView!
    @IBOutlet weak var rachaEtiqueta: UILabel!
    @IBOutlet weak var btnComenzar: UIButton!
    @IBOutlet weak var dificultadEtiqueta: UILabel!
    
    var Dificultad:String?
    var signo = ["+", "-", "x", "/"]
    var numero1 = 0
    var numero2 = 0
    var vidas = 0
    var score = 0
    var racha = 0
    var respuesta1 = 0
    var respuesta2 = 0
    var respuestaCorrecta = 0
    var operacion = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dificultadEtiqueta.text = Dificultad
        desactivarBotones()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func comenzar(_ sender: Any) {
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
        scoreEtiqueta.isHidden = false
        vidasEtiqueta.isHidden = false
        rachaEtiqueta.isHidden = false
        btnComenzar.isHidden = true
        numero1Etiqueta.isHidden = false
        numero2Etiqueta.isHidden = false
        operandoEtiqueta.isHidden = false
        btnRes1.isHidden = false
        btnRes2.isHidden = false
        btnRes3.isHidden = false
    }
    
    func lanzarJuego() {
        // declarar variables
        numero1 = Int.random(in: 0...100)
        numero2 = Int.random(in: 0...100)
        let operando = Int.random(in: 0...3)
        operacion = signo[operando]
        operandoEtiqueta.text = String(operacion)
        numero1Etiqueta.text = String(numero1)
        numero2Etiqueta.text = String(numero2)
        respuestaCorrecta = calcularRespuesta(n1: (numero1), n2: (numero2), op: (operacion))
        respuesta1 = Int.random(in: 0...200)
        respuesta2 = Int.random(in: 0...200)
        // dar el resultado a los botones aleatoriamente
        let botonCorrecto = Int.random(in: 1...3)
        if botonCorrecto == 1 {
            btnRes1.setTitle(String(respuestaCorrecta), for: .normal)
            btnRes2.setTitle(String(respuesta1), for: .normal)
            btnRes3.setTitle(String(respuesta2), for: .normal)
        } else if botonCorrecto == 2 {
            btnRes1.setTitle(String(respuesta1), for: .normal)
            btnRes2.setTitle(String(respuestaCorrecta), for: .normal)
            btnRes3.setTitle(String(respuesta2), for: .normal)
        } else {
            btnRes1.setTitle(String(respuesta1), for: .normal)
            btnRes2.setTitle(String(respuesta2), for: .normal)
            btnRes3.setTitle(String(respuestaCorrecta), for: .normal)
        }
        
    }
    
    // funcion para calcular la respuesta correcta
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
    
    @IBAction func btnValidar(_ sender: UIButton) {
        let tituloBtn = sender.currentTitle ?? ""
        if Dificultad == "Facil"{
            if score == 4 {
                let alert = UIAlertController(title: "Ganaste", message: "Has ganado el juego", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
                scoreEtiqueta.text = "5"
                desactivarBotones()
                btnComenzar.isHidden = false
            } else if vidas == 0 {
                let alert = UIAlertController(title: "Perdiste", message: "Has perdido el juego", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
                scoreEtiqueta.text = "0"
                desactivarBotones()
                btnComenzar.isHidden = false
            } else {
                if tituloBtn == String(respuestaCorrecta) {
                    imgRespuesta.image = UIImage(named: "correcto")
                    score += 1
                    racha += 1
                    scoreEtiqueta.text = String(score)
                    rachaEtiqueta.text = String(racha)
                    lanzarJuego()
                } else {
                    imgRespuesta.image = UIImage(named: "incorrecto")
                    vidas -= 1
                    vidasEtiqueta.text = String(vidas)
                    racha = 0
                    rachaEtiqueta.text = String(racha)
                    lanzarJuego()
                }
            }
        } else if Dificultad == "Intermedio" {
            if score == 6 {
                let alert = UIAlertController(title: "Ganaste", message: "Has ganado el juego", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
                scoreEtiqueta.text = "7"
                desactivarBotones()
                btnComenzar.isHidden = false
            } else if vidas == 0 {
                let alert = UIAlertController(title: "Perdiste", message: "Has perdido el juego", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
                scoreEtiqueta.text = "0"
                desactivarBotones()
                btnComenzar.isHidden = false
            } else {
                if tituloBtn == String(respuestaCorrecta) {
                    imgRespuesta.image = UIImage(named: "correcto")
                    score += 1
                    racha += 1
                    scoreEtiqueta.text = String(score)
                    rachaEtiqueta.text = String(racha)
                    lanzarJuego()
                } else {
                    imgRespuesta.image = UIImage(named: "incorrecto")
                    vidas -= 1
                    vidasEtiqueta.text = String(vidas)
                    racha = 0
                    rachaEtiqueta.text = String(racha)
                    lanzarJuego()
                }
            }
        } else if Dificultad == "Dificil" {
            if score == 9 {
                let alert = UIAlertController(title: "Ganaste", message: "Has ganado el juego", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
                scoreEtiqueta.text = "10"
                desactivarBotones()
                btnComenzar.isHidden = false
            } else if vidas == 0 {
                let alert = UIAlertController(title: "Perdiste", message: "Has perdido el juego", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
                scoreEtiqueta.text = "0"
                desactivarBotones()
                btnComenzar.isHidden = false
            } else {
                if tituloBtn == String(respuestaCorrecta) {
                    imgRespuesta.image = UIImage(named: "correcto")
                    score += 1
                    racha += 1
                    scoreEtiqueta.text = String(score)
                    rachaEtiqueta.text = String(racha)
                    lanzarJuego()
                } else {
                    imgRespuesta.image = UIImage(named: "incorrecto")
                    vidas -= 1
                    vidasEtiqueta.text = String(vidas)
                    racha = 0
                    rachaEtiqueta.text = String(racha)
                }
            }
        }
    }
    
    func desactivarBotones() {
        scoreEtiqueta.isHidden = true
        vidasEtiqueta.isHidden = true
        rachaEtiqueta.isHidden = true
        numero1Etiqueta.isHidden = true
        numero2Etiqueta.isHidden = true
        operandoEtiqueta.isHidden = true
        btnRes1.isHidden = true
        btnRes2.isHidden = true
        btnRes3.isHidden = true
    }
}
