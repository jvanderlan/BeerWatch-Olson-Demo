//
//  Beer.swift
//  Hello Watch
//
//  Created by Toussaint, Joseph on 4/9/15.
//  Copyright (c) 2015 Toussaint, Joseph. All rights reserved.
//

import Foundation

class Beer : SearchResult, ApiResult, AnyObject {
    var searchScore: Double = 0.0
    var id: String = ""
    var name: String = ""
    var imageLocation: String = ""
    var url: String = ""
    var event: String = ""
    var description: String = ""
    var style: String = ""
    var beerFamilies: Array<String> = []
    var hops: Array<String> = []
    var flavorProfiles: Array<String> = []
    var brewer: Brewer
    var abv: Double = 0.0
    var ibu: Double = 0.0
    var srm: Double = 0.0
    var rating: Int = 0
    
    init() {
        brewer = Brewer()
    }
}