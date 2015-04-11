//
//  InterfaceController.swift
//  Beer Watch WatchKit Extension
//
//  Created by Toussaint, Joseph on 4/10/15.
//  Copyright (c) 2015 Vanderlan, Jeremiah. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var outerGroup: WKInterfaceGroup!
    @IBOutlet weak var middleGroup: WKInterfaceGroup!
    @IBOutlet weak var innerGroup: WKInterfaceGroup!
    
    @IBOutlet weak var titleLabel: WKInterfaceLabel!
    
    let duration = 1.0
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
                
        outerGroup.setBackgroundImageNamed("outerArc")
        middleGroup.setBackgroundImageNamed("middleArc")
        innerGroup.setBackgroundImageNamed("innerArc")
        
        self.outerGroup.startAnimatingWithImagesInRange(NSMakeRange(0,75), duration:self.duration, repeatCount: 1)
        self.middleGroup.startAnimatingWithImagesInRange(NSMakeRange(0,50), duration:self.duration, repeatCount: 1)
        self.innerGroup.startAnimatingWithImagesInRange(NSMakeRange(0,25), duration:self.duration, repeatCount: 1)
        
        /*
        var repo = BeerRecommendationRepository()
        
        repo.FindStats("3", completionHandler: { (result) -> () in
            
            var outerCount:Double = 0
            var middleCount:Double = 0
            var innerCount:Double = 0
            
            if ( result.families.count > 0 ) {
                outerCount = (Double(result.families[0].count) / Double(result.pourCount))
                
            }
            

        })*/
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
        
        return GlobalContants.RecommendedBeerActionType.rate
    }
    

    

}