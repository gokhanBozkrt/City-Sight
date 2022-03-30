//
//  BusinessSearch.swift
//  City Sight
//
//  Created by Gokhan Bozkurt on 30.03.2022.
//

import Foundation

struct BusinessSearch: Decodable {
    var businesses = [Business]()
    var total = 0
    var region = Region()
}

struct Region: Decodable {
    // Coordinate() business modeldekinden aldık zaten vardı
    var center = Coordinate()
}
