//
//  TableViewController.swift
//  MemeMe2.0
//
//  Created by MacbookPRV on 15/01/2016.
//  Copyright © 2016 Pastouret Roger. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UITableViewController {

    

    override func viewWillAppear(animated: Bool) {
        
        
        let sentmemes = SentMemes.singleton
        if let _ = sentmemes.memeArray {
            self.tableView.reloadData()
        }
        
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sentmemes = SentMemes.singleton
        if let _ = sentmemes.memeArray {
            return sentmemes.memeArray.count
        }
        else {
            return 0
        }

    }
    

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
 
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let sentmemes = SentMemes.singleton
        let meme = sentmemes.memeArray[indexPath.row]
        cell.imageView?.image=meme.memedImage
        cell.textLabel?.text=meme.textTop + " " + meme.textBottom
        cell.textLabel?.textAlignment=NSTextAlignment.Right
        return cell
        
    }
    
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        var controller : MemeDetail
        controller = self.storyboard?.instantiateViewControllerWithIdentifier("MemeDetail") as! MemeDetail
        controller.view = cell.imageView
        self.navigationController?.pushViewController(controller, animated: true)

        
        
    }
    
    
    
}