//
//  DetailListWireFrame.swift
//  ContactList
//
//  Created by Joe Franc on 12/12/18.
//  Copyright © 2018 farxat60. All rights reserved.
//

import UIKit

class DetailListWireFrame: DetailListWireFrameProtocol {
    
    class func createDetailModule(with detailListRef: DetailListViewController, and user: Results) {
        let presenter = DetailListPresenter()
        presenter.userResults = user
        detailListRef.presenter = presenter
        detailListRef.presenter?.view = detailListRef
        detailListRef.presenter?.wireframe = DetailListWireFrame()
        detailListRef.presenter?.interactor = DetailListInteractor()
    }
    
    class func createDetailModuleFromEntity(with detailListRef: DetailListViewController, and user: UsersEntity) {
        let presenter: DetailListPresenterProtocol & DetailListOutputInteractorProtocol = DetailListPresenter()
        presenter.userEntity = user
        detailListRef.presenter = presenter
        detailListRef.presenter?.view = detailListRef
        detailListRef.presenter?.wireframe = DetailListWireFrame()
        detailListRef.presenter?.interactor = DetailListInteractor()
        detailListRef.presenter?.interactor?.presenter = presenter
    }
    
    func goToSaveUsers(from view: UIViewController) {
        let saveUsersViewController = view.storyboard?.instantiateViewController(withIdentifier: "SaveUsersViewController") as! SaveUsersViewController
        SaveUsersWireFrame.createSaveUsersModule(saveUsers: saveUsersViewController)
        view.navigationController?.popToRootViewController(animated: true)
        view.tabBarController?.selectedIndex = 1
        
    }
    
    func pushToDetailList(with user: Results,from view: UIViewController) {
        let detailListViewController = view.storyboard?.instantiateViewController(withIdentifier: "DetailListViewController") as! DetailListViewController
        DetailListWireFrame.createDetailModule(with: detailListViewController, and: user)
        view.navigationController?.pushViewController(detailListViewController, animated: true)
    }
}
