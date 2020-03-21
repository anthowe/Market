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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
//MARK: IBActions
    @IBAction func doneBarButtonPressed(_ sender: Any) {
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
    }
    
}
