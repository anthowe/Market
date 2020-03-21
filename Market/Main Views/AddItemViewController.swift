//
//  AddItemViewController.swift
//  Market
//
//  Created by Anthony Howe on 3/20/20.
//  Copyright © 2020 Anthony Howe. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

//MARK: IB Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
// MARK: Vars

    
    var category: Category!
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
            
        }else{
            saveItemToFirestore(item)
            popTheView()
        }
        
    }
}
