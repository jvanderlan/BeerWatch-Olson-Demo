//
//  BeerWatchRepository.swift
//  Beer Watch
//
//  Created by Toussaint, Joseph on 4/15/15.
//  Copyright (c) 2015 Vanderlan, Jeremiah. All rights reserved.
//

import Foundation

class BeerWatchRepository {
    
    /**
     * A method to call the search api directly
     **/
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
    

    /**
     * Makes a REST call to the service
     **/
    func ApiRESTCall(pathAndQuery:String,
                     httpMethod: String,
                     jsonData: NSData?,
                     completionHandler: (response:NSURLResponse!, data: NSData!, error: NSError!) -> ()) {
                        
        var url = "http://localhost:3000" + pathAndQuery
        
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = httpMethod
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        if jsonData != nil  {
            request.HTTPBody = jsonData
        }
        
        NSURLConnection.sendAsynchronousRequest(
            request,
            queue: NSOperationQueue(),
            completionHandler:completionHandler)
    }
    
    
    
    /**
     * Makes a HTTP Get call to the REST Service
     **/
    func ApiRESTfulGet(pathAndQuery: String,
                       mappingCallback: (entityResult: NSDictionary) -> ApiResult,
                       completionHandler: (results: Array<ApiResult>) -> ())  {
                        
        ApiRESTCall(pathAndQuery, httpMethod: "GET", jsonData: nil) { (response, data, error) -> () in
            
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
            
        }
    }
    
    
    
    /**
     * Makes a HTTP Put call to the REST service
     **/
    func ApiRESTfulPut(pathAndQuery: String, jsonData: NSData?)  {
        ApiRESTCall(pathAndQuery, httpMethod: "PUT", jsonData: jsonData) { (response, data, error) -> () in
            //no neeed to do anything right now ...
        }
    }
    
}