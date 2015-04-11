//
//  RecommendedBeerRowController.swift
//  Hello Watch
//
//  Created by Toussaint, Joseph on 4/10/15.
//  Copyright (c) 2015 Toussaint, Joseph. All rights reserved.
//

import WatchKit
import Foundation

class RecommendedBeerRowController : NSObject {
        
    @IBOutlet weak var breweryName: WKInterfaceLabel!
    @IBOutlet weak var beerName: WKInterfaceLabel!
    @IBOutlet weak var beerIcon: WKInterfaceImage!
    @IBOutlet weak var beerStyle: WKInterfaceLabel!
    
    @IBOutlet weak var starGroup: WKInterfaceGroup!
    @IBOutlet weak var starOneButton: WKInterfaceButton!
    @IBOutlet weak var starTwoButton: WKInterfaceButton!
    @IBOutlet weak var starThreeButton: WKInterfaceButton!
    @IBOutlet weak var starFourButton: WKInterfaceButton!
    @IBOutlet weak var starFiveButton: WKInterfaceButton!
    
    var beer: Beer!
    
    override init() {
        
    }
    
    func setBeer(beer: Beer, showRating: Bool) {
        self.beer = beer
        
        self.beerName.setText(beer.name)
        self.breweryName.setText(beer.brewer)
        
        var beerNameAttributes = NSAttributedString(string: beer.name, attributes: GlobalContants.Fonts.bodyCopyFontAttributes)
        self.beerName.setAttributedText(beerNameAttributes)
        
        var breweryNameAttributes = NSAttributedString(string: beer.brewer, attributes: GlobalContants.Fonts.bodyCopyFontAttributes)
        self.breweryName.setAttributedText(breweryNameAttributes)
        
        var beerStyleAttributes = NSAttributedString(string: beer.style, attributes: GlobalContants.Fonts.bodyCopyBoldFontAttributes)
        self.beerStyle.setAttributedText(beerStyleAttributes)
        
        self.starGroup.setHidden(!showRating)
        
        self.loadImage(beer.imageLocation, forImageView: self.beerIcon)
    }

    @IBAction func starOneTapped() {
        var togglingOn = beer.rating < 1
        
        toggleStar(togglingOn, starButton: starOneButton)
        toggleStar(false, starButton: starTwoButton)
        toggleStar(false, starButton: starThreeButton)
        toggleStar(false, starButton: starFourButton)
        toggleStar(false, starButton: starFiveButton)
        
        beer.rating = togglingOn ? 1 : 0
    }
    
    @IBAction func starTwoTapped() {
        var togglingOn = beer.rating < 2
        
        toggleStar(true, starButton: starOneButton)
        toggleStar(togglingOn, starButton: starTwoButton)
        toggleStar(false, starButton: starThreeButton)
        toggleStar(false, starButton: starFourButton)
        toggleStar(false, starButton: starFiveButton)
        
        beer.rating = togglingOn ? 2 : 1
    }
    
    @IBAction func starThreeTapped() {
        var togglingOn = beer.rating < 3
        
        toggleStar(true, starButton: starOneButton)
        toggleStar(true, starButton: starTwoButton)
        toggleStar(togglingOn, starButton: starThreeButton)
        toggleStar(false, starButton: starFourButton)
        toggleStar(false, starButton: starFiveButton)
        
        beer.rating = togglingOn ? 3 : 2
    }
    
    @IBAction func starFourTapped() {
        var togglingOn = beer.rating < 4
        
        toggleStar(true, starButton: starOneButton)
        toggleStar(true, starButton: starTwoButton)
        toggleStar(true, starButton: starThreeButton)
        toggleStar(togglingOn, starButton: starFourButton)
        toggleStar(false, starButton: starFiveButton)
        
        beer.rating = togglingOn ? 4 : 3
    }
    
    @IBAction func starFiveTapped() {
        var togglingOn = beer.rating < 5
        
        toggleStar(true, starButton: starOneButton)
        toggleStar(true, starButton: starTwoButton)
        toggleStar(true, starButton: starThreeButton)
        toggleStar(true, starButton: starFourButton)
        toggleStar(togglingOn, starButton: starFiveButton)
        
        beer.rating = togglingOn ? 5 : 4
    }
    
    func toggleStar(enabled: Bool, starButton: WKInterfaceButton) {
        if ( enabled ) {
            starButton.setBackgroundImageNamed("full_star")
        }
        else {
            starButton.setBackgroundImageNamed("blank_star")
        }
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