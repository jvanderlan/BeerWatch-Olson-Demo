//
//  BeerStats.swift
//  Beer Watch
//
//  Created by Toussaint, Joseph on 4/11/15.
//  Copyright (c) 2015 Vanderlan, Jeremiah. All rights reserved.
//

import Foundation

class PourStats : ApiResult, AnyObject {
    var pourCount: Int = 0
    
    var families : Array<FamilyPourStat> = Array<FamilyPourStat>()
}