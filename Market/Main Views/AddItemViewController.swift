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
    
// MARK: View lifecycles
    
       
    override func viewDidLoad() {
        super.viewDidLoad()
        print(category.id)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width / 2 - 30, y: self.view.frame.height / 2 - 30,
                                                                  width: 60, height: 60),
                                                    type: .ballPulse,
                                                    color: UIColor.red, padding: nil)
    }
    
//MARK: IBActions
    @IBAction func doneBarButtonPressed(_ sender: Any) {
        
        dismissKeyboard()
        
        if fieldsAreCompleted(){
            
            saveToFirebase()
            
        }else{
           
            self.hud.textLabel.text = "Error all fields are required!"
            self.hud.indicatorView = JGProgressHUDIndicatorView()
            self.hud.show(in: self.view)
            self.hud.dismiss(afterDelay: 2.0)
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
        
        showLoadingIndicator()
        
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
                self.hideLoadingIndicator()
                self.popTheView()
            }
            
        }else{
            saveItemToFirestore(item)
            popTheView()
        }
        
    }
    // MARK: Activity Indicator
    
    private func showLoadingIndicator(){
        
        if activityIndicator != nil{
            self.view.addSubview(activityIndicator!)
            activityIndicator!.startAnimating()
            
        }
    }
    
    private func hideLoadingIndicator(){
        
        if activityIndicator != nil {
            self.view.removeFromSuperview()
            activityIndicator!.stopAnimating()
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
