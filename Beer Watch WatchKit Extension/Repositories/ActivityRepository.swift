//
//  ActivityRepository.swift
//  Beer Watch
//
//  Created by Toussaint, Joseph on 4/15/15.
//  Copyright (c) 2015 Vanderlan, Jeremiah. All rights reserved.
//

import Foundation

/**
 * A protocol for activity data
 **/
protocol ActivityRepository {
 
    
    
    /**
     * Rates the provided beer
     **/
    func RateBeer(userId: String, beerId: String, rating: Int) -> ()
    
    
    
    /**
     * Finds a list of pours for a user
     **/
    func FindPours(userId:String, completionHandler: (results: Array<Pour>) -> ())
    
    
    /**
     * Finds a user's stats
     **/
    func FindStats(userId: String, completionHandler: (results: PourStats) -> ()) -> ()
}