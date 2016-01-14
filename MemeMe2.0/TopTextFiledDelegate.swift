//
//  TopTextFiledDelegate.swift
//  PickingImages
//
//  Created by MacbookPRV on 11/01/2016.
//  Copyright © 2016 Pastouret Roger. All rights reserved.
//

import Foundation
import UIKit


class TopTextFiledDelegate : NSObject, UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
        
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        textField.text=""
        return true
    }
    
}
