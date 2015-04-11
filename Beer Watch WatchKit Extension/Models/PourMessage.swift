//
//  PourMessage.swift
//  Beer Watch
//
//  Created by Toussaint, Joseph on 4/11/15.
//  Copyright (c) 2015 Vanderlan, Jeremiah. All rights reserved.
//

import Foundation

class PourMessage : AnyObject {
    var rating: Int = 0
    var poured_on: NSDate
    
    init() {
        poured_on = NSDate()
    }
}