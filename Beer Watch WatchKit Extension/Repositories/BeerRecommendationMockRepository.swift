//
//  BeerRecommendationMockRepository.swift
//  Beer Watch
//
//  Created by Toussaint, Joseph on 4/15/15.
//  Copyright (c) 2015 Vanderlan, Jeremiah. All rights reserved.
//

import Foundation

class BeerRecommendationMockRepository : BeerRecommendationRepository {
    
    /**
    * Finds a specific beer
    **/
    func FindBeer(beerId: String, completionHandler: (results: Beer) -> ()) -> () {
        var beer = Beer()
        
        beer.id = "1"
        beer.name = "EPA"
        beer.brewer = Brewer()
        beer.brewer.name = "Summit"
        beer.style = "Pale Ale"
        beer.imageLocation = "http://www.summitbrewing.com/system/brews_images/0000/4513/Bottle_Extra-Pale-Ale.png"
        
        completionHandler(results: beer)
    }
    
    
    
    /**
    * Finds a list of all beers
    **/
    func FindAllBeers(completionHandler: (results: Array<Beer>) -> ()) -> () {
        var beer = Beer()
        
        beer.id = "1"
        beer.name = "EPA"
        beer.brewer = Brewer()
        beer.brewer.name = "Summit"
        beer.style = "Pale Ale"
        beer.imageLocation = "http://www.summitbrewing.com/system/brews_images/0000/4513/Bottle_Extra-Pale-Ale.png"
        
        var beers = Array<Beer>()
        beers.append(beer)
        
        completionHandler(results: beers)
    }
    
    
    
    /**
    * Finds all beers that are like the provided beer
    **/
    func FindBeersLike(beerId: String, completionHandler: (results: Array<Beer>) -> ()) -> () {
        var beer = Beer()
        
        beer.id = "1"
        beer.name = "EPA"
        beer.brewer = Brewer()
        beer.brewer.name = "Summit"
        beer.style = "Pale Ale"
        beer.imageLocation = "http://www.summitbrewing.com/system/brews_images/0000/4513/Bottle_Extra-Pale-Ale.png"
        
        var beers = Array<Beer>()
        beers.append(beer)
        
        completionHandler(results: beers)
    }
    
}