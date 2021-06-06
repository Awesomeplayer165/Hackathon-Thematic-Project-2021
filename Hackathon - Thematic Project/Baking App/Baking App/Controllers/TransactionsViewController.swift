//
//  TransactionsViewController.swift
//  Banking App
//
//  Created by Jacob Trentini on 6/5/21.
//

import UIKit

class TransactionsViewController: UIViewController {
    
    @IBOutlet weak var goodDayLabel: UILabel!
    @IBOutlet weak var errorCodeLabel: UILabel!
    @IBOutlet weak var depositField: UITextField!
    @IBOutlet weak var depositProgress: UIProgressView!
    @IBAction func depositButton(_ sender: UIButton) {

        if let depositFieldFloat = Float(depositField.text!) {
            print("Float value = \(depositFieldFloat)")
            
            if let usersFieldFloat = Float(Users.shared.currentBalance) {
                print("Float value = \(usersFieldFloat)")
                DBHelper.shared.insertIntoDBBalance(balance: ("\(depositFieldFloat+usersFieldFloat)"))
                errorCodeLabel.text! = "New balance: \(depositFieldFloat+usersFieldFloat)"
            } else{
                errorCodeLabel.text! = "Must be a number (Float)"
            }
            
            
            
        } else {
            errorCodeLabel.text! = "Must be a number (Float)"
        }
        
        
        
        
        depositProgress.isHidden = false
        depositProgress.setProgress(1, animated: true)
        
        
    }
    @IBOutlet weak var withdrawProgress: UIProgressView!
    @IBOutlet weak var withdrawField: UITextField!
    @IBAction func withdrawButton(_ sender: UIButton) {
        withdrawProgress.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        depositProgress.isHidden = true
        withdrawProgress.isHidden = true
        goodDayLabel.text! = "Good Day, \(Users.shared.currentUser)"
        goodDayLabel.numberOfLines = 1
        

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
