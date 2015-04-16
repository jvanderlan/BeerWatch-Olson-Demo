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

    @IBOutlet weak var arcLabelGroup: WKInterfaceGroup!
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
        var repo = RepositoryFactory.activityRepository()
        
        repo.FindStats("3", completionHandler: { (result) -> () in
            
            var outerRange:Int = 0
            var middleRange:Int = 0
            var innerRange:Int = 0
            
            var labelImage = self.createLabelImage()
            
            if ( result.families.count >= 1 ) {
                var outerCount = (Double(result.families[0].count) / Double(result.pourCount))
                outerRange = Int(round(outerCount * 100))
                
                labelImage = self.drawImageText(result.families[0].family, inImage: labelImage, atPoint: CGPoint(x: -125, y: -3))
            }
            
            if ( result.families.count >= 2 ) {
                var middleCount = (Double(result.families[1].count) / Double(result.pourCount))
                middleRange = Int(round(middleCount * 100))
            
                labelImage = self.drawImageText(result.families[1].family, inImage: labelImage, atPoint: CGPoint(x: -125, y: 10))
            }
            
            if ( result.families.count >= 3 ) {
                var innerCount = (Double(result.families[2].count) / Double(result.pourCount))
                innerRange = Int(round(innerCount * 100))
                
                labelImage = self.drawImageText(result.families[2].family, inImage: labelImage, atPoint: CGPoint(x: -125, y: 22))
            }
            
            self.arcLabelGroup.setBackgroundImage(labelImage)
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
    
    override func handleActionWithIdentifier(identifier: String?, forLocalNotification localNotification: UILocalNotification) {
        if ( identifier == "dashboard" ) {
            
        }
    }
    
    override func handleActionWithIdentifier(identifier: String?, forRemoteNotification remoteNotification: [NSObject : AnyObject]) {
        if ( identifier == GlobalContants.NotificationActions.recommendBeers ) {
            pushControllerWithName("RecommendedBeers", context: GlobalContants.RecommendedBeerActionType.trending)
        }
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        
        return GlobalContants.RecommendedBeerActionType.rate
    }
    
    func createLabelImage() -> UIImage {
        
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(225, 124), false, 0.0);
        
        var blank = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        return blank
    }
    

    func drawImageText(drawText:String, inImage: UIImage, atPoint:CGPoint) -> UIImage {
        // Setup the font specific variables
        var textColor: UIColor = UIColor.whiteColor()
        var textFont: UIFont = GlobalContants.Fonts.bodyCopy
        
        //Setup the image context using the passed image.
        UIGraphicsBeginImageContext(inImage.size)
        
        let paragraphStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.alignment = NSTextAlignment.Right
        
        //Setups up the font attributes that will be later used to dictate how the text should be drawn
        let textFontAttributes = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
            NSParagraphStyleAttributeName: paragraphStyle
        ]
        
        //Put the image into a rectangle as large as the original image.
        inImage.drawInRect(CGRectMake(0, 0, inImage.size.width, inImage.size.height))
        
        // Creating a point within the space that is as bit as the image.
        var rect: CGRect = CGRectMake(atPoint.x, atPoint.y, inImage.size.width, inImage.size.height)
        
        //Now Draw the text into an image.
        drawText.drawInRect(rect, withAttributes: textFontAttributes)
        
        // Create a new image out of the images we have created
        var newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the context now that we have the image we need
        UIGraphicsEndImageContext()
        
        //And pass it back up to the caller.
        return newImage
    }

}