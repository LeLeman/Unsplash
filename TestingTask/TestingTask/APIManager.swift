//
//  APIManager.swift
//  TestingTask
//
//  Created by Evgeniy Lemish on 29.08.2022.
//

import Foundation



class APIManager {
    
    var totalPages: Int = .init()
    
    func fenchPhotos(query: String, page: String, completion: @escaping ([Result]) -> Void) {
        let urlString = "https://api.unsplash.com/search/photos?page=\(page)&per_page=50&query=\(query)&client_id=8MDWl2zxg-XTw2tB9jQyWNDUxfWiY60sYqjVIsMHj88"

        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) {data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(jsonResult.results)
                self.totalPages = jsonResult.total_pages
                print (jsonResult.results.count)
            } catch {
                print (error)
            }
        }.resume()
    }

}
