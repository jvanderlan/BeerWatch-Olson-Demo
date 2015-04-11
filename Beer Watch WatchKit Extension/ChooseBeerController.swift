//
//  ChooseBeerController.swift
//  Beer Watch
//
//  Created by Toussaint, Joseph on 4/10/15.
//  Copyright (c) 2015 Vanderlan, Jeremiah. All rights reserved.
//

import WatchKit
import Foundation

class ChooseBeerController : WKInterfaceController {
    
    @IBOutlet weak var titleLabel: WKInterfaceLabel!
    @IBOutlet weak var pourAnotherLabel: WKInterfaceLabel!
    @IBOutlet weak var rateBeersLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let beer = context as! Beer
        
        var titleAttributes = NSAttributedString(string: "ENJOY!", attributes: GlobalContants.Fonts.titleCopyFontAttributes)
        titleLabel.setAttributedText(titleAttributes)
        titleLabel.setTextColor(GlobalContants.Colors.tealColor)
        
        var pourAnotherAttributes = NSAttributedString(string: "Pour me another", attributes: GlobalContants.Fonts.titleCopyFontAttributes)
        pourAnotherLabel.setAttributedText(pourAnotherAttributes)
        
        var rateAttributes = NSAttributedString(string: "Rank your beers", attributes: GlobalContants.Fonts.titleCopyFontAttributes)
        rateBeersLabel.setAttributedText(rateAttributes)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func loadImage(url:String, forImageView: WKInterfaceImage) {
        // load image
        let image_url:String = url
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let url:NSURL = NSURL(string:image_url)!
            var data:NSData = NSData(contentsOfURL: url)!
            var placeholder = UIImage(data: data)!
            
            // update ui
            dispatch_async(dispatch_get_main_queue()) {
                forImageView.setImage(placeholder)
            }
        }
    }
}