//
//  ViewController.swift
//  AdvanceDB
//
//  Created by Ali Dhanani on 28/11/2020.
//

import UIKit

class DecidePage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if Authentication.shared.userExist() {
            performSegue(withIdentifier: "userExist", sender: nil)
        }
    }
    
}

