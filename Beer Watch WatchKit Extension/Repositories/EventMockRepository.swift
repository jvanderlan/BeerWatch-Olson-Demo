//
//  EventMockRepository.swift
//  Beer Watch
//
//  Created by Toussaint, Joseph on 4/16/15.
//  Copyright (c) 2015 Vanderlan, Jeremiah. All rights reserved.
//

import Foundation

class EventMockRepository : EventRepository {
    
    
    /**
     * Finds the next event at the provided location
     **/
    func findNextEventAtLocation(locationId: String, completionHandler: (result: Event) -> ()) -> () {
        var event = Event()
        
        let twentyFourHoursInSeconds: NSTimeInterval = 24 * 60 * 60
        
        event.eventname = "7th floor bar"
        event.startDate = NSDate().dateByAddingTimeInterval(twentyFourHoursInSeconds)
        
        completionHandler(result: event)
    }
    
}