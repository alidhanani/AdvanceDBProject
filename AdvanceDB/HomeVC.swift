//
//  HomeVC.swift
//  AdvanceDB
//
//  Created by Ali Dhanani on 29/11/2020.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet var dataTable : UITableView?
    @IBOutlet var searchBar: UISearchBar?
    
    var animals: [String] = []
    var filterData: [String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        FirebaseData.shared.GetDataQuery()
        print("Count after ", animals.count)
    }
    
    
    func fetchData() {
        FirebaseData.shared.getData { (data) in
            self.animals.removeAll()
            self.animals = data
            self.filterData = self.animals
            print("Count before ", self.animals.count)
            self.dataTable?.reloadData()
        }
    }
    
    @IBAction func btnLogout() {
        Authentication.shared.logOut {
            self.performSegue(withIdentifier: "goingBack", sender: nil)
        } failure: { (Error) in
            self.showMessage(Error: Error.localizedDescription)
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
    
    @IBAction func btnAdd() {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Success", message: "Enter Note: ", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            FirebaseData.shared.AddData(Note: (textField?.text)!)
            print("Text field: \(textField!.text!)")
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }

}

extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DataTVC = (self.dataTable!.dequeueReusableCell(withIdentifier: "DataTVC") as! DataTVC?)!
                
                // set the text from the data model
        cell.txtData.text = self.filterData[indexPath.row]
                return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            FirebaseData.shared.removeData(SearchData: self.filterData[indexPath.row])
            fetchData()
        }
    }
    
}

extension HomeVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData.removeAll()
        if searchText == "" {
            filterData = animals
        } else {
            for data in animals {
                if data.lowercased().contains(searchText.lowercased()) {
                    filterData.append(data)
                }
            }
        }
        dataTable?.reloadData()
    }
}
