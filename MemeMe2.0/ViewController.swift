//
//  ViewController.swift
//  PickingImages
//
//  Created by MacbookPRV on 08/01/2016.
//  Copyright © 2016 Pastouret Roger. All rights reserved.
//

import UIKit






class ViewController: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate {
    
    
  
    @IBOutlet weak var appTopbar: UIToolbar!
    @IBOutlet weak var appToolbar: UIToolbar!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var TopTextFiled: UITextField!
    @IBOutlet weak var BottomTextFiled: UITextField!
    
    let topdelegate = TopTextFiledDelegate()
    let bottomdelegate = BottomTextFiledDelegate()
    var meme:MemeMod!
    
    let memeTextAttributes = [
    NSStrokeColorAttributeName:UIColor.blackColor(),
    NSForegroundColorAttributeName:UIColor.whiteColor(),
    NSFontAttributeName:UIFont(name:"HelveticaNeue-CondensedBlack", size: 40)!,
    NSStrokeWidthAttributeName:3.0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        TopTextFiled.defaultTextAttributes=memeTextAttributes
        TopTextFiled.textAlignment=NSTextAlignment.Center
        BottomTextFiled.defaultTextAttributes=memeTextAttributes
        BottomTextFiled.textAlignment=NSTextAlignment.Center
        TopTextFiled.delegate=topdelegate
        BottomTextFiled.delegate=bottomdelegate
        shareButton.enabled = false
    }

    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        subscibeToKeyboardNotifications()
        
        cameraButton.enabled=UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        
        
        }
    
    
    func  subscibeToKeyboardNotifications() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        
        return true
    }
    
    func unsubscribeFromKeyboardNotifications() {

        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
    }

    func keyboardWillShow(notification:NSNotification) {
    
        view.frame.origin.y-=getkeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification:NSNotification) {
        
        view.frame.origin.y+=getkeyboardHeight(notification)
    }
    
    
    func getkeyboardHeight(notification:NSNotification)->CGFloat {
    
        let userInfo = notification.userInfo
        let keyboardSize=userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
        
    }
    

    

    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        
        imagePickerView.image=image
        imagePickerView.contentMode=UIViewContentMode.Redraw
        TopTextFiled.text=image.description
        
        shareButton.enabled = true

        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    @IBAction func albumAction(sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate=self
        imagePicker.sourceType=UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func shareAction(sender: AnyObject) {
        
        //todo : save meme
        SaveMeme()
        //todo : share meme
        let activitiesVC = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
        presentViewController(activitiesVC, animated: true, completion: nil)
        
        
            }
    
    
    func SaveMeme() {
        
        //create the meme
        meme = MemeMod(textTop: TopTextFiled.text!, textBottom: BottomTextFiled.text!, imageOrigin: imagePickerView.image!, memedImage: generateMemedImage())
        
    }
    
    @IBAction func cameraAction(sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate=self
        imagePicker.sourceType=UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
       
    }
    
    
    
    
    func generateMemedImage()->UIImage {
        
        // TODO: Hide toolbar and navbar

        appToolbar.hidden=true
        appTopbar.hidden=true
        
        //Render view to an image 
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedimage:UIImage=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // TODO:  Show toolbar and navbar 
         appToolbar.hidden=false
         appTopbar.hidden=false
        
        return memedimage
    }
    
}
