//
//  RecommendedBeersController.swift
//  Hello Watch
//
//  Created by Toussaint, Joseph on 4/10/15.
//  Copyright (c) 2015 Toussaint, Joseph. All rights reserved.
//

import WatchKit
import Foundation


class RecommendedBeersController: WKInterfaceController {
    
    var recomendedBeers = Array<Beer>()
    
    @IBOutlet weak var beerTable: WKInterfaceTable!
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let repo = BeerRecommendationRepository()
        
        repo.FindBeersLike("beer_summit_saga", completionHandler: {(results: Array<Beer>) -> () in
            self.beerTable.setNumberOfRows(results.count, withRowType: "beerRow")
            
            for var i = 0; i<self.beerTable.numberOfRows; i++ {
                var row = self.beerTable.rowControllerAtIndex(i) as! RecommendedBeerRowController
                var beer = results[i] as Beer
                
                row.rowDescription.setText(beer.name)
                
                self.loadImage(beer.imageLocation, forImageView: row.rowIcon)
            }
            
            self.recomendedBeers = results
        })
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    override func handleActionWithIdentifier(identifier: String?, forLocalNotification localNotification: UILocalNotification){
        
    }
    
    override func handleActionWithIdentifier(identifier: String?, forRemoteNotification remoteNotification:[NSObject : AnyObject]) {
        
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