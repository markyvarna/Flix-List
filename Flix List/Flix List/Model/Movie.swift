//
//  Movie.swift
//  Flix List
//
//  Created by Markus Varner on 9/7/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import Foundation

struct Results: Decodable {
    let results: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case results
    }
    
    
}
struct Movie: Decodable {
    
    let title: String
    let overview: String
    let rating: Double
    let imagePath: String?
    
    private enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case overview
        case rating = "vote_average"
        case imagePath = "poster_path"
    }
}

