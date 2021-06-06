//
//  logInViewController.swift
//  Banking App
//
//  Created by Jacob Trentini on 6/5/21.
//

import UIKit

class logInViewController: UIViewController {
    
    func checkIfCredentialsAreValid(emailInput:String, passwordInput:String) -> Bool{ // Boolean will describe exec("func name")
        let resultOfDBRead = DBHelper.shared.readFromDB() // userBio[id] = [email, username, balance, password,]
        
        for case let Arrayitems in resultOfDBRead{
            if Arrayitems.value.first! == emailInput && Arrayitems.value.last! == passwordInput{
                Users.shared.currentEmail = Arrayitems.value[0]
                Users.shared.currentUser = Arrayitems.value[1] // Setting currentUser as second item (username in DBHelper.swift)
                Users.shared.currentBalance = Arrayitems.value[2]
                
                return true

            } else{
                return false
            }
            }
        return false
        
        }
        
        
    
    
    func updateErrLabel(){
        errorCodeLabel.text = "Please fill in all of the fields."
        
        
    }
    @IBOutlet weak var errorCodeLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func logInButton(_ sender: UIButton!) {
        
        if emailField.text! == "" || passwordField.text! == "" {
            updateErrLabel()
        }
        if emailField.text! != "" && passwordField.text! != "" {
            if checkIfCredentialsAreValid(emailInput: emailField.text!, passwordInput: passwordField.text!) == true{
                errorCodeLabel.text = "Signed in Successfully!"
                let homeViewController = storyboard?.instantiateViewController(identifier: "homeViewController") as! UIViewController
                
                present(homeViewController, animated: true, completion: nil)
            }
            if checkIfCredentialsAreValid(emailInput: emailField.text!, passwordInput: passwordField.text!) == false{
                errorCodeLabel.text = "Signed in Successfully!"
            
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
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
