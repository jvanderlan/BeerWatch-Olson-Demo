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
    @IBOutlet weak var titleGroup: WKInterfaceGroup!
    @IBOutlet weak var titleLabel: WKInterfaceLabel!
    @IBOutlet weak var titleImage: WKInterfaceImage!
    
    var recomendedBeers = Array<Beer>()
    
    @IBOutlet weak var beerTable: WKInterfaceTable!
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        var contextString = context as! String
        
        if (contextString == GlobalContants.RecommendedBeerActionType.trending) {
            var titleAttributes = NSAttributedString(string: "Trending", attributes: GlobalContants.Fonts.bodyCopyFontAttributes)
            self.titleLabel.setAttributedText(titleAttributes)
            titleImage.setImageNamed("trending")
            titleImage.setHidden(false)
            
            loadAllBeers(contextString)
        }
        else if ( contextString == GlobalContants.RecommendedBeerActionType.norm ) {
            var titleAttributes = NSAttributedString(string: "The norm", attributes: GlobalContants.Fonts.bodyCopyFontAttributes)
            self.titleLabel.setAttributedText(titleAttributes)
            titleImage.setImageNamed("the_norm")
            titleImage.setHidden(false)
            
            loadAllBeers(contextString)
        }
        else if ( contextString == GlobalContants.RecommendedBeerActionType.adventerous ) {
            var titleAttributes = NSAttributedString(string: "Adventerous", attributes: GlobalContants.Fonts.bodyCopyFontAttributes)
            self.titleLabel.setAttributedText(titleAttributes)
            titleImage.setImageNamed("adventerous")
            titleImage.setHidden(false)
            
            loadAllBeers(contextString)
        }
        else {
            var titleAttributes = NSAttributedString(string: "Rate your beers", attributes: GlobalContants.Fonts.bodyCopyFontAttributes)
            self.titleLabel.setAttributedText(titleAttributes)
            titleImage.setHidden(true)
            
            loadPours(contextString)
        }
        
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
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        
        let beer = self.recomendedBeers[rowIndex]
        
        return beer
    }
    
    func loadAllBeers(contextString: String) {
        let repo = BeerRecommendationRepository()
        
        repo.FindAllBeers { (results) -> () in
            self.beerTable.setNumberOfRows(results.count, withRowType: "beerRow")
            
            for var i = 0; i<self.beerTable.numberOfRows; i++ {
                var row = self.beerTable.rowControllerAtIndex(i) as! RecommendedBeerRowController
                var beer = results[i] as Beer
                
                var showRating = contextString == GlobalContants.RecommendedBeerActionType.rate
                row.setBeer(beer, showRating: showRating)
            }
            
            self.recomendedBeers = results
        }
    }
    
    
    func loadPours(contextString: String) {
        let repo = BeerRecommendationRepository()
        
        repo.FindPours("3", completionHandler: { (results) -> () in
            self.beerTable.setNumberOfRows(results.count, withRowType: "beerRow")
            
            for var i = 0; i<self.beerTable.numberOfRows; i++ {
                var row = self.beerTable.rowControllerAtIndex(i) as! RecommendedBeerRowController

                var pour = results[i] as Pour
                
                var showRating = contextString == GlobalContants.RecommendedBeerActionType.rate
                row.setPour(pour, showRating: showRating)
            }
            
            //self.recomendedBeers = results
        })
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