//
//  LoginVC.swift
//  Authentication
//
//  Created by Muneeb Zain on 07/03/2022.
//

import UIKit
import Firebase
import FirebaseAuth
import ProgressHUD
import GoogleSignIn


class LoginVC: UIViewController {
    
  


    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true

    }
    

    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        
        if let email = emailTxtField.text,
           let password = passwordTxtField.text {
            loginUser(email: email, password: password)
        }
    }
    
    @IBAction func signinGoogleBtnPressed(_ sender: UIButton) {
        googleSignIn()
    }
    
    @IBAction func signInFBBtnpressed(_ sender: UIButton) {
    }
    
    @IBAction func accountBtnPressed(_ sender: UIButton) {
    }
    
    //MARK: - Login User
    func loginUser(email: String, password: String) {
        ProgressHUD.show()
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error:\(error)")
                ProgressHUD.showError()
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                self.navigationController?.pushViewController(vc, animated: true)
                print("Login Successfully.....")
            }
            ProgressHUD.dismiss()
        }
        
    }
    
    //MARK: - GoogleSignIn
    func googleSignIn() {
        ProgressHUD.show()
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
            if let error = error {
                print("Error:\(error)")
            }
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
              else {
                return
              }

              let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                             accessToken: authentication.accessToken)

            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    print("Error:\(error)")
                    ProgressHUD.showError()
                }else {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                    self.navigationController?.pushViewController(vc, animated: true)
                    print("GoogleSignIn Successfully.....")
                }
                ProgressHUD.dismiss()
            }

        }
    }
}
