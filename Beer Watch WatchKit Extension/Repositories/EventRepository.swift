//
//  EventRepository.swift
//  Beer Watch
//
//  Created by Toussaint, Joseph on 4/16/15.
//  Copyright (c) 2015 Vanderlan, Jeremiah. All rights reserved.
//

import Foundation

protocol EventRepository {
    
    /**
     * Finds the next event at the provided location
     **/
    func findNextEventAtLocation(locationId: String, completionHandler: (result: Event) -> ()) -> ()
    
}