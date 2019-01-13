//
//  ContactListViewController.swift
//  ContactList
//
//  Created by Joe Franc on 10/23/18.
//  Copyright © 2018 farxat60. All rights reserved.
//

import UIKit
import SDWebImage

class ContactListViewController: UIViewController, ContactListViewProtocol{
    
    var pageIndex = 10
    
    @IBOutlet weak var usersTableView: UITableView!
    var presenter: ListPresenterProtocol?
    var users = Users()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        ContactWireFrame.createUserListModule(userListRef: self)
        usersTableView.register(cellType: UsersTableViewCell.self)
        presenter?.viewDidLoad()
    }
    
    func showUsers(with users: Users) {
        self.users = users
        self.usersTableView.reloadData()
    }

}

extension ContactListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let result = users.results else { return 0}
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: UsersTableViewCell.self, for: indexPath)

        
        guard let firstName = users.results[indexPath.item].name?.first else { return cell }
        guard let lastName = users.results[indexPath.item].name?.last else { return cell }
        guard let title = users.results[indexPath.item].name?.title else { return cell }
        guard let url = users.results[indexPath.item].picture?.medium else { return cell }

        cell.phoneUserLabel.text = users.results[indexPath.item].phone
        cell.userNameLabel.text = (title + " " + firstName + " " + lastName).capitalized
        cell.userPhotoImage?.sd_setImage(with: URL(string: url), completed: nil)
        
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if indexPath.row == users.results.count-1 {
            pageIndex = users.results.count + 10
            presenter?.interactor?.getUserListList(page: pageIndex)

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let results = users.results?[indexPath.item] else { return }
        presenter?.showDetailSelection(with: results, from: self)
    }

}
