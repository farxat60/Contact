//
//  ContactWireFrame.swift
//  ContactList
//
//  Created by Joe Franc on 10/23/18.
//  Copyright © 2018 farxat60. All rights reserved.
//

import UIKit

class ContactWireFrame: ListWireFrameProtocol {

    
    
    func pushToDetailList(with user: Results,from view: UIViewController) {
        let detailListViewController = view.storyboard?.instantiateViewController(withIdentifier: "DetailListViewController") as! DetailListViewController
        DetailListWireFrame.createDetailModule(with: detailListViewController, and: user)
        view.navigationController?.pushViewController(detailListViewController, animated: true)
    }
    
    class func createUserListModule(userListRef: ContactListViewController) {
        let presenter: ListPresenterProtocol & ListOutputInteractorProtocol = ContactPresenter()
        
        userListRef.presenter = presenter
        userListRef.presenter?.wireframe = ContactWireFrame()
        userListRef.presenter?.view = userListRef
        userListRef.presenter?.interactor = ContactInteractor()
        userListRef.presenter?.interactor?.presenter = presenter
        
    }
    
}

