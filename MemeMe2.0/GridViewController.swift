//
//  GridViewController.swift
//  MemeMe2.0
//
//  Created by MacbookPRV on 15/01/2016.
//  Copyright © 2016 Pastouret Roger. All rights reserved.
//
import Foundation
import UIKit

class GridViewController: UICollectionViewController {
    
   
    override func viewWillAppear(animated: Bool) {
        
        
        let sentmemes = SentMemes.singleton
        if let _ = sentmemes.memeArray {
            self.collectionView?.reloadData()
        }
        
    }

    
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        let sentmemes = SentMemes.singleton
        if let _ = sentmemes.memeArray {
            return sentmemes.memeArray.count
        }
        else {
            return 0
        }
        
    }
    
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCellWithReuseIdentifier("item", forIndexPath: indexPath)
        let sentmemes = SentMemes.singleton
        let meme = sentmemes.memeArray[indexPath.row]
        let aView=UIImageView()
        aView.image=meme.memedImage
        item.backgroundView=aView
        return item
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let item = collectionView.cellForItemAtIndexPath(indexPath)
        var controller : MemeDetail
        controller = self.storyboard?.instantiateViewControllerWithIdentifier("MemeDetail") as! MemeDetail
       controller.view=item?.backgroundView
       self.navigationController?.pushViewController(controller, animated: true)
        
        
        
        
    }
    
}