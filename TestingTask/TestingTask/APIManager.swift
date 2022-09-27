//
//  APIManager.swift
//  TestingTask
//
//  Created by Evgeniy Lemish on 29.08.2022.
//

import Foundation



class APIManager {
static let apiManager = APIManager()

    func fenchPhotos(query: String, page: String, completion: @escaping ([Result], Int) -> Void) {
        let query1 = query.replacingOccurrences(of: " ", with: "$")
        let urlString = "https://api.unsplash.com/search/photos?page=\(page)&per_page=50&query=\(query1)&client_id=8MDWl2zxg-XTw2tB9jQyWNDUxfWiY60sYqjVIsMHj88"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) {data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let jsonResult: APIResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(jsonResult.results, jsonResult.totalPages)
                print (jsonResult.results.count)
            } catch {
                print (error)
            }
        }.resume()
    }

}
