//
//  Constants.swift
//  Beer Watch
//
//  Created by Toussaint, Joseph on 4/11/15.
//  Copyright (c) 2015 Vanderlan, Jeremiah. All rights reserved.
//

import Foundation
import WatchKit

struct GlobalContants {
    
    struct Fonts {
        static let bodyCopy = UIFont(name: "Roboto", size: 12.0)!
        static let bodyCopyFontAttributes = [NSFontAttributeName : bodyCopy]
        
        static let bodyCopyBold = UIFont(name: "Roboto-Bold", size: 12.0)!
        static let bodyCopyBoldFontAttributes = [NSFontAttributeName : bodyCopyBold]
        
        static let titleCopy = UIFont(name: "Roboto", size: 12.0)!
        static let titleCopyFontAttributes = [NSFontAttributeName : titleCopy]
    }
    
    struct Colors {
        static let tealColor = UIColor(red: 0.102, green: 0.824, blue: 0.694, alpha: 1) /*#1ad2b1*/
    }
    
}