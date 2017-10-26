//
//  LoginViewController.swift
//  E-Closet
//
//  Created by Wei Miao on 10/10/16.
//  Copyright © 2016 wei. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    //MARK: outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    
    //view funcs
    override func viewDidLoad() {
        emailTextField.delegate = self
        pwdTextField.delegate = self
        super.viewDidLoad()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    //MARK: funcs
    
    @IBAction func loginTouch(_ sender: UIButton) {
        if self.emailTextField.text == "" || self.pwdTextField.text == ""
        {
            let alertController = UIAlertController(title: "Oops!", message: "Please enter an email and password.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            FIRAuth.auth()?.signIn(withEmail: self.emailTextField.text!, password: self.pwdTextField.text!) { (user, error) in
                
                if error == nil
                {
                    //get user id and pass it to operation view controller.
                }
                else
                {
                    let alertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    
//    @IBAction func loginTouched(_ sender: UIButton) {
//        if self.emailTextField.text == "" || self.pwdTextField.text == ""
//        {
//            let alertController = UIAlertController(title: "Oops!", message: "Please enter an email and password.", preferredStyle: .alert)
//            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//            alertController.addAction(defaultAction)
//            self.present(alertController, animated: true, completion: nil)
//        }
//        else
//        {
//            FIRAuth.auth()?.signIn(withEmail: self.emailTextField.text!, password: self.pwdTextField.text!) { (user, error) in
//
//                if error == nil
//                {
//                    //get user id and pass it to operation view controller.
//                }
//                else
//                {
//                    let alertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .alert)
//                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//                    alertController.addAction(defaultAction)
//                    self.present(alertController, animated: true, completion: nil)
//                }
//            }
//        }
//    }
    
    @IBAction func createTouched(_ sender: UIButton) {
        if self.emailTextField.text == "" || self.pwdTextField.text == ""
        {
            let alertController = UIAlertController(title: "Oops!", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.pwdTextField.text!) { (user, error) in
                
                if error == nil
                {
                    let alertController = UIAlertController(title: "Congratulations!", message: "Your accound has been created, Click Login to start!", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                else
                {
                    let alertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }
        }
    }
    //pass current user id to operation view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userLogin"{
            let OperationViewController = segue.destination as! ViewController
            if let currentUser = FIRAuth.auth()?.currentUser {
                let userUid = currentUser.uid
                OperationViewController.userInfo.uid = userUid
                print("userid" + userUid)
            }
        }
    }
    // unwindSegue
    @IBAction func unwindSegue (segue:UIStoryboardSegue){
    }

}
