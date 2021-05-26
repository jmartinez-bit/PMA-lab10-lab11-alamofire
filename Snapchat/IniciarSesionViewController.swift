//
//  IniciarSesionViewController.swift
//  Snapchat
//
//  Created by mbtec22 on 5/20/21.
//  Copyright © 2021 Tecsup. All rights reserved.
//

import UIKit
import Firebase

class IniciarSesionViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func iniciarSesionTapped(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("Intentamos Iniciar Sesión")
            if error != nil {
                print("Tenemos el siguiente error:\(error!)")
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    if(error != nil) {
                        print("Tenemos el siguiente error:\(error!)")
                    } else {
                        print("El usuario fue creado exitosamente")
                        Database.database().reference().child("usuarios").child((user?.user.uid)!).child("email").setValue(user?.user.email)
                        
                        self.performSegue(withIdentifier: "Iniciarsesionsegue", sender: nil)
                    }
                })
            }else {
                print("Inicio de Sesion exitoso")
                self.performSegue(withIdentifier: "Iniciarsesionsegue", sender: nil)
            }
        })
        
    }
    

}

