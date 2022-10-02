//
//  CacheManager.swift
//  TestingTask
//
//  Created by Evgeniy Lemish on 20.09.2022.
//

import Foundation
import UIKit
import Alamofire


class DownloadManager {
    
    static let downladManager = DownloadManager()
     
    private let cache = NSCache<NSString, UIImage>()
    
    
    // MARK: Download Image
    
    func downloadImage (_ urlString: String, complition: @escaping (UIImage) -> Void) {
        if let savedImage = cache.object(forKey: NSString.init(string: urlString)) {
            complition(savedImage)
        
        } else {
            
            guard let url = URL(string: urlString) else {
                return
            }
            AF.request(url).responseData { response in
                guard let data = response.data else { return }
                DispatchQueue.main.async {
                    guard let image = UIImage(data: data) else { return }
                    let keyURL = NSString.init(string: urlString)
                    self.cache.setObject(image, forKey: keyURL)
                    complition(image)
                }
            }.resume()

        }
    }
   
    private init() {
      
    }
}
