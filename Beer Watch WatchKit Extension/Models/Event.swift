//
//  Event.swift
//  Beer Watch
//
//  Created by Toussaint, Joseph on 4/16/15.
//  Copyright (c) 2015 Vanderlan, Jeremiah. All rights reserved.
//

import Foundation

class Event : ApiResult, AnyObject {
    var locationId: String = ""
    var eventname: String = ""
    var startDate: NSDate = NSDate()
}