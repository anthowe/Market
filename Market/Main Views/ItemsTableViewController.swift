//
//  ItemsTableViewController.swift
//  Market
//
//  Created by Anthony Howe on 3/19/20.
//  Copyright © 2020 Anthony Howe. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController {
    //MARK: Vars
    var category: Category!
    var itemArray: [Item] = []
    
    //MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        self.title = category?.name
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if category != nil{
            //download items
            loadItems()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemTableViewCell

        cell.generateCell(itemArray[indexPath.row])
        return cell
    }
    

    // MARK: - Navigation

     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "itemToAddItemSeg"{
            let vc = segue.destination as! AddItemViewController
            vc.category = category!
        }
         
    }
    //MARK: Load items
    
    private func loadItems(){
        downloadItemFromFireBase(category!.id) { (allItems) in
            print("We have \(allItems.count) in this category")
            self.itemArray = allItems
            self.tableView.reloadData()
            
        }
        
    }
    

}
