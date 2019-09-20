//
//  LoginViewController.swift
//  MeuLogin
//
//  Created by Treinamento on 9/11/19.
//  Copyright © 2019 LiviaHilario. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

  
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        SetUpElementos()
    }
    
    func SetUpElementos () {
        errorLabel.alpha = 0
         
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
        

}
    @IBAction func loginTapped(_ sender: Any) {
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil{
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else{
                let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
           self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()

            }
        }
    }
}
