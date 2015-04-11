//
//  FindBeerController.swift
//  Beer Watch
//
//  Created by Toussaint, Joseph on 4/11/15.
//  Copyright (c) 2015 Vanderlan, Jeremiah. All rights reserved.
//

import WatchKit
import Foundation

class FindBeerController : WKInterfaceController {
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        
        if segueIdentifier == GlobalContants.RecommendedBeerActionType.trending {
            return GlobalContants.RecommendedBeerActionType.trending
        }
        else if segueIdentifier == GlobalContants.RecommendedBeerActionType.norm {
            return GlobalContants.RecommendedBeerActionType.norm
        }
        else if segueIdentifier == GlobalContants.RecommendedBeerActionType.adventerous {
            return GlobalContants.RecommendedBeerActionType.adventerous
        }
        
        return GlobalContants.RecommendedBeerActionType.rate
    }
}