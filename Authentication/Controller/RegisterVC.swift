//
//  RegisterVC.swift
//  Authentication
//
//  Created by Muneeb Zain on 07/03/2022.
//

import UIKit
import Firebase
import FirebaseAuth
import ProgressHUD

class RegisterVC: UIViewController {
    
    

    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    @IBOutlet weak var confirmPasswordTxtField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func registerBtnPressed(_ sender: UIButton) {
        
        if let email = emailTxtField.text,
            let password = passwordTxtField.text,
            let confirmPassword = confirmPasswordTxtField.text {
            if password == confirmPassword {
                self.registerUser(email: email, password: password)
            } else {
                ProgressHUD.showError("Password is not same")
            }
        }
        
    }
    
    @IBAction func alreadyAccountBtnPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Register User
    func registerUser(email: String, password: String) {
        ProgressHUD.show()
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error:\(error)")
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                self.navigationController?.pushViewController(vc, animated: true)
                print("Register Successfull....")
            }
            
            ProgressHUD.dismiss()
        }
    }
    
  
    
}
