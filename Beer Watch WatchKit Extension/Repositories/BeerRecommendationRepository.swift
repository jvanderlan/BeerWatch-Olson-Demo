//
//  BeerRecommendationRepository.swift
//  Beer Watch
//
//  Created by Toussaint, Joseph on 4/15/15.
//  Copyright (c) 2015 Vanderlan, Jeremiah. All rights reserved.
//

import Foundation

/**
 * FA repository for finding recommended beers
 **/
protocol BeerRecommendationRepository {
    
    
    
    /**
     * Finds a specific beer
     **/
    func FindBeer(beerId: String, completionHandler: (results: Beer) -> ()) -> ()
    
    
    
    /**
     * Finds a list of all beers
     **/
    func FindAllBeers(completionHandler: (results: Array<Beer>) -> ()) -> ()
 
    
    
    /**
     * Finds all beers that are like the provided beer
     **/
    func FindBeersLike(beerId: String, completionHandler: (results: Array<Beer>) -> ()) -> ()
}