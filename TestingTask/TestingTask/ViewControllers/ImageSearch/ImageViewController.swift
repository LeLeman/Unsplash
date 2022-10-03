//
//  ImageViewController.swift
//  TestingTask
//
//  Created by Evgeniy Lemish on 29.08.2022.
//

import Foundation
import UIKit
import Alamofire


class ImageViewController: UIViewController, UIScrollViewDelegate {

    var selectedImage: String = .init()
   
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
        imageView.contentMode = .scaleAspectFit
        }
    }
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
        view.backgroundColor = .black
    }
    
    // MARK: - viewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageLoad()
    }
    
 
// MARK: - Action Close ImageViewController
    
    
    @IBAction func closeVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

// MARK: - Action Save Image in PhotoLibary
   
    @IBAction func saveImageToPhotoLibary(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(imageView.image!, nil, nil, nil)
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUp") as! PopUpViewController
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    
    
//MARK: - UIScrollView
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
//MARK: - APIImageLoading
    
    public func imageLoad() {
        guard let url = URL(string: selectedImage) else {return}
        AF.request(url).responseData { response in
            guard let data = response.data else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imageView.image = image
            }
        }.resume()
    }
}
