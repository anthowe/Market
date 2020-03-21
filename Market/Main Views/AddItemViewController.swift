//
//  AddItemViewController.swift
//  Market
//
//  Created by Anthony Howe on 3/20/20.
//  Copyright © 2020 Anthony Howe. All rights reserved.
//

import UIKit
import Gallery
import JGProgressHUD
import NVActivityIndicatorView

class AddItemViewController: UIViewController {

//MARK: IB Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
// MARK: Vars

    
    var category: Category!
    var gallery: GalleryController!
    let hud = JGProgressHUD(style: .dark)
    
    var activityIndicator: NVActivityIndicatorView?
    
    var itemImages: [UIImage?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(category.id)
        
    }
    
//MARK: IBActions
    @IBAction func doneBarButtonPressed(_ sender: Any) {
        
        dismissKeyboard()
        
        if fieldsAreCompleted(){
            
            saveToFirebase()
            
        }else{
            print("Error All fields are required")
            
           //TODO: Show error to the user
            
        }
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        
        showImageGallery()
        itemImages = []
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        dismissKeyboard()
    }
    
//Mark: Helpers functions
    
    private func fieldsAreCompleted() ->Bool {
        return(titleTextField.text != "" && priceTextField.text != "" && descriptionTextView.text != "")
    }
    
    private func dismissKeyboard(){
        
        self.view.endEditing(false)
    }
    private func popTheView(){
        self.navigationController?.popViewController(animated: true)
    }
// MARK: Save Items
    
    private func saveToFirebase(){
        
        let item = Item()
        item.id = UUID().uuidString
        item.name = titleTextField.text!
        item.categoryId = category.id
        item.description = descriptionTextView.text
        item.price = Double(priceTextField.text!)
        
        if itemImages.count > 0{
            
            uploadImages(images: itemImages, itemID: item.id) { (imageLinkArray) in
                item.imageLinks = imageLinkArray
                saveItemToFirestore(item)
                self.popTheView()
            }
            
        }else{
            saveItemToFirestore(item)
            popTheView()
        }
        
    }
    //MARK: Show image gallery
    private func showImageGallery(){
        
        self.gallery = GalleryController()
        self.gallery.delegate = self
        Config.tabsToShow = [.imageTab, .cameraTab]
        Config.Camera.imageLimit = 6
        
        self.present(self.gallery, animated: true, completion: nil)
    }
}

extension AddItemViewController: GalleryControllerDelegate{
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        if images.count > 0 {
            Image.resolve(images: images) { (resolvedImages) in
                
                self.itemImages = resolvedImages
            }
        }
        
         controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
         controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
         controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
