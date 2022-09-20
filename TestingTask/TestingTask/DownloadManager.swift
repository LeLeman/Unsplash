//
//  CacheManager.swift
//  TestingTask
//
//  Created by Evgeniy Lemish on 20.09.2022.
//

import Foundation
import UIKit


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
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    guard let image = UIImage(data: data) else { return }
                    let keyURL = NSString.init(string: urlString)
                    self?.cache.setObject(image, forKey: keyURL)
                    complition(image)
                }
            }.resume()

        }
    }
   
    private init() {
      
    }
}
