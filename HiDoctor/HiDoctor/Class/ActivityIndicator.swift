//
//  ActivityIndicator.swift
//  HiDoctor
//
//  Created by Vijay on 11/09/15.
//  Copyright © 2015 Swaas Systems. All rights reserved.
//

import UIKit

public class ActivityIndicator: NSObject
{
    class func showActivityIndicator()
    {
        let indicatorAlert = UIAlertController(title: nil, message: "Loading", preferredStyle: .Alert)
        indicatorAlert.view.backgroundColor = UIColor.clearColor()
        
        let indicatorView = UIActivityIndicatorView(frame: indicatorAlert.view.bounds)
        indicatorView.backgroundColor = UIColor.blackColor()
        indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
        indicatorView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        indicatorView.layer.cornerRadius = 5.0
        indicatorView.userInteractionEnabled = false
        indicatorView.startAnimating()
        indicatorAlert.view.addSubview(indicatorView)
        
        let delay = 0.1 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(indicatorAlert, animated: true, completion: nil)
        })
    }
    
    class func hideActivityIndicator()
    {
        UIApplication.sharedApplication().keyWindow?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}