//
//  homeViewController.swift
//  Banking App
//
//  Created by Jacob Trentini on 6/5/21.
//

import UIKit

class homeViewController: UIViewController {
    @IBOutlet weak var goodEveningLabel: UILabel!
    @IBOutlet weak var currentBalanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goodEveningLabel.text! = "Good Day, \(Users.shared.currentUser)"
        currentBalanceLabel.text! = "Current Balance: \(Users.shared.currentBalance)"

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
