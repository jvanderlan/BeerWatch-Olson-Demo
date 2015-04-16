//
//  ActivityMockRepository.swift
//  Beer Watch
//
//  Created by Toussaint, Joseph on 4/15/15.
//  Copyright (c) 2015 Vanderlan, Jeremiah. All rights reserved.
//

import Foundation

class ActivityMockRepository : ActivityRepository {
 
    
    /**
    * Rates the provided beer
    **/
    func RateBeer(userId: String, beerId: String, rating: Int) -> () {
        
    }
    
    
    
    /**
    * Finds a list of pours for a user
    **/
    func FindPours(userId:String, completionHandler: (results: Array<Pour>) -> ()) {
        var pour = Pour()
        
        pour.beerId = "1"
        pour.rating = 3
        
        var pours = Array<Pour>()
        pours.append(pour)
        
        completionHandler(results: pours)
    }
    
    
    /**
    * Finds a user's stats
    **/
    func FindStats(userId: String, completionHandler: (results: PourStats) -> ()) {
        var pourStats = PourStats()
        
        pourStats.pourCount = 30
        
        var ipaPourStat = FamilyPourStat()
        ipaPourStat.count = 15
        ipaPourStat.family = "IPA"
        
        var stoutPourStat = FamilyPourStat()
        stoutPourStat.count = 10
        stoutPourStat.family = "Stout"
        
        var lightLagerPourStat = FamilyPourStat()
        lightLagerPourStat.count = 5
        lightLagerPourStat.family = "Light Lager"
        
        pourStats.families.append(ipaPourStat)
        pourStats.families.append(stoutPourStat)
        pourStats.families.append(lightLagerPourStat)
        
        completionHandler(results: pourStats)
    }
    
}