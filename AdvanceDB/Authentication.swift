//
//  Firebase.swift
//  AdvanceDB
//
//  Created by Ali Dhanani on 28/11/2020.
//

import Foundation
import FirebaseAuth


class Authentication {
    
    static let shared = Authentication()
    
    init() {
    }
    
    func createAuthentication(Email: String!, password: String!, handler: @escaping ((String)->Void)) {
        Auth.auth().createUser(withEmail: Email, password: password) { authResult, error in
            if error == nil {
                FirebaseData.shared.AddDataFirst()
                handler("Success")
            } else {
                handler(error!.localizedDescription)
            }
            //print("\(authResult?.user.email!) created")
        }
    }
    
    func loginUser(Email: String!, password: String!, handler: @escaping ((String)->Void)) {
        Auth.auth().signIn(withEmail: Email, password: password) { [weak self] authResult, error in
          //guard let strongSelf = self else { return }
            if error == nil {
                handler("Success")
            } else {
                handler(error!.localizedDescription)
            }
          // ...
        }
    }
    
    func userExist() -> Bool {
        if Auth.auth().currentUser != nil {
          return true
        } else {
          return false
        }
    }
    
    func giveUserInfo() -> User {
        return Auth.auth().currentUser!
    }
    
    func logOut(completion: @escaping (()->Void), failure: @escaping ((NSError) -> Void)) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
          completion()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
          failure(signOutError)
        }
    }
    
}
