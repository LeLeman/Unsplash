//
//  ImageCollectionViewCell.swift
//  TestingTask
//
//  Created by Evgeniy Lemish on 29.08.2022.
//

import Foundation
import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder){
        fatalError()
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(with urlString: String){
        DownloadManager.downladManager.downloadImage(urlString, complition: { picture in
        self.imageView.image = picture
        })
    }
   
}



