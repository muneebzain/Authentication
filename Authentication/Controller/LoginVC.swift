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
    }
    
    @IBAction func signInFBBtnpressed(_ sender: UIButton) {
    }
    
    @IBAction func accountBtnPressed(_ sender: UIButton) {
    }
    
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
}
