//
//  BeerRecommendationRepository.swift
//  Hello Watch
//
//  Created by Toussaint, Joseph on 4/9/15.
//  Copyright (c) 2015 Toussaint, Joseph. All rights reserved.
//

import Foundation

class BeerRecommendationRepository {
    

    func Search(query: String,
                mappingCallback: (searchResult: NSDictionary) -> SearchResult,
                completionHandler: (results: Array<SearchResult>) -> ())  {
        
        var url : String = "https://icfironworks229.search.windows.net/indexes/beers/docs?" + query + "&api-version=2015-02-28-Preview"
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        request.addValue("AEEF16A0EC0F70F38B62A4A6BF175A7D", forHTTPHeaderField: "api-key")
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        NSURLConnection.sendAsynchronousRequest(
            request,
            queue: NSOperationQueue(),
            completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                
                var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
                let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
                
                var mappedResults = Array<SearchResult>()
                
                if (jsonResult != nil) {
                    
                    if let beerList = jsonResult["value"] as? NSArray {
                        
                        for searchResult in beerList {
                            if let beerResult = searchResult as? NSDictionary {
                                var mappedEntity = mappingCallback(searchResult: beerResult)
                                
                                mappedResults.append(mappedEntity)
                            }
                        }
                    }
                    
                } else {
                    // couldn't load JSON, look at error
                }
                
                completionHandler(results: mappedResults)
        })
    }
    
    func ApiCall(pathAndQuery: String,
                 mappingCallback: (entityResult: NSDictionary) -> ApiResult,
                 completionHandler: (results: Array<ApiResult>) -> ())  {
                    
        var url = "http://localhost:3000" + pathAndQuery
        
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        
        NSURLConnection.sendAsynchronousRequest(
            request,
            queue: NSOperationQueue(),
            completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                
                var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
                let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error)
                
                var mappedResults = Array<ApiResult>()
                
                if (jsonResult != nil) {
                    
                    if let jsonResultArray = jsonResult as? NSArray {
                        for result in jsonResultArray {
                            if let entityResult = result as? NSDictionary {
                                var mappedEntity = mappingCallback(entityResult: entityResult)
                            
                                mappedResults.append(mappedEntity)
                            }
                        }
                    }
                    else {
                        if let entityResult = jsonResult as? NSDictionary {
                            var mappedEntity = mappingCallback(entityResult: entityResult)
                            
                            mappedResults.append(mappedEntity)
                        }
                    }
                    
                } else {
                    // couldn't load JSON, look at error
                }
                
                completionHandler(results: mappedResults)
        })
    }
    
    func FindStats(userId: String, completionHandler: (results: PourStats) -> ()) {
        let query = "/api/user/" + userId + "/stats"
        
        ApiCall(query,
            mappingCallback: {(entityResult: NSDictionary) -> ApiResult in
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
            },
            completionHandler: {(mappedResults: Array<ApiResult>) -> () in
                var stats = mappedResults[0] as! PourStats
                completionHandler(results: stats)
            }
        )
    }
    
    func FindBeer(beerId: String, completionHandler: (results: Beer) -> ()) {
        let query = "/api/beers/" + beerId
        
        ApiCall(query,
            mappingCallback: {(entityResult: NSDictionary) -> ApiResult in
                var beer = Beer()
                
                beer.id = entityResult["id"] as! String;
                beer.name = entityResult["name"] as! String;
                beer.imageLocation = entityResult["image_url"] as! String
                beer.style = entityResult["beerFamily"] as! String
                
                if let brewerEntityResult = entityResult["brewer"] as? NSDictionary {
                    beer.brewer = Brewer()
                    beer.brewer.name = brewerEntityResult["name"] as! String
                    beer.brewer.locationState = brewerEntityResult["location_state"] as! String
                    beer.brewer.locationCity = brewerEntityResult["location_city"] as! String
                    beer.brewer.locationCountry = brewerEntityResult["location_country"] as! String
                }
                
                return beer;
            },
            completionHandler: {(mappedResults: Array<ApiResult>) -> () in
                var beer = mappedResults[0] as! Beer
                completionHandler(results: beer)
            }
        )
    }

    func FindAllBeers(completionHandler: (results: Array<Beer>) -> ()) {
        
        let query = "/api/beers"
        
        ApiCall(query,
            mappingCallback: {(entityResult: NSDictionary) -> ApiResult in
                var beer = Beer()
                
                beer.id = entityResult["id"] as! String;
                beer.name = entityResult["name"] as! String;
                beer.imageLocation = entityResult["image_url"] as! String
                beer.style = entityResult["beerFamily"] as! String
                
                if let brewerEntityResult = entityResult["brewer"] as? NSDictionary {
                    beer.brewer = Brewer()
                    beer.brewer.name = brewerEntityResult["name"] as! String
                    beer.brewer.locationState = brewerEntityResult["location_state"] as! String
                    beer.brewer.locationCity = brewerEntityResult["location_city"] as! String
                    beer.brewer.locationCountry = brewerEntityResult["location_country"] as! String
                }
                
                return beer;
            },
            completionHandler: {(mappedResults: Array<ApiResult>) -> () in
                var beers = Array<Beer>()
                for m in mappedResults {
                    beers.append(m as! Beer)
                }
                completionHandler(results: beers)
            }
        )
    }
    
    func FindPours(userId:String, completionHandler: (results: Array<Pour>) -> ()) {
        let query = "/api/user/" + userId + "/pour"
        
        ApiCall(query,
            mappingCallback: {(entityResult: NSDictionary) -> ApiResult in
                var pour = Pour()
                
                pour.type = entityResult["type"] as! String;
                pour.userId = entityResult["user_id"] as! String;
                pour.beerId = entityResult["beer_id"] as! String
                
                if let var rating = entityResult["rating"] as? Int {
                    pour.rating = rating
                }
                
                return pour;
            },
            completionHandler: {(mappedResults: Array<ApiResult>) -> () in
                var pours = Array<Pour>()
                for m in mappedResults {
                    pours.append(m as! Pour)
                }
                completionHandler(results: pours)
            }
        )
    }
    
    func FindBeersLike(beerId: String, completionHandler: (results: Array<Beer>) -> ()) {
        
        let query = "searchFields=hops,hopProfile,beerFamily&moreLikeThis=" + beerId
        
        Search(query,
            mappingCallback: {(searchResult: NSDictionary) -> SearchResult in
                var beer = Beer()
                
                beer.searchScore = searchResult["@search.score"] as! Double;
                beer.id = searchResult["id"] as! String;
                beer.name = searchResult["name"] as! String;
                beer.imageLocation = searchResult["imageLocation"] as! String;
                beer.url =  searchResult["url"] as! String;
                beer.event = searchResult["event"] as! String;
                beer.description = searchResult["description"] as! String;
                beer.style = "IPA"
                beer.beerFamilies = Array<String>();
                beer.hops = Array<String>();
                beer.flavorProfiles = Array<String>();
                //beer.brewer = searchResult["brewer"] as! String;
                beer.abv = searchResult["abv"] as! Double;
                beer.ibu = searchResult["ibu"] as! Double;
                beer.srm = searchResult["srm"] as! Double;
            
                return beer;
            },
            completionHandler: {(mappedResults: Array<SearchResult>) -> () in
                var beers = Array<Beer>()
                for m in mappedResults {
                    beers.append(m as! Beer)
                }
                completionHandler(results: beers)
            }
        )
    }
    
    func RateBeer(userId: String, beerId: String, rating: Int) -> () {
        var url = "http://localhost:3000/api/user/" + userId + "/pour/" + beerId
        
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        var message = NSDictionary(objectsAndKeys: rating, "rating", NSDate().timeIntervalSince1970, "poured_on")
        
        var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
        let jsonBody = NSJSONSerialization.dataWithJSONObject(message, options: NSJSONWritingOptions.PrettyPrinted, error: error)
        
        request.HTTPBody = jsonBody
        
        NSURLConnection.sendAsynchronousRequest(
            request,
            queue: NSOperationQueue(),
            completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                
        })
    }
    
    
}