//
//  LoginVC.swift
//  AdvanceDB
//
//  Created by Ali Dhanani on 28/11/2020.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtPassword.autocorrectionType = .no
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func SavePress() {
        Authentication.shared.loginUser(Email: txtUsername.text, password: txtPassword.text) { (Error) in
            if Error == "Success" {
                self.performSegue(withIdentifier: "loginPass", sender: nil)
            } else {
                self.showMessage(Error: Error)
            }
        }

    }
    
    func showMessage(Error error:String) {
        let alert = UIAlertController(title: "Alert", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              switch action.style{
              case .default:
                    print("default")

              case .cancel:
                    print("cancel")

              case .destructive:
                    print("destructive")


        }}))
        self.present(alert, animated: true, completion: nil)
    }

}
