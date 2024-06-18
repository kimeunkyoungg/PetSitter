//
//  LoginViewController.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/11/24.
//

import UIKit
import FirebaseAuth

//로그인 화면
class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        if let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") {
            navigationController?.pushViewController(signUpVC, animated: true)
            
        }
    }
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
                    return
                }

                Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                    guard let self = self else { return }
                    if let error = error {
                        print("Error \(error.localizedDescription)")
                    } else {
                        self.navigateToHome()
                    }
                }
            }

            func navigateToHome() {
                if let tabBarVC = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController {
                          navigationController?.setViewControllers([tabBarVC], animated: true)
                      }
//
            }
    

}
