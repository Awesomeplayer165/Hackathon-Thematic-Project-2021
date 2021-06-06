//
//  File.swift
//  Banking App
//
//  Created by Jacob Trentini on 6/5/21.
//

import Foundation


class errorCheck{
    static let shared = errorCheck()
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func errorCheckingEntry(username:String, email:String, password: String, confirmPassword: String, hasConfirmPassword:Bool, hasUsername:Bool) -> (isEntryValid:Bool, errorDescription:String){
        
        // Email is valid
        
        if hasConfirmPassword == true {
            if username == ""{
                return (false, "Error: Username cannot be empty.")
            }
            if (username.range(of: password, options: [.diacriticInsensitive, .caseInsensitive]) != nil) || (password.range(of: username, options: [.diacriticInsensitive, .caseInsensitive]) != nil) == true{
                // we have a problem. Username cannot be password
                return (false, "Error: Username and Password cannot be similar")
            }
        }
        
        if email == ""{
            return (false, "Error: Email cannot be empty.")
        }
        
        if password == ""{
            return (false, "Error: Password cannot be empty.")
        }
        
        if username == ""{
            return (false, "Error: Username cannot be empty.")
        }
        
        let emailisValid = isValidEmail(email)
        
        if emailisValid == false{
            return (false, "Error: Please enter a valid email.")
        }
        else if emailisValid == true{
            
            if hasConfirmPassword == true{ // we know its a sign up page
                if password == confirmPassword{
                    if username == password{
                        return (true, "Error: Username and Password cannot be the same.")
                    }
                    if username != password{
                        return (true, "")
                    }
                }
                else if password != confirmPassword{
                    return (false, "Error: Please enter the same passwords.")
                }
            }
        }
        return (false, "unknown error")
        
    }
}
