//
//  SaveUsersWireFrame.swift
//  ContactList
//
//  Created by Joe Franc on 12/20/18.
//  Copyright © 2018 farxat60. All rights reserved.
//

import UIKit

class SaveUsersWireFrame: SaveUsersWireFrameProtocol {
    
    
    func pushToDetailList(with user: UsersEntity,from view: UIViewController) {
        let detailListViewController = view.storyboard?.instantiateViewController(withIdentifier: "DetailListViewController") as! DetailListViewController
        DetailListWireFrame.createDetailModuleFromEntity(with: detailListViewController, and: user)
        view.navigationController?.pushViewController(detailListViewController, animated: true)
        
    }
    
    func pushToSaveUsers(from view: UIViewController) {
                let saveUsersViewController = view.storyboard?.instantiateViewController(withIdentifier: "SaveUsersViewController") as! SaveUsersViewController
        SaveUsersWireFrame.createSaveUsersModule(saveUsers: saveUsersViewController)
        view.navigationController?.pushViewController(saveUsersViewController, animated: true)
    }
    
    class func createSaveUsersModule(saveUsers: SaveUsersViewController){
        let presenter: SaveUsersPresenterProtocol & SaveUsersOutputInteractorProtocol = SaveUserPresenter()

        saveUsers.presenter = presenter
        saveUsers.presenter?.wireframe = SaveUsersWireFrame()
        saveUsers.presenter?.view = saveUsers
        saveUsers.presenter?.interactor = SaveUsersInteractor()
        saveUsers.presenter?.interactor?.presenter = presenter
    }
    
}
