//
//  CategoryCollectionViewController.swift
//  Market
//
//  Created by Anthony Howe on 3/16/20.
//  Copyright © 2020 Anthony Howe. All rights reserved.
//

import UIKit



class CategoryCollectionViewController: UICollectionViewController {

    //MARK: vars
    var categoryArray: [Category] = []
    
    private let sectionInsets = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
    
    private let itemsPerRow: CGFloat = 3
    
    //MARK: view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadCategories()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return categoryArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        as! CategoryCollectionViewCell
    
        cell.generateCell(categoryArray[indexPath.row])
        
        return cell
    }
    //MARK: Download categories
    private func loadCategories(){
        downloadCategoriesFromFirebase { (allCategories) in
            print("we have ", allCategories.count)
            self.categoryArray = allCategories
            self.collectionView.reloadData()
        }
    }

}
extension CategoryCollectionViewController : UICollectionViewDelegateFlowLayout{
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
