//
//  ProfileViewController.swift
//  HiDoctor
//
//  Created by Narayan Srivathsan on 9/15/15.
//  Copyright © 2015 Swaas Systems. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var profileImgView: UIImageView!
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var specialityBtn: UIButton!
    
    @IBOutlet weak var firstNameTxtFld: UITextField!
    
    @IBOutlet weak var lastNameTxtFld: UITextField!
    
    @IBOutlet weak var emailTxtFld: UITextField!
    
    @IBOutlet weak var phoneTxtFld: UITextField!
    
    @IBOutlet weak var profileScrollView: UIScrollView!
    
    var passedValue : NSString = "Speciality"
    
    @IBAction func specialitySelect(sender: UIButton) {
        
    }
    
    
    //MARK: - Life Cycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
     
        specialityBtn.setTitle(passedValue as String, forState: .Normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name:UIKeyboardWillHideNotification, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        self.profileScrollView.contentSize = CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT);
        
        let imageArray : NSArray = ["icon-user-profile.png", "", "icon-email.png", "icon-phone.png"]
        
        specialityBtn.layer.borderWidth = 1
        specialityBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        profileView.backgroundColor = navigationBarBg
        profileImgView.layer.cornerRadius = profileImgView.frame.size.height/2
        
        for var i = 1; i <= 4; i++ {
            
            let txtFld = self.view.viewWithTag(i) as! UITextField
            
            let bottomLine = CALayer()
            bottomLine.frame = CGRectMake(0.0, txtFld.frame.height - 1, txtFld.frame.width, 1.0)
            bottomLine.backgroundColor = UIColor.lightGrayColor().CGColor
            txtFld.borderStyle = UITextBorderStyle.None
            txtFld.layer.addSublayer(bottomLine)
            
            if i != 2 {
                
                let imageView = UIImageView()
                let image = UIImage(named: imageArray.objectAtIndex(i-1) as! String)
                imageView.image = image
                imageView.frame = CGRect(x: 10, y: 0, width: 15, height: 15)
                view.addSubview(imageView)
                txtFld.leftView = imageView
                txtFld.leftViewMode = UITextFieldViewMode.Always
            }
        }
       
    }
    
    @IBAction func saveData(sender: UIBarButtonItem) {
        
        view.endEditing(true)

    }
    
    //MARK: - UITextField Delegate methods
    
//    func textFieldDidBeginEditing(textField: UITextField) {
//        
//        let point: CGPoint!
//        point = textfield.frame.origin
//        profileScrollView.contentOffset = point
//    }
    func keyboardWillShow(notification:NSNotification){
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        keyboardFrame = self.view.convertRect(keyboardFrame, fromView: nil)
        
        var contentInset:UIEdgeInsets = self.profileScrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.profileScrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification:NSNotification){
        
        let contentInset:UIEdgeInsets = UIEdgeInsetsZero
        self.profileScrollView.contentInset = contentInset
    }

    func DismissKeyboard() {
        
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
     
        if textField == firstNameTxtFld
        {
            firstNameTxtFld.resignFirstResponder()
        } else if textField == lastNameTxtFld {
            lastNameTxtFld.resignFirstResponder()
        } else if textField == emailTxtFld {
            emailTxtFld.resignFirstResponder()
        } else if textField == phoneTxtFld {
            phoneTxtFld.resignFirstResponder()
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
