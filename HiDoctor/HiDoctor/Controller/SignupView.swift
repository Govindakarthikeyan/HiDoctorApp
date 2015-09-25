//
//  SignupView.swift
//  HiDoctor
//
//  Created by Vijay on 04/09/15.
//  Copyright © 2015 Swaas Systems. All rights reserved.
//

import UIKit

class SignupView: UIView, UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet var headingLbl: UILabel!
    
    @IBOutlet var headingTopConstraint: NSLayoutConstraint!
    @IBOutlet var descLbl: UILabel!
    @IBOutlet var formWrap: UIView!
    @IBOutlet var formWrapRightConstraint: NSLayoutConstraint!
    @IBOutlet var formWrapLeftConstraint: NSLayoutConstraint!
    @IBOutlet var formView: UIView!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var specialityField: UITextField!
    
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var signupBtn: UIButton!
    
    @IBOutlet weak var acceptCheckBoxBtn: UIButton!
    @IBOutlet weak var acceptTermsAndConditionBtn: UIButton!

    
    var referalViewWrap: UIView!
    var acceptTermsAndConditionsView : UIView!
    var referalDescLbl: UILabel!
    var referalField: UITextField!
    var submitBtn: UIButton!
    var indicatorView: UIActivityIndicatorView!
    
    var rightSwipe: UISwipeGestureRecognizer!
    
    var refViewFlag: Bool! = false
    var isCheckBoxBtnSelected: Bool! = false
    var prefId: Int!
    var customerId : Int! = 0
    
    let specialityData: NSMutableArray! = []
    func setUpView()
    {
        let SCREEN_MAX_LENGTH = max(SCREEN_WIDTH, SCREEN_HEIGHT)
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone && SCREEN_MAX_LENGTH < 568.0
        {
            headingTopConstraint.constant = 50.0
        }
        
        headingLbl.font = UIFont(name: fontBold, size: 24.0)
        descLbl.font = UIFont(name: fontRegular, size: 18.0)
        
        formView.layer.borderWidth = 1.0
        formView.layer.borderColor = UIColor(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0).CGColor
        formView.layer.cornerRadius = 5.0
        
        let nameBorderlayer = CALayer()
        nameBorderlayer.frame = CGRectMake(0, nameField.frame.size.height - 1, nameField.frame.size.width, 1.0)
        nameBorderlayer.backgroundColor = UIColor(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0).CGColor
        nameField.layer.addSublayer(nameBorderlayer)

        let namePadding = UIView()
        namePadding.frame = CGRectMake(0, 0, 5, nameField.frame.size.height)
        nameField.leftView = namePadding
        nameField.leftViewMode = UITextFieldViewMode.Always
        
        let emailBorderlayer = CALayer()
        emailBorderlayer.frame = CGRectMake(0, emailField.frame.size.height - 1, emailField.frame.size.width, 1.0)
        emailBorderlayer.backgroundColor = UIColor(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0).CGColor
        emailField.layer.addSublayer(emailBorderlayer)
        
        let emailPadding = UIView()
        emailPadding.frame = CGRectMake(0, 0, 5, emailField.frame.size.height)
        emailField.leftView = emailPadding
        emailField.leftViewMode = UITextFieldViewMode.Always
        
        let specialityPadding = UIView()
        specialityPadding.frame = CGRectMake(0, 0, 5, specialityField.frame.size.height)
        specialityField.leftView = specialityPadding
        specialityField.leftViewMode = UITextFieldViewMode.Always
        
        signupBtn.layer.cornerRadius = 5.0
        let btnTitle = NSAttributedString(string: "CREATE ACCOUNT", attributes: [NSFontAttributeName:UIFont(name: fontBold, size: 18.0)!, NSForegroundColorAttributeName:UIColor.whiteColor()])
        signupBtn.setAttributedTitle(btnTitle, forState: UIControlState.Normal)
        
        // Adding a Swipe Gesture
        rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeOffSignup"))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        self.addGestureRecognizer(rightSwipe)
        
        self.loadReferalKeyView()
    }

    func getSpecialityData()
    {
        showIndicatorView(specialityField, indicatorStyle: .Gray)
        
        let webService = WebService()
        webService.getWebServiceResponse(wsRootUrl + wsGetSpecialityUrl, requestType: "GET", postData:nil) {
        (jsonResponse, error) -> Void in
                    if error != nil
                    {
                        AlertView.showAlertView("Alert", message: error!, delay: true)
                    } else {
                        self.specialityData.addObjectsFromArray(jsonResponse as! [AnyObject])
                        self.pickerView.reloadAllComponents()
                        self.setPickerViewOn()
                        if self.specialityData != nil && self.specialityField.text == ""
                        {
                            self.specialityField.text = self.specialityData[0].objectForKey("Preference_Value") as? String
                        }
                    }
                    self.hideIndicatorView()
                }
    }
    
    
    func loadReferalKeyView()
    {
        referalViewWrap = UIView()
        referalViewWrap.frame = CGRectMake(self.frame.origin.x + SCREEN_WIDTH, (SCREEN_HEIGHT - formWrap.frame.size.height)/2, SCREEN_WIDTH - formWrapLeftConstraint.constant - formWrapRightConstraint.constant, formWrap.frame.size.height)
        self.addSubview(referalViewWrap)
        
        referalDescLbl = UILabel()
        referalDescLbl.frame = CGRectMake(0, 0, referalViewWrap.frame.size.width, descLbl.frame.size.height)
        referalDescLbl.text = "pretium augue posuere, auctor tortor. Curabitur risus quam"
        referalDescLbl.numberOfLines = 2
        referalDescLbl.textAlignment = NSTextAlignment.Center
        referalDescLbl.font = UIFont(name: fontRegular, size: 18.0)
        referalDescLbl.textColor = UIColor(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0)
        referalViewWrap.addSubview(referalDescLbl)
        
        referalField = UITextField()
        referalField.frame = CGRectMake(0, referalDescLbl.frame.origin.y + referalDescLbl.frame.size.height + 20.0, referalViewWrap.frame.size.width, nameField.frame.size.height)
        referalField.delegate = self
        referalField.layer.borderWidth = 1.0
        referalField.layer.borderColor = UIColor(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1.0).CGColor
        referalField.placeholder = "Referal Key"
        referalField.layer.cornerRadius = 5.0
        referalViewWrap.addSubview(referalField)
        
        let referalPadding = UIView()
        referalPadding.frame = CGRectMake(0, 0, 5, referalField.frame.size.height)
        referalField.leftView = referalPadding
        referalField.leftViewMode = UITextFieldViewMode.Always
        
        submitBtn = UIButton()
        submitBtn.frame = CGRectMake(0, referalField.frame.origin.y + referalField.frame.size.height + 20.0, referalViewWrap.frame.size.width, signupBtn.frame.size.height)
        submitBtn.addTarget(self, action: "submitAction", forControlEvents: .TouchUpInside)
        submitBtn.backgroundColor = UIColor(red: 0.0/255.0, green: 118.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        submitBtn.layer.cornerRadius = 5.0
        let btnTitle = NSAttributedString(string: "SUBMIT", attributes: [NSFontAttributeName:UIFont(name: fontBold, size: 18.0)!, NSForegroundColorAttributeName:UIColor.whiteColor()])
        submitBtn.setAttributedTitle(btnTitle, forState: UIControlState.Normal)
        referalViewWrap.addSubview(submitBtn)
    }
    
    @IBAction func checkBoxSelected(sender: AnyObject) {
        
        setPickerViewOff()
        if isCheckBoxBtnSelected == false {
            
            let image = UIImage(named: "icon-checkbox-selected.png") as UIImage!
            acceptCheckBoxBtn.setImage(image, forState: UIControlState.Normal)
            isCheckBoxBtnSelected = true
        } else {
            
            let image = UIImage(named: "icon-checkbox.png") as UIImage!
            acceptCheckBoxBtn.setImage(image, forState: UIControlState.Normal)
            isCheckBoxBtnSelected = false
        }
    }
    
    @IBAction func acceptTermsAndConditions(sender: AnyObject) {
        
        setPickerViewOff()
        
        let acceptTermsAndConditionsViewFrame : CGRect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        acceptTermsAndConditionsView = UIView(frame: acceptTermsAndConditionsViewFrame)
        acceptTermsAndConditionsView.backgroundColor = UIColor.clearColor()
        superview?.addSubview(acceptTermsAndConditionsView)
        
        let navigationViewFrame : CGRect = CGRectMake(0, 0, SCREEN_WIDTH, 64)
        let navigationView : UIView = UIView(frame: navigationViewFrame)
        navigationView.backgroundColor = UIColor(red: 15/255, green: 103/255, blue: 169/255, alpha: 1)
        acceptTermsAndConditionsView.addSubview(navigationView)
        
        let backBtnFrame : CGRect = CGRectMake(0, 0, 50, navigationViewFrame.size.height)
        let backBtn : UIButton = UIButton(frame: backBtnFrame)
        backBtn.setTitle("<", forState: .Normal)
        backBtn.titleLabel?.textColor = UIColor.whiteColor()
        backBtn.titleLabel?.font = UIFont(name: fontRegular, size: 35)
        backBtn.addTarget(self, action: "back", forControlEvents: .TouchUpInside)
        navigationView.addSubview(backBtn)
        
        let navigationViewTitleFrame : CGRect = CGRectMake(0, 0, SCREEN_WIDTH, navigationView.frame.size.height)
        let navigationViewTitleLbl : UILabel = UILabel(frame: navigationViewTitleFrame)
        navigationViewTitleLbl.text = "Accept Terms And Conditions"
        navigationViewTitleLbl.textColor = UIColor.whiteColor()
        navigationViewTitleLbl.textAlignment = NSTextAlignment.Center
        navigationView.addSubview(navigationViewTitleLbl)
        
        let textViewFrame : CGRect = CGRectMake(0, navigationView.frame.size.height, SCREEN_WIDTH, (SCREEN_HEIGHT - navigationView.frame.size.height))
        let textView : UITextView = UITextView(frame: textViewFrame)
        textView.backgroundColor = UIColor.whiteColor()
        textView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus efficitur ex ut congue fringilla. Duis ullamcorper dapibus porttitor. Donec tristique ligula et pulvinar pulvinar. Curabitur aliquet bibendum odio at ultricies. Nam fringilla lacinia tortor in volutpat. Vivamus varius, est id maximus semper, magna erat vehicula metus, ut rhoncus tortor enim in mauris. Vivamus rhoncus ante at nisi blandit, in eleifend enim placerat. Proin sapien magna, rutrum sed consequat vitae, suscipit nec metus. Ut ultricies sagittis ex, vitae dictum massa suscipit ut. Morbi ac odio tempus velit vulputate suscipit quis ut nisi. Nam in urna ut ante tempus mollis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus efficitur ex ut congue fringilla. Duis ullamcorper dapibus porttitor. Donec tristique ligula et pulvinar pulvinar. Curabitur aliquet bibendum odio at ultricies. Nam fringilla lacinia tortor in volutpat. Vivamus varius, est id maximus semper, magna erat vehicula metus, ut rhoncus tortor enim in mauris. Vivamus rhoncus ante at nisi blandit, in eleifend enim placerat. Proin sapien magna, rutrum sed consequat vitae, suscipit nec metus. Ut ultricies sagittis ex, vitae dictum massa suscipit ut. Morbi ac odio tempus velit vulputate suscipit quis ut nisi. Nam in urna ut ante tempus mollis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus efficitur ex ut congue fringilla. Duis ullamcorper dapibus porttitor. Donec tristique ligula et pulvinar pulvinar. Curabitur aliquet bibendum odio at ultricies. Nam fringilla lacinia tortor in volutpat. Vivamus varius, est id maximus semper, magna erat vehicula metus, ut rhoncus tortor enim in mauris. Vivamus rhoncus ante at nisi blandit, in eleifend enim placerat. Proin sapien magna, rutrum sed consequat vitae, suscipit nec metus. Ut ultricies sagittis ex, vitae dictum massa suscipit ut. Morbi ac odio tempus velit vulputate suscipit quis ut nisi. Nam in urna ut ante tempus mollis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus efficitur ex ut congue fringilla. Duis ullamcorper dapibus porttitor. Donec tristique ligula et pulvinar pulvinar. Curabitur aliquet bibendum odio at ultricies. Nam fringilla lacinia tortor in volutpat. Vivamus varius, est id maximus semper, magna erat vehicula metus, ut rhoncus tortor enim in mauris. Vivamus rhoncus ante at nisi blandit, in eleifend enim placerat. Proin sapien magna, rutrum sed consequat vitae, suscipit nec metus. Ut ultricies sagittis ex, vitae dictum massa suscipit ut. Morbi ac odio tempus velit vulputate suscipit quis ut nisi. Nam in urna ut ante tempus mollis."
        textView.textColor = UIColor.blackColor()
        textView.font =  UIFont(name: fontRegular, size: 15)
        acceptTermsAndConditionsView.addSubview(textView)
        
    }
    
    func back() {
        
        acceptTermsAndConditionsView.removeFromSuperview()
    }
    
    func submitAction()
    {
        showIndicatorView(submitBtn, indicatorStyle: .White)
        
        let jsonString: NSString! = "{\n\"Customer_FName\": \"\(nameField.text!)\",\n\"Customer_LName\": \"\",\n\"Customer_Email\": \"\(emailField.text!)\",\n\"Customer_Phone\": \"\",\n\"Customer_Secret_Key\": \"\(referalField.text!)\",\n\"Customer_Preferene1\": \"\(prefId)\"\n}"
        
        let webService = WebService()
        let url: NSString? = wsRootUrl + wsCreateAccountUrl
        let reqType: NSString? = "POST"
        webService.getWebServiceResponse(url as? String, requestType: reqType as? String, postData: jsonString!) {
            (jsonResponse, error) -> Void in
            if error != nil
            {
                AlertView.showAlertView("Alert", message: error, delay: true)
            } else {
                let response:NSString! = jsonResponse?.objectAtIndex(0) as? NSString
                let custId:Int! = response.integerValue
                if custId > 0
                {
                    self.customerId = custId
                }
                
                self.saveSignupData()
                
                let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
                delegate.tabbarRootController()
                return;
            }
            self.hideIndicatorView()
            
//            var result:NSString! = jsonResponse?.objectAtIndex(0) as? NSString
//            let resultNo:Int32! = result.intValue
//            
//            if resultNo > 0
//            {
//                let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
//                delegate.tabbarRootController()
//                return;
//            } else {
//                if resultNo == -1
//                {
//                    let alert = UIAlertController(title: "Alert", message: "Authentication Failure", preferredStyle: UIAlertControllerStyle.Alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
//                    let delay = 1.0 * Double(NSEC_PER_SEC)
//                    var time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
//                    dispatch_after(time, dispatch_get_main_queue(), {
//                        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
//                    })
//                } else if resultNo == -2 {
//                    let alert = UIAlertController(title: "Alert", message: "Invalid Secret Key", preferredStyle: UIAlertControllerStyle.Alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
//                    let delay = 1.0 * Double(NSEC_PER_SEC)
//                    var time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
//                    dispatch_after(time, dispatch_get_main_queue(), {
//                        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
//                    })
//                }
//            }
        }
        
    }
    
    func saveSignupData()
    {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        userDefaults.setObject(nameField.text, forKey:userName)
        userDefaults.setObject(emailField.text, forKey:userEmail)
        userDefaults.setObject(customerId, forKey: userId)
        
        userDefaults.synchronize()
    }
    
    @IBAction func showPickerView(sender: AnyObject)
    {
        self.endEditing(true)
        
        self.getSpecialityData()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == nameField
        {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            emailField.resignFirstResponder()
        } else if textField == referalField {
            referalField.resignFirstResponder()
        }
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return specialityData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return specialityData[row].objectForKey("Preference_Value") as? String
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        specialityField.text = specialityData[row].objectForKey("Preference_Value") as? String
        prefId = specialityData[row].objectForKey("Preference_Value_Id") as? Int
        print(prefId)
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLbl = UILabel()
        let titleData = specialityData[row].objectForKey("Preference_Value")
        let specialityTitle = NSAttributedString(string: titleData as! String, attributes: [NSFontAttributeName:UIFont(name: fontRegular, size: 24.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLbl.attributedText = specialityTitle
        pickerLbl.textAlignment = NSTextAlignment.Center
        return pickerLbl
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.endEditing(true)
        self.setPickerViewOff()
    }
    
    @IBAction func signupAction(sender: AnyObject)
    {
        //FIXME: - Remove this codition once tabbar navigation works from submit button
        if debugType == 1
        {
            /*
            let home_sb = UIStoryboard(name: sbPatient, bundle: nil)
            let controller = home_sb.instantiateViewControllerWithIdentifier(vcPatient) as UIViewController
            let navigationController :UINavigationController = UINavigationController()
            self.window?.rootViewController = navigationController
            navigationController.navigationBarHidden = true
            navigationController.pushViewController(controller, animated: true)
            */
            let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
            delegate.tabbarRootController()
            return;
        }
        
        setPickerViewOff()
        
        if nameField.text?.characters.count == 0
        {
            AlertView.showAlertView("Error", message: "Invalid Name", delay: false)
        }
        else if emailField.text?.characters.count == 0 || !Validation.isValidEmail(emailField.text!){
            AlertView.showAlertView("Error", message: "Invalid Email", delay: false)
        }
        else if specialityField.text?.characters.count == 0 {
            AlertView.showAlertView("Error", message: "Invalid Speciality", delay: false)
        } else if isCheckBoxBtnSelected == false {
            
            AlertView.showAlertView("Error", message: "Accept terms and conditions", delay: false)
            
//            acceptCheckBoxBtn.layer.cornerRadius = 20
            let image = UIImage(named: "icon-checkbox-unselected.png") as UIImage!
            acceptCheckBoxBtn.setImage(image, forState: UIControlState.Normal)
            
        } else {
            referalField.text = ""
            self.setReferalViewOn()
        }
    }

    func showIndicatorView(view: UIView!, indicatorStyle: UIActivityIndicatorViewStyle!)
    {
        self.userInteractionEnabled = false
        
        let viewPadding:CGFloat! = 10.0;
        let indicatorSize:CGFloat! = view.frame.size.height - (viewPadding * 2)
        let indicatorXoffset:CGFloat! = view.frame.size.width - viewPadding - indicatorSize
        let rect:CGRect = CGRectMake(indicatorXoffset, viewPadding, indicatorSize, indicatorSize)
        
        indicatorView = UIActivityIndicatorView(frame: rect)
        indicatorView.activityIndicatorViewStyle = indicatorStyle
        indicatorView.startAnimating()
        view.addSubview(indicatorView)
    }
    
    func hideIndicatorView()
    {
        indicatorView.stopAnimating()
        indicatorView.removeFromSuperview()
        
        self.userInteractionEnabled = true
    }
    
    func setSignupViewOn()
    {
        UIView.animateWithDuration(0.5, animations: {
            self.userInteractionEnabled = false
            self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
            }, completion: {
                (value: Bool) in self.userInteractionEnabled = true
        })
    }
    
    func setSignupViewOff()
    {
        UIView.animateWithDuration(0.5, animations: {
            self.userInteractionEnabled = false
            self.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
            }, completion: {
                (value: Bool) in self.userInteractionEnabled = true
        })
    }
    
    func setPickerViewOn()
    {
        UIView.animateWithDuration(0.3, animations: {
            self.pickerView.userInteractionEnabled = false
            self.pickerView.layoutIfNeeded()
            self.pickerView.frame = CGRectMake(self.pickerView.frame.origin.x, self.frame.origin.y + self.frame.size.height - self.pickerView.frame.size.height, self.pickerView.frame.size.width, self.pickerView.frame.size.height)
            }, completion: {
                (value: Bool) in self.pickerView.userInteractionEnabled = true
        })
    }
    
    func setPickerViewOff()
    {
        UIView.animateWithDuration(0.3, animations: {
            self.pickerView.userInteractionEnabled = false
            self.pickerView.layoutIfNeeded()
            self.pickerView.frame = CGRectMake(self.pickerView.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.pickerView.frame.size.width, self.pickerView.frame.size.height)
            }, completion: {
                (value: Bool) in self.pickerView.userInteractionEnabled = true
        })
    }
    
    func setReferalViewOn()
    {
        UIView.animateWithDuration(0.7, animations:
            {
            self.referalViewWrap.userInteractionEnabled = false
            self.formWrap.userInteractionEnabled = false
            self.formWrap.layoutIfNeeded()
            self.referalViewWrap.frame = CGRectMake(self.formWrapLeftConstraint.constant, (SCREEN_HEIGHT - self.formWrap.frame.size.height)/2, SCREEN_WIDTH - self.formWrapLeftConstraint.constant - self.formWrapRightConstraint.constant, self.formWrap.frame.size.height)
            self.formWrap.frame = CGRectMake(-self.frame.size.width, self.formWrap.frame.origin.y, 0, self.formWrap.frame.size.height)
            self.formWrapRightConstraint.constant =  self.frame.size.width+self.formWrapLeftConstraint.constant+self.formWrapRightConstraint.constant
            self.formWrapLeftConstraint.constant = -self.frame.size.width
            }, completion: {
                (value: Bool) in
                self.referalViewWrap.userInteractionEnabled = true
                self.formWrap.userInteractionEnabled = true
                self.refViewFlag = true
                self.removeGestureRecognizer(self.rightSwipe)
        })
    }
    
    func swipeOffSignup()
    {
        setSignupViewOff()
        setPickerViewOff()
        self.endEditing(true)
    }
    
}