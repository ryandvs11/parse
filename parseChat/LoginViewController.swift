//
//  LoginViewController.swift
//  parseChat
//
//  Created by Ryan Davis on 9/23/18.
//  Copyright © 2018 Ryan Davis. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBAction func signInBtn(_ sender: Any) {
        func loginUser() {
            let username = usernameField.text ?? ""
            let password = passwordField.text ?? ""
            
            if !checkTextFields() {
                return
            }
            
            PFUser.logInWithUsername(inBackground: username, password: password) {
                (user: PFUser?, error: Error?) in
                
                if let error = error {
                    print("User log in failed: \(error.localizedDescription)")
                } else {
                    print("User logged in successfully")
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
                
            }
            
        }
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        func registerUser() {
            // init a user object
            let newUser = PFUser()
            
            if !checkTextFields() {
                return
            }
            
            //set user properties
            newUser.username = usernameField.text
            newUser.password = passwordField.text
            
            newUser .signUpInBackground { (succeeded: Bool, error: Error?) in
                if let error = error{
                    print(error.localizedDescription)
                    let alertController = UIAlertController(title: "Error", message: "Invalid sign up information", preferredStyle: .alert)
                    
                    let cancelAction = UIAlertAction(title:"cancel", style: .cancel){
                        (action) in
                    }
                    
                    alertController.addAction(cancelAction)
                    
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    }
                    alertController.addAction(OKAction)
                    
                    self.present(alertController, animated: true) {
                        // optional code for what happens after the alert controller has finished presenting
                    }
                    
                }
                else{
                    print("Successfully signed up")
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
            }
            
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func checkTextFields() -> Bool {
        
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        if username.isEmpty {
            let alertController = UIAlertController(title: "Missing", message: "Enter Username Please", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            }
            
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true) {
                
            }
            return false
        }
        
        if password.isEmpty {
            let alertController = UIAlertController(title: "Missing", message: "Enter Password Please", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            }
            
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true) {
                
            }
            return false
        }
        
        return true
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
