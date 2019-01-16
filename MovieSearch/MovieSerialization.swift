//
//  MovieInfo.swift
//  
//
//  Created by Simon Mc Neil on 2018-04-24.
//

import Foundation

struct Movies: Decodable {
    //let name: String
    //let description: String
    let results: [MovieInfo]
}

struct MovieInfo: Decodable {
    let title: String?
    let first_air_date: String?
    let poster_path: String?
    let overview: String?
    let release_date: String?
    let original_name: String?
}

