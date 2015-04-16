//
//  BeerRecommendationRepository.swift
//  Hello Watch
//
//  Created by Toussaint, Joseph on 4/9/15.
//  Copyright (c) 2015 Toussaint, Joseph. All rights reserved.
//

import Foundation

class BeerRecommendationApiRepository : BeerWatchRepository, BeerRecommendationRepository {
    

    
    /**
     * Finds a specific beer
     **/
    func FindBeer(beerId: String, completionHandler: (results: Beer) -> ()) {
        let query = "/api/beers/" + beerId
        
        ApiRESTfulGet(query, mappingCallback: { (entityResult) -> ApiResult in
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
        }) { (results) -> () in
            var beer = results[0] as! Beer
            completionHandler(results: beer)
        }
    }

    
    
    /**
     * Finds a list of all beers
     **/
    func FindAllBeers(completionHandler: (results: Array<Beer>) -> ()) {
        
        let query = "/api/beers"
        
        ApiRESTfulGet(query, mappingCallback: { (entityResult) -> ApiResult in
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
        }) { (results) -> () in
            var beers = Array<Beer>()
            for m in results {
                beers.append(m as! Beer)
            }
            completionHandler(results: beers)
        }
    }
    
    
    
    /**
     * Finds all beers that are like the provided beer
     **/
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
}