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
    }

    override func willActivate() {
        var repo = BeerRecommendationRepository()
        
        repo.FindStats("3", completionHandler: { (result) -> () in
            
            var outerRange:Int = 0
            var middleRange:Int = 0
            var innerRange:Int = 0
            
            if ( result.families.count >= 1 ) {
                var outerCount = (Double(result.families[0].count) / Double(result.pourCount))
                outerRange = Int(round(outerCount * 100))
            }
            
            if ( result.families.count >= 2 ) {
                var middleCount = (Double(result.families[1].count) / Double(result.pourCount))
                middleRange = Int(round(middleCount * 100))
            }
            
            if ( result.families.count >= 3 ) {
                var innerCount = (Double(result.families[2].count) / Double(result.pourCount))
                innerRange = Int(round(innerCount * 100))
            }
            
            self.outerGroup.startAnimatingWithImagesInRange(NSMakeRange(0,outerRange), duration:self.duration, repeatCount: 1)
            self.middleGroup.startAnimatingWithImagesInRange(NSMakeRange(0,middleRange), duration:self.duration, repeatCount: 1)
            self.innerGroup.startAnimatingWithImagesInRange(NSMakeRange(0,innerRange), duration:self.duration, repeatCount: 1)
        })
        
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