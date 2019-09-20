//  CadastroViewController.swift
//  MeuLogin
//
//  Created by Treinamento on 9/11/19.
//  Copyright © 2019 LiviaHilario. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth
import Firebase

class CadastroViewController: UIViewController {

    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var secundNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var cadastroButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpElementos()
        
        firstNameTextField.attributedPlaceholder = NSAttributedString(string:" First Name ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
//        var placeholder = NSMutableAttributedString()
//        let Name  = "Placeholder Text"
//
//        // Set the Font
//        placeholder = NSMutableAttributedString(string:Name, attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica", size: 15.0)!])
//
//        // Set the color
//        placeholder.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor, range:NSRange(location:0,length:Name.characters.count))
//        
//        // Add attribute
//        firstNameTextField.attributedPlaceholder = placeholder
    }
    
    func setUpElementos() {
        errorLabel.alpha = 0
    
        //Style the elementos
        
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(secundNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleHollowButton(cadastroButton)

    }
// Check the fields and validate that the data is correct. If everything is correct, this method return nil. Otherwisr, it return the error message.
    
    func validateFields() -> String? {
        //check that all fields are filled in
        
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            secundNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Por favor preencha todos os campos"
        }

        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            
            return "Por favor crie uma senha com 8 caracters que contenha caracters especial e numeros"
            
        }
        return nil
    }


    @IBAction func cadastroTapped(_ sender: Any) {
        
        //validate the fieldes
        let error = validateFields()
        if error != nil {
            
            showError(error!)
        }
        else {
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let secundName = secundNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
        //Cria um usuario
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            
                if err != nil {
                    
                    self.showError("Erro ao criar usuario")
                }
                    else {
                   let db = Firestore.firestore()
                    db.collection("usuarios").addDocument(data: ["firstName":firstName, "secundName":secundName, "uid":result!.user.uid]) {(error) in
                        if error != nil{
                            self.showError("Erro ao salvar os dados do usuarios")
                        }
                    }
                    
                    //Transition to the home screm
                    self.VoltarATelaInicial()
                }
            }

        }
    }


    func showError (_ message : String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func VoltarATelaInicial() {
       
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
}


