//
//  WebService.swift
//  HiDoctor
//
//  Created by Vijay on 10/09/15.
//  Copyright © 2015 Swaas Systems. All rights reserved.
//

import UIKit

class WebService: NSObject, NSURLSessionDelegate, NSURLSessionTaskDelegate
{
    //MARK: - WebService
    func getWebServiceResponse(url: String?, requestType: String?, postData: NSString?, callback: (NSArray?,
        String?) -> Void)
    {
        //        if Reachability.isConnectedToNetwork() == true
        //        {
        let request = NSMutableURLRequest(URL: NSURL(string: url!)!)
        //requestType = requestType.capitalizedString
        request.HTTPMethod = requestType!
        if requestType == "POST"
        {
            request.HTTPBody = postData!.dataUsingEncoding(NSUTF8StringEncoding)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
        }
        
        let task = getURLSession().dataTaskWithRequest(request, completionHandler:{
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            dispatch_async(dispatch_get_main_queue(),
                {
                    if error != nil {
                        callback([], error!.localizedDescription)
                    } else {
                        let createAccount: NSString! = wsRootUrl + wsCreateAccountUrl
                        //let speciality: NSString! = wsRootUrl + wsGetSpecialityUrl
                        if url == createAccount
                        {
                            let result = NSString(data: data!, encoding:
                                NSASCIIStringEncoding)!
                            var arr:NSMutableArray! = []
                            arr!.addObject(result)
                            callback(arr!, nil)
                        } else {
                            do {
                                let jsonResponse:NSArray? = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSArray
                                print(jsonResponse)
                                callback(jsonResponse!, nil)
                            } catch {
                                print(error)
                            }
                        }
                    }
            })
        })
        task.resume()
        //        } else {
        //            let alertView = UIAlertController(title: "Internet Alert", message: "Please check the Internet Connection", preferredStyle: UIAlertControllerStyle.Alert)
        //            alertView.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        //            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alertView, animated: true, completion: nil)
        //
        //        }
    }
    
    func getURLSession() -> NSURLSession
    {
        var session:NSURLSession
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        
        return session;
    }
    
    //MARK: - NSUrlSession Delegates
    func URLSession(session: NSURLSession, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
        completionHandler(
            NSURLSessionAuthChallengeDisposition.UseCredential,
            NSURLCredential(forTrust:
                challenge.protectionSpace.serverTrust!))
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, willPerformHTTPRedirection response: NSHTTPURLResponse, newRequest request: NSURLRequest, completionHandler: (NSURLRequest?) -> Void) {
        let newRequest : NSURLRequest? = request
        print(newRequest?.description);
        completionHandler(newRequest)
    }
}