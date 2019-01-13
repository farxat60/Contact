//
//  DetailListViewController.swift
//  ContactList
//
//  Created by Joe Franc on 12/12/18.
//  Copyright © 2018 farxat60. All rights reserved.
//

import UIKit
import SDWebImage

import Photos
import UserNotifications

protocol ImagePickerDelegate {
    func pickImage()
}

class DetailListViewController: UIViewController, DetailListViewProtocol {
 
    @IBOutlet var save: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    var imageInHeader:UIImageView?
    var userResults = Results()
    
    

    var presenter: DetailListPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        tableView.register(cellType: DetailListTableViewCell.self)
        tableView.register(cellType: PhotoDetailTableViewCell.self)
    }
    
    func showDetailUsers(with user: Results) {
        userResults = user
    }
    
    @IBAction func save(_ sender: Any) {
        if let img = imageInHeader {
            self.presenter?.saveValue(tableView: tableView,uiImage: img,userResult: userResults)
        }
        self.presenter?.pushToSaveUsersList(from: self)
    }
}

// MARK: UITableViewDataSource

extension DetailListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cellPhoto = tableView.dequeueReusableCell(withIdentifier: PhotoDetailTableViewCell.identifier)
                                                                              as! PhotoDetailTableViewCell
        if let url = userResults.picture?.large {
            cellPhoto.photoImage.sd_setImage(with: URL(string: url), completed: nil)
            cellPhoto.imagePhoto = cellPhoto.photoImage.image
            imageInHeader = cellPhoto.photoImage
            cellPhoto.delegate = self
            return cellPhoto
        } else {
            if let image = userResults.picture?.pictureImage {
                let imageUIImage = UIImage(data: image as Data)
                cellPhoto.photoImage.image = imageUIImage
                imageInHeader = cellPhoto.photoImage
            }
        }
        cellPhoto.delegate = self

        
        return cellPhoto
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userResults.typeValue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: DetailListTableViewCell.self, for: indexPath)
        cell.selectionStyle = .none
        cell.typeValue.text = userResults.typeValue[indexPath.item]
        switch indexPath.item {
        case 0:
            if let userName = userResults.name?.title, let userTitle = userResults.name?.first{
                cell.typeUser.text = userName.capitalized + " " + userTitle.capitalized
                return cell
            } else {
            if let userTitle = userResults.name?.title{
                cell.typeUser.text = userTitle.capitalized
                return cell
            }
        }
        case 1:
            if let lastName = userResults.name?.last {
                cell.typeUser.text = lastName.capitalized
                return cell
            }
        case 2:
            if let email = userResults.email {
                cell.typeUser.text = email
                return cell
            }
        default:
            if let phone = userResults.phone {
                cell.typeUser.text = phone
                cell.typeUser.keyboardType = .phonePad
                return cell
            }
        }
        return cell
    }
 
}

// MARK: UIImagePickerControllerDelegate

extension DetailListViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate, ImagePickerDelegate {
    func pickImage() {
        callCamera()
    }
    
    
    func callCamera() {
        let camera = DSCameraHandler(delegate_: self)
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { (alert : UIAlertAction!) in
            camera.getCameraOn(self, canEdit: true)
        }
        let sharePhoto = UIAlertAction(title: "Photo Library", style: .default) { (alert : UIAlertAction!) in
            camera.getPhotoLibraryOn(self, canEdit: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        optionMenu.addAction(takePhoto)
        optionMenu.addAction(sharePhoto)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            var selectedImage: UIImage?
            if let editedImage = info[.editedImage] as? UIImage {
                selectedImage = editedImage
                imageInHeader?.image = selectedImage
                picker.dismiss(animated: true, completion: nil)
            } else if let originalImage = info[.originalImage] as? UIImage {
                selectedImage = originalImage
                imageInHeader?.image = selectedImage
                picker.dismiss(animated: true, completion: nil)
            }
        }
}
