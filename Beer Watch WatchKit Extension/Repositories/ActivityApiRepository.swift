//
//  ActivityApiRepository.swift
//  Beer Watch
//
//  Created by Toussaint, Joseph on 4/15/15.
//  Copyright (c) 2015 Vanderlan, Jeremiah. All rights reserved.
//

import Foundation

/**
 * A Repository for looking up Activity information
 **/
class ActivityApiRepository : BeerWatchRepository, ActivityRepository {
    
    
    /**
     * Rates the provided beer
     **/
    func RateBeer(userId: String, beerId: String, rating: Int) -> () {
        var query = "/api/user/" + userId + "/pour/" + beerId
        
        var message = NSDictionary(objectsAndKeys: rating, "rating", NSDate().timeIntervalSince1970, "poured_on")
        
        var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
        let jsonBody : NSData? = NSJSONSerialization.dataWithJSONObject(message, options: NSJSONWritingOptions.PrettyPrinted, error: error)
        
        ApiRESTfulPut(query, jsonData: jsonBody)
    }
    
    
    
    /**
     * Finds a list of pours for a user
     **/
    func FindPours(userId:String, completionHandler: (results: Array<Pour>) -> ()) {
        let query = "/api/user/" + userId + "/pour"
        
        ApiRESTfulGet(query, mappingCallback: { (entityResult) -> ApiResult in
            var pour = Pour()
            
            pour.type = entityResult["type"] as! String;
            pour.userId = entityResult["user_id"] as! String;
            pour.beerId = entityResult["beer_id"] as! String
            
            if let var rating = entityResult["rating"] as? Int {
                pour.rating = rating
            }
            
            return pour;
        }) { (results) -> () in
            var pours = Array<Pour>()
            for m in results {
                pours.append(m as! Pour)
            }
            completionHandler(results: pours)
        }
    }
    
    
    
    /**
     * Finds a user's stats
     **/
    func FindStats(userId: String, completionHandler: (results: PourStats) -> ()) {
        let query = "/api/user/" + userId + "/stats"
        
        ApiRESTfulGet(query, mappingCallback: { (entityResult) -> ApiResult in
            var stats = PourStats()
            
            stats.pourCount = entityResult["pour_count"] as! Int;
            
            if let pourFamilyEntityResults = entityResult["families"] as? NSArray {
                for arrayMember in pourFamilyEntityResults {
                    if let pourFamilyEntityResults = arrayMember as? NSDictionary {
                        var familyPourStat = FamilyPourStat()
                        familyPourStat.count = pourFamilyEntityResults["count"] as! Int
                        familyPourStat.family = pourFamilyEntityResults["family"] as! String
                        
                        stats.families.append(familyPourStat)
                    }
                }
            }
            
            return stats;
        }) { (results) -> () in
            var stats = results[0] as! PourStats
            completionHandler(results: stats)
        }
    }
}