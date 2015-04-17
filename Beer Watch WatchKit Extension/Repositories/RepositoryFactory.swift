//
//  RepositoryFactor.swift
//  Beer Watch
//
//  Created by Toussaint, Joseph on 4/15/15.
//  Copyright (c) 2015 Vanderlan, Jeremiah. All rights reserved.
//

import Foundation

/**
 * A Poor Man's DI Framework ...
 **/
class RepositoryFactory {
    
    
    
    /**
     * Returns the Activity Repostiory
     **/
    static func activityRepository() -> ActivityRepository {
        //return ActivityApiRepository()
        return ActivityMockRepository()
    }
    
    
    /**
     * Returns the Event Repository
     **/
    static func eventRepository() -> EventRepository {
        //return EventApiRepository()
        return EventMockRepository()
    }
    
    
    /**
     * Returns the beer recommendation repository
     **/
    static func beerRecommendationRepository() -> BeerRecommendationRepository {
        //return BeerRecommendationApiRepository()
        return BeerRecommendationMockRepository()
    }
    
}