//
//  AlertView.swift
//  HiDoctor
//
//  Created by Vijay on 15/09/15.
//  Copyright © 2015 Swaas Systems. All rights reserved.
//

import UIKit

class AlertView: NSObject
{
    class func showAlertView(title: String?, message: String?, delay: Bool?)
    {
        let alert = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        if delay == true
        {
            let delay = 1.0 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue(), {
                UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
            })
        } else {
            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
