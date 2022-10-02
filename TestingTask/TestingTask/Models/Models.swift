//
//  Models.swift
//  TestingTask
//
//  Created by Evgeniy Lemish on 07.09.2022.
//

import Foundation


struct APIResponse: Codable {
    let total: Int
    let totalPages: Int
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

struct Result: Codable {
    let id: String
    let urls: URLS
}
struct APIRequest: Codable{
    let page: Int
    var perPage: Int = 50
    let query: String
}

struct URLS: Codable{
    let regular: String
}

