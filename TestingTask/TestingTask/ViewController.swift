//
//  ViewController.swift
//  TestingTask
//
//  Created by Evgeniy Lemish on 29.08.2022.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var result: [Result] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewSetup(imageCollectionView.self)
    }
 
// MARK: - UISearchBar
    
    var text1 : String = .init()
    var page1 : Int = 1
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            result = []
            imageCollectionView.reloadData()
            text1 = text
            fetchPhoto(quary: text1, page: String(page1))
        }
    }
    
// MARK: - API
    
    var API: APIManager = .init()
    
    func fetchPhoto(quary: String, page: String) {
        let api = APIManager()
        api.fenchPhotos(query: quary, page: page) { [weak self] result  in
        DispatchQueue.main.async {
            self?.result += result
            self?.imageCollectionView.reloadData()
            }
        }
    }
    
    // MARK: - scrollViewDidScroll
       
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentSizeHeight = imageCollectionView.contentSize.height
        let scrollViewFrameHeight = scrollView.frame.height
        if position > (contentSizeHeight-scrollViewFrameHeight) {
            page1 = page1 + 1
            fetchPhoto(quary: text1, page: String(page1))
        }
    }
    
// MARK: - UICollectionViewDataSource
    
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return result.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageURLString = result[indexPath.row].urls.regular
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageViewController.self), for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell()}
        cell.configure(with: imageURLString)
        return cell
    }

// MARK: - UICollectionViewDelegate
      
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let imageViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ImageViewController.self)) as? ImageViewController else {return}
        
        imageViewController.selectedImage = result[indexPath.row].urls.regular
        imageViewController.modalTransitionStyle = .coverVertical
        imageViewController.modalPresentationStyle = .overCurrentContext

        present(imageViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.size.width/2, height: view.frame.size.width/2)
    }
    
// MARK: - CollectionViewSetup
    
    private func collectionViewSetup (_ collectionView: UICollectionView){
        collectionViewLayout(imageCollectionView.self)
        imageCollectionViewRegister(imageCollectionView.self)
        imageCollectionBackground(imageCollectionView.self)
     }
    
// MARK: - CollectionViewLayoutSetup
    
   private func collectionViewLayout (_ collectionView: UICollectionView){
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 1
    layout.minimumInteritemSpacing = 0
    }
    
// MARK: - CollectionViewCellRegister
    
    private func imageCollectionViewRegister (_ collectionView: UICollectionView){
        imageCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ImageViewController.self))
    }
    
// MARK: - CollectionViewBackground
    
    private func imageCollectionBackground (_ collectionView: UICollectionView){
        imageCollectionView.backgroundColor = .black
    }
}
