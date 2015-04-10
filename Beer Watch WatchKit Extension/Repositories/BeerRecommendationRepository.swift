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
    
    
    func FindBeersLike(beerId: NSString, completionHandler: (results: Array<Beer>) -> ()) {
        
        let query = "searchFields=hops,hopProfile,beerFamily&moreLikeThis=" + beerId
        
        Search(query,
            mappingCallback: {(searchResult: NSDictionary) -> SearchResult in
            var beer = Beer(
                searchScore: searchResult["@search.score"] as Double,
                id: searchResult["id"] as String,
                name: searchResult["name"] as String,
                imageLocation: searchResult["imageLocation"] as String,
                url: searchResult["url"] as String,
                event: searchResult["event"] as String,
                description: searchResult["description"] as String,
                beerFamilies: Array<String>(),
                hops: Array<String>(),
                flavorProfiles: Array<String>(),
                brewer: searchResult["brewer"] as String,
                abv: searchResult["abv"] as Double,
                ibu: searchResult["ibu"] as Double,
                srm: searchResult["srm"] as Double)
            
            return beer;
            },
            completionHandler: {(mappedResults: Array<SearchResult>) -> () in
                var beers = Array<Beer>()
                for m in mappedResults {
                    beers.append(m as Beer)
                }
                completionHandler(results: beers)
            }
        )
    }
    
}