//
//  Beer.swift
//  Hello Watch
//
//  Created by Toussaint, Joseph on 4/9/15.
//  Copyright (c) 2015 Toussaint, Joseph. All rights reserved.
//

import Foundation

struct Beer : SearchResult {
    var searchScore: Double
    var id: String
    var name: String
    var imageLocation: String
    var url: String
    var event: String
    var description: String
    var beerFamilies: Array<String>
    var hops: Array<String>
    var flavorProfiles: Array<String>
    var brewer: String
    var abv: Double
    var ibu: Double
    var srm: Double
}