//
//  GlanceInterfaceController.swift
//  Beer Watch
//
//  Created by Toussaint, Joseph on 4/16/15.
//  Copyright (c) 2015 Vanderlan, Jeremiah. All rights reserved.
//

import Foundation
import WatchKit

class GlanceInterfaceController : WKInterfaceController {
    
    @IBOutlet weak var countdownTimer: WKInterfaceTimer!
    override init() {
        // Initialize variables here.
        super.init()
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        var repo = RepositoryFactory.eventRepository()
        
        repo.findNextEventAtLocation("1", completionHandler: { (result) -> () in
            self.countdownTimer.setDate(result.startDate)
            self.countdownTimer.start()
            
            // This method is called when watch view controller is about to be visible to user
            super.willActivate()
        })
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}