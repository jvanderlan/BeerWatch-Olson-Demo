//
//  Pour.swift
//  Beer Watch
//
//  Created by Toussaint, Joseph on 4/11/15.
//  Copyright (c) 2015 Vanderlan, Jeremiah. All rights reserved.
//

import Foundation

class Pour : ApiResult, AnyObject {
    var type: String = ""
    var userId: String = ""
    var beerId: String = ""
    var rating: Int = 0
}