//
//  RegisterVC.swift
//  AdvanceDB
//
//  Created by Ali Dhanani on 28/11/2020.
//

import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    
    @IBAction func btnBack() {
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //txtPassword.autocorrectionType = .no
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SavePress() {
        if txtPassword.text == txtConfirmPassword.text {
            Authentication.shared.createAuthentication(Email: txtUsername.text, password: txtPassword.text) { (Error) in
                if Error == "Success" {
                    self.performSegue(withIdentifier: "registerPass", sender: nil)
                } else {
                    self.showMessage(Message: Error)
                }
            }
        } else {
            showMessage(Message: "Password dont match")
        }
    }
    
    func showMessage(Message: String) {
        let alert = UIAlertController(title: "Alert", message: Message, preferredStyle: .alert)
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
