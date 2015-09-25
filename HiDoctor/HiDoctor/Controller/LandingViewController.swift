//
//  LandingViewController.swift
//  HiDoctor
//
//  Created by Vijay on 01/09/15.
//  Copyright © 2015 Swaas Systems. All rights reserved.
//

import UIKit

let dotDiameter:CGFloat = 10
let dotSpacer:CGFloat = 5

class LandingViewController: UIViewController, UIScrollViewDelegate
{
    
    //MARK: - Declarations
    @IBOutlet var imageSlider: UIScrollView!
    //    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var submitBtn: UIButton!
    @IBOutlet weak var btmView: UIView!
    
    var signupView: SignupView!
    var pageImages: [UIImage] = []
    var pageViews: [UIImageView?] = []
    var pageControlView: UIView!
    var currentPage = 0
    var kbHeight: CGFloat!
    
    //MARK: - Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //        pageControl.transform = CGAffineTransformMakeScale(1.4, 1.4);
        
        //        submitBtn.titleLabel!.font =  UIFont(name: "SourceSansPro-Regular.otf", size: 13)
        
        // Loading a Array of Slider Images
        pageImages = [UIImage(named: "slider_image1")!,
            UIImage(named: "slider_image1")!,UIImage(named: "slider_image1")!,UIImage(named: "slider_image1")!]
        let pageCount = pageImages.count
        
        // Pagecontrol Settings
        //        pageControl.currentPage = 0
        //        pageControl.numberOfPages = pageCount
        
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
        // Setting the Slider Content Size
        imageSlider.layoutIfNeeded()
        let pagesScrollViewSize = imageSlider.frame.size
        imageSlider.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageImages.count),
            height: pagesScrollViewSize.height)
        
        // Custom Page Control
        loadCustomPageControl()
        
        //        customPageControlIndicatorColor()
        
        loadVisiblePages()
        
        loadSignupPage()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Status Bar
    override func prefersStatusBarHidden() -> Bool {
        
        return true
    }
    
    //MARK: - Keyboard Show / Hidden
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            signupView.setPickerViewOff()
            if let keyboardSize =  (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                kbHeight = keyboardSize.height
                self.animateTextField(true)
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.animateTextField(false)
    }
    
    //MARK: - TextField Animation
    func animateTextField(up: Bool) {
        signupView.formWrap.layoutIfNeeded()
        signupView.referalViewWrap.layoutIfNeeded()
        let viewBtmPadding: CGFloat!
        if signupView.refViewFlag == true
        {
            viewBtmPadding = CGFloat(self.view.frame.size.height - (signupView.referalViewWrap.frame.origin.y + signupView.referalViewWrap.frame.size.height + 20))
        } else {
            viewBtmPadding = CGFloat(self.view.frame.size.height - (signupView.formWrap.frame.origin.y + signupView.formWrap.frame.size.height + 20))
        }
        let movement = (up ? (viewBtmPadding - kbHeight) : 0)
        
        UIView.animateWithDuration(0.3, animations: {
            //self.signupView.userInteractionEnabled = false
            //print("Before Signup frame \(self.signupView.frame)")
            self.signupView.frame = CGRectMake(self.signupView.frame.origin.x, movement, self.signupView.frame.size.width, self.signupView.frame.size.height)

            //print("After Signup frame \(self.signupView.frame)")
            }, completion: nil)
    }
    
    
    
    //MARK: - Page Controll
    func loadCustomPageControl()
    {
        let pageControlwidth:CGFloat = (dotDiameter * CGFloat(pageImages.count+1)) + (dotSpacer * CGFloat(pageImages.count))
        btmView.layoutIfNeeded()
        let pageControlYOffset:CGFloat = (btmView.frame.size.height - dotDiameter)/2
        
        let pageControlViewFrame : CGRect = CGRectMake((btmView.frame.size.width - pageControlwidth)/2, pageControlYOffset, pageControlwidth, dotDiameter)
        
        let pageControlView : UIView = UIView(frame: pageControlViewFrame)
        pageControlView.backgroundColor = UIColor.clearColor()
        btmView.addSubview(pageControlView)
        
        var dotXOffset:CGFloat = 0
        for var i = 0; i <= pageImages.count; i++ {
            
            if i == pageImages.count {
                
                var ImageView: UIImageView = UIImageView()
                let image: UIImage = UIImage(named: "icon-user.png")!
                ImageView = UIImageView(image: image)
                ImageView.frame = CGRectMake(dotXOffset, 0, dotDiameter, dotDiameter)
                pageControlView.addSubview(ImageView)
                
            } else {
                
                let view: UIView = UIView()
                view.frame = CGRectMake(dotXOffset, 0, dotDiameter, dotDiameter)
                view.layer.masksToBounds = false;
                view.layer.cornerRadius = view.frame.size.height/2;
                view.clipsToBounds = true;
                view.tag = i
                if view.tag == currentPage {
                    
                    view.backgroundColor = UIColor.whiteColor()
                } else {
                    
                    view.backgroundColor = UIColor.grayColor()
                }
                pageControlView.addSubview(view)
            }
            
            dotXOffset = dotXOffset + dotSpacer + dotDiameter
        }
    }
    
    //    func customPageControlIndicatorColor()
    //    {
    //        var view: UIView!
    //
    //        for var i = 0; i < pageImages.count; i++ {
    //
    ////            var view: UIView!
    //
    //            view = self.view.viewWithTag(i)
    //
    //            if view.tag == currentPage {
    //
    //                view.backgroundColor = UIColor.whiteColor()
    //
    //            } else {
    //
    //                view.backgroundColor = UIColor.grayColor()
    //            }
    //        }
    //    }
    
    func purgePage(page: Int)
    {
        if page < 0 || page >= pageImages.count
        {
            return
        }
        
        if let pageView = pageViews[page]
        {
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
    }
    
    func loadPage(page: Int)
    {
        if page < 0 || page >= pageImages.count
        {
            return
        }
        
        if let _ = pageViews[page] {
            // Do nothing. The view is already loaded.
        } else {
            // Adding the Imageviews
            var frame = imageSlider.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            
            let newPageView = UIImageView(image: pageImages[page])
            newPageView.contentMode = .ScaleAspectFill
            newPageView.frame = frame
            imageSlider.addSubview(newPageView)
            
            pageViews[page] = newPageView
        }
    }
    
    func loadVisiblePages()
    {
        // First, determine which page is currently visible
        let pageWidth = imageSlider.frame.size.width
        let page = Int(floor((imageSlider.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
    
        //        pageControl.currentPage = page
        currentPage = page
        print(currentPage)
        //        customPageControlIndicatorColor()
        
        let firstPage = page - 1
        let lastPage = page + 1
        
        // Purge anything before the first page
        for var index = 0; index < firstPage; ++index {
            purgePage(index)
        }
        
        // Load pages in our range
        for index in firstPage...lastPage {
            loadPage(index)
        }
        
        // Purge anything after the last page
        for var index = lastPage+1; index < pageImages.count; ++index {
            purgePage(index)
        }
    }
    
    func loadSignupPage()
    {
        // Adding a Signup View
        signupView = NSBundle.mainBundle().loadNibNamed(xibSignUp, owner: self, options: nil)[0] as! SignupView
        signupView.setUpView()
        let signupViewXOffset = CGFloat(self.view.frame.origin.x + self.view.frame.size.width)
        signupView.frame = CGRectMake(signupViewXOffset, 0, self.view.frame.size.width, self.view.frame.size.height)
        self.view.addSubview(signupView)
    }
    
    //MARK: - Scrollview Delegate
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        
        
        //        customPageControlIndicatorColor()
        loadCustomPageControl()
        
        loadVisiblePages()
        
        let signupViewXOffset = CGFloat(imageSlider.contentSize.width - imageSlider.frame.size.width)
        if imageSlider.contentOffset.x > signupViewXOffset
        {
            imageSlider.scrollEnabled = false
            //            submitBtn.hidden = true
            //            pageControl.hidden = true
            
            //signupView.getSpecialityData()
            signupView.setSignupViewOn()
        } else {
            imageSlider.scrollEnabled = true
            //            submitBtn.hidden = false
            //            pageControl.hidden = false
        }
    }
    
    //MARK: - Button Action
    @IBAction func submitAction(sender: AnyObject)
    {
        //ActivityIndicator.showActivityIndicator()
        //signupView.getSpecialityData()
        signupView.setSignupViewOn()
    }
}

