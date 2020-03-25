//
//  ItemTableViewCell.swift
//  Market
//
//  Created by Anthony Howe on 3/24/20.
//  Copyright © 2020 Anthony Howe. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    //MARK: IB Outlets
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    func generateCell(_ item: Item){
        nameLabel.text = item.name
        descriptionLabel.text = item.description
        priceLabel.text = "\(item.price!)"
        
        //TODO: Download image
        
    }

}
