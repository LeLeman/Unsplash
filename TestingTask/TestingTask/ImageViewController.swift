//
//  ImageViewController.swift
//  TestingTask
//
//  Created by Evgeniy Lemish on 29.08.2022.
//

import Foundation
import UIKit


class ImageViewController: UIViewController, UIScrollViewDelegate {

    var selectedImage: String = .init()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
        imageView.contentMode = .scaleAspectFit
    }
        
}
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
        view.backgroundColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        imageLoad()
    }
    
// MARK: - Action
   
    @IBAction func closeVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
//MARK: - UIScrollView
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
//MARK: - APIImageLoading
    
    public func imageLoad() {
        guard let url = URL(string: selectedImage) else {return}
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {return}
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.imageView.image = image
            }
        }.resume()
    }
}
