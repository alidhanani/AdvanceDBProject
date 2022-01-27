//
//  FirebaseDatabase.swift
//  AdvanceDB
//
//  Created by Ali Dhanani on 29/11/2020.
//

import Foundation
import FirebaseDatabase

class FirebaseData {
    
    static let shared = FirebaseData()
    var ref: DatabaseReference!
    var toStore = [String: Any]()
    var allData = [String]()
    
    init() {
    }
    
    func AddDataFirst() {
        self.ref = Database.database().reference()
        let user = Authentication.shared.giveUserInfo()
        self.ref.child("users").child(user.uid).setValue(
            [
                "email": user.email,
                "uid": user.uid,
            ]
        )
    }
    
    func GetDataQuery() {
        self.ref = Database.database().reference()
        let user = Authentication.shared.giveUserInfo()
        let myTopPostsQuery = (ref.child("users").child(user.uid)).queryOrdered(byChild: "data")
        print("Data", myTopPostsQuery)
    }
    
    func AddData(Note note:String) {
        self.ref = Database.database().reference()
        let user = Authentication.shared.giveUserInfo()
        self.ref.child("users").child(user.uid).child("data").observeSingleEvent(of: .value) { (DataSnapshot) in
            self.toStore.removeAll()
            for child in DataSnapshot.children{
                        let valueD = child as! DataSnapshot
                        let keyD = valueD.key
                        let value1 = valueD.value
                self.toStore[keyD] = value1
            }
            print("Enitre Data: ", self.toStore)
            print("Total Children: ", DataSnapshot.childrenCount)
            self.toStore["note\(DataSnapshot.childrenCount+1)"] = note
            self.ref.child("users").child(user.uid).child("data").setValue(self.toStore)
        }
    }
    
    func getData(handler: @escaping (([String])->Void)) {
        self.ref = Database.database().reference()
        let user = Authentication.shared.giveUserInfo()
        self.ref.child("users").child(user.uid).child("data").observe(.value) { (DataSnapshot) in
            self.allData.removeAll()
            for child in DataSnapshot.children{
                        let valueD = child as! DataSnapshot
                        let keyD = valueD.key
                        let value1 = valueD.value
                self.allData.append(value1 as! String)
            }
            handler(self.allData)
        }
    }
    
    func removeData(SearchData data: String) {
        self.ref = Database.database().reference()
        let user = Authentication.shared.giveUserInfo()
        self.ref.child("users").child(user.uid).child("data").observe(.value) { (DataSnapshot) in
            self.toStore.removeAll()
            var count: Int = 0
            for child in DataSnapshot.children{
                        let valueD = child as! DataSnapshot
                        let value1 = valueD.value
                if(value1 as! String != data) {
                    self.toStore["note\(count+1)"] = value1
                    count += 1
                }
            }
            self.ref.child("users").child(user.uid).child("data").setValue(self.toStore)
        }
    }
    
}
