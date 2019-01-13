//
//  SaveUsersViewController.swift
//  ContactList
//
//  Created by Joe Franc on 12/19/18.
//  Copyright © 2018 farxat60. All rights reserved.
//

import UIKit

class SaveUsersViewController: UIViewController, SaveUsersViewProtocol {

    @IBOutlet var saveUserTableView: UITableView!
    var presenter: SaveUsersPresenterProtocol?
    var usersEntity = Array<UsersEntity>()

    override func viewDidLoad() {
        super.viewDidLoad()
        SaveUsersWireFrame.createSaveUsersModule(saveUsers: self)
        presenter?.viewDidLoad()
        saveUserTableView.register(cellType: UsersTableViewCell.self)
        saveUserTableView.tableFooterView = UIView()

    }
    
    func showSaveUsers(with user: Array<UsersEntity>) {
        usersEntity = user
        saveUserTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidLoad()
    }
    
}

extension SaveUsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersEntity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: UsersTableViewCell.self, for: indexPath)
        
        guard let firstName = usersEntity[indexPath.item].results.first?.name?.first else { return cell }
        guard let lastName = usersEntity[indexPath.item].results.first?.name?.last else { return cell }

        cell.phoneUserLabel.text = usersEntity[indexPath.item].results.first?.phone
        cell.userNameLabel.text = firstName.capitalized + " " + lastName.capitalized
        
        
        if let image = usersEntity[indexPath.item].results.first?.pictureImage {
            let imageUIImage = UIImage(data: image as Data)
            cell.userPhotoImage.image = imageUIImage
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showDetailSelectionFromSaveUsers(with: usersEntity[indexPath.item], from: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            usersEntity.remove(at: indexPath.row)
            saveUserTableView.beginUpdates()
            saveUserTableView.deleteRows(at: [indexPath], with: .automatic)
            saveUserTableView.endUpdates()
            presenter?.deleteItemInRealmObject(with: indexPath.item)
        }
    }

    
}
