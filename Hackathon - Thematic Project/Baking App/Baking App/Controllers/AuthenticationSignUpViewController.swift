//
//  ViewController.swift
//  Baking App
//
//  Created by Jacob Trentini on 6/5/21.
//

import UIKit
import SQLite3

internal let SQLITE_STATIC = unsafeBitCast(0, to: sqlite3_destructor_type.self)
internal let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

class AuthenticationSignUp: UIViewController {
    
    var db: OpaquePointer?
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var errorCodeLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    func updateErrLabel(testResult:(String, Bool)){

        if testResult.1 == true{
            errorCodeLabel.text = "Success! Adding details and waiting for Database..."
            let logInViewController = storyboard?.instantiateViewController(identifier: "logInViewController") as! UIViewController
            
            present(logInViewController, animated: true, completion: nil)
            
        }
        if testResult.1 == false{
            errorCodeLabel.text = testResult.0
        }
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Set up SQlite3 DB
        
        
            
        }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        
        // Checking if Email is an email
        
        let entryCheckResultTest = errorCheck.shared.errorCheckingEntry(username: self.usernameField.text!, email: self.emailField.text!, password: self.passwordField.text!, confirmPassword: self.confirmPasswordField.text!, hasConfirmPassword: true, hasUsername: true)
//        print(entryCheckResultTest.errorDescription)
        
        if entryCheckResultTest.isEntryValid == true{
            DBHelper.shared.insertIntoDBForm(username: usernameField.text!, email: emailField.text!, password: passwordField.text!)
            
        }
        
        
        self.updateErrLabel(testResult: (entryCheckResultTest.errorDescription, entryCheckResultTest.isEntryValid))
        
        // function for checking - done
        // after checking is complete, we add details to database, and then send user to home page
        
    }


}

