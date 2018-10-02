//
//  LoginViewController.swift
//  parseChatP2
//
//  Created by Ryan Davis on 9/28/18.
//  Copyright © 2018 Ryan Davis. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
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
                // handle case of user canceling. Doing nothing will dismiss the view.
            }
            
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true) {
                
            }
            return false
        }
        
        if password.isEmpty {
            let alertController = UIAlertController(title: "Missing", message: "Enter Password Please", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                // handle case of user canceling. Doing nothing will dismiss the view.
            }
            
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true) {
                
            }
            return false
        }
        
        return true
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
                
                let alertController = UIAlertController(title: "Error", message: "Invalid sign up information", preferredStyle: .alert)
                
                //create a cancel action
                let cancelAction = UIAlertAction(title:"Cancel", style: .cancel){
                    (action) in
                }
                
                // add the cancel action to the alertController
                alertController.addAction(cancelAction)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            }
            else {
                print("User logged in successfully")
                
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                // display view controller that needs to shown after successful login
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                // manually segue to logged in view
            }
        }
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
