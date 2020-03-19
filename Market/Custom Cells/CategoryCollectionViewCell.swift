//
//  CategoryCollectionViewCell.swift
//  Market
//
//  Created by Anthony Howe on 3/16/20.
//  Copyright © 2020 Anthony Howe. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    func generateCell(_ category: Category){
        nameLabel.text = category.name
        imageView.image = category.image
    }
}
