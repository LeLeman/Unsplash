//
//  ViewController.swift
//  TestingTask
//
//  Created by Evgeniy Lemish on 29.08.2022.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var ImageCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var result: [Result] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 0
        
        ImageCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        ImageCollectionView.backgroundColor = .black
    }
 
    
    // MARK: - UISearchBar
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            result = []
            ImageCollectionView.reloadData()
            fenchPhoto(query: text)
        }
    }
    
    func fenchPhoto (query: String) {
        let urlString = "https://api.unsplash.com/search/photos?page=1&per_page=50&query=\(query)&client_id=8MDWl2zxg-XTw2tB9jQyWNDUxfWiY60sYqjVIsMHj88"
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) {[weak self]data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                print (jsonResult.results.count)
                 DispatchQueue.main.async {
                    self?.result = jsonResult.results
                    self?.ImageCollectionView.reloadData()
                 }
            } catch {
                print (error)
            }
        }.resume()
    }
    
 
    
    // MARK: - UICollectionViewDataSource
    
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return result.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageURLString = result[indexPath.row].urls.regular
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell()}
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
}
