//
//  DetailListPresenter.swift
//  ContactList
//
//  Created by Joe Franc on 12/12/18.
//  Copyright © 2018 farxat60. All rights reserved.
//

import UIKit

class DetailListPresenter: DetailListPresenterProtocol {
    
    var interactor: DetailListInputInteractorProtocol?
    var view: DetailListViewProtocol?
    var wireframe: DetailListWireFrameProtocol?

    var userResults: Results?
    var userEntity: UsersEntity?
    
    var typeValue = { return TypeValue.generateTypeList()}

    func viewDidLoad() {
        userResults?.typeValue = typeValue()
        
        if let results = userResults {
            view?.showDetailUsers(with: results)
        }
        if let saveUser = userEntity {

            self.interactor?.sendUserEntity(userEntity: saveUser)
        }
    }
    
    func saveValue(tableView: UITableView, uiImage:UIImageView, userResult: Results) {
        if let results = userResults {
            self.interactor?.saveUser(tableView: tableView, countCell: results.typeValue.count, uiImage: uiImage, userResult: results)
        }
    }
    
    
    func pushToSaveUsersList(from view: UIViewController) {
        wireframe?.goToSaveUsers(from: view)
    }
    
}
extension DetailListPresenter: DetailListOutputInteractorProtocol{
    func returnUserEntity(result: Results) {
        userResults = result
        view?.showDetailUsers(with: result)
    }

}

