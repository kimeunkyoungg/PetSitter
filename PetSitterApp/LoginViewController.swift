//
//  LoginViewController.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/11/24.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
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
                        print("Error logging in: \(error.localizedDescription)")
                    } else {
                        self.navigateToHome()
                    }
                }
            }

            func navigateToHome() {
                if let tabBarVC = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController {
                          // Replace the current navigation stack with the tab bar controller
                          // 네비게이션 스택을 재설정하여 탭바 컨트롤러를 루트로 설정
                          navigationController?.setViewControllers([tabBarVC], animated: true)
                      }
//
            }
    

}
