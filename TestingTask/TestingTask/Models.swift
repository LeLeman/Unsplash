//
//  Models.swift
//  TestingTask
//
//  Created by Evgeniy Lemish on 07.09.2022.
//

import Foundation

struct APIResponse: Codable {
    let total: Int
    let total_pages: Int
    let results: [Result]
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
