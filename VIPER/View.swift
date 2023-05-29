//
//  View.swift
//  VIPER
//
//  Created by RAMESH on 14/04/23.
//

import UIKit

protocol AnyView {
    var presenter: AnyPresenter? { get set }
    func update(with users:[User])
    func update(with error:String)
}

class UserViewController : UIViewController, AnyView {
   
    
    var presenter: AnyPresenter?
    var users: [User] = []
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(label)
        view.backgroundColor = .systemBlue
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
        
    }
    // MARK: VIPER
    func update(with users: [User]) {
        DispatchQueue.main.async {
            self.users = users
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.users = []
            self.label.text = error
            self.tableView.isHidden = true
            self.label.isHidden = false
        }
    }
    

}

//MARK: -TableViewDataSource

extension UserViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        // Uncomment the following line and enable namesss property to simulate error case
        //cell.textLabel?.text = users[indexPath.row].namesss
        return cell
    }
}
