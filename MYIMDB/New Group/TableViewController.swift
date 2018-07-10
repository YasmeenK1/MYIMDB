//
//  TableViewController.swift
//  MYIMDB
//
//  Created by yasmeenk on 21/10/1439 AH.
//  Copyright © 1439 IMDBAPP. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return GlobalMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = GlobalMovies[indexPath.row].MovieTitle
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        myIndex = indexPath.row
        performSegue(withIdentifier: "iback", sender: self)
    }

}
