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
    let duration = 1.0
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        outerGroup.setBackgroundImageNamed("outerArc")
        middleGroup.setBackgroundImageNamed("middleArc")
        innerGroup.setBackgroundImageNamed("innerArc")
        
        outerGroup.startAnimatingWithImagesInRange(NSMakeRange(0,75), duration:duration, repeatCount: 1)
        middleGroup.startAnimatingWithImagesInRange(NSMakeRange(0,50), duration: duration, repeatCount: 1)
        innerGroup.startAnimatingWithImagesInRange(NSMakeRange(0,25), duration: duration, repeatCount: 1)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}