//
//  MemeMod.swift
//  PickingImages
//
//  Created by MacbookPRV on 12/01/2016.
//  Copyright © 2016 Pastouret Roger. All rights reserved.
//

import Foundation
import UIKit

class MemeMod: NSObject {
    
    var textTop:String
    var textBottom:String
    var imageOrigin:UIImage
    var memedImage:UIImage
    
    
    init(textTop:String, textBottom:String, imageOrigin:UIImage, memedImage:UIImage) {
        
        self.textTop=textTop
        self.textBottom=textBottom
        self.imageOrigin=imageOrigin
        self.memedImage=memedImage
        
    }
    
    
  
    
}