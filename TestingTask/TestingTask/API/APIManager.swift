//
//  APIManager.swift
//  TestingTask
//
//  Created by Evgeniy Lemish on 29.08.2022.
//

import Foundation
import Alamofire



class APIManager {
static let apiManager = APIManager()

    func fenchPhotos(query: String, page: String, completion: @escaping ([Result], Int) -> Void) {
        let urlString = "https://api.unsplash.com/search/photos"
        
        let params = ["page" : page, "query" : query, "client_id" : "8MDWl2zxg-XTw2tB9jQyWNDUxfWiY60sYqjVIsMHj88"]
        
        guard let url = URL(string: urlString) else { return }
        AF.request(url, parameters: params, encoding: URLEncoding.default).responseData { response in
            guard let data = response.data else { return }
            do {
                let jsonResult: APIResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(jsonResult.results, jsonResult.totalPages)
                print (jsonResult.results.count)
            } catch {
                print (error)
            }
        }
    }
}
