//
//  Validation.swift
//  HiDoctor
//
//  Created by Vijay on 07/09/15.
//  Copyright © 2015 Swaas Systems. All rights reserved.
//

import UIKit

class Validation: NSObject
{
    class func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let range = testStr.rangeOfString(emailRegEx, options:.RegularExpressionSearch)
        let result = (range != nil ? true : false)
        return result
    }
    
    class func getUTCOffset() -> Int {
        let UTCOffset:Int = NSTimeZone.localTimeZone().secondsFromGMT
        return UTCOffset / 60
    }
}
