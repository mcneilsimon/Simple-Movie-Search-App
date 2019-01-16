//
//  MovieDataSource.swift
//  MovieSearch
//
//  Created by Simon Mc Neil on 2018-04-18.
//  Copyright © 2018 Simon Mc Neil. All rights reserved.
//
/*
import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class MovieDataSource: NSObject, UICollectionViewDataSource {
    
    weak var movieViewController: MovieViewController!
    private var movies: [String] = []
    
    func fill() {
        
        Alamofire.request(URL(string: API_URL)!,method: .get)
            .validate()
            .responseJSON { (response) in
                switch(response.result) {
                case .success:
                    let result = response.data
                    do {
                        let json = try JSON(data: result!)

                        self.movies = (json["results"].arrayValue.map({$0["poster_path"].stringValue}))
                        
                        for movieImagePath in self.movies {
                            print("\(IMAGE_URL)\(movieImagePath)")
                        }
                        DispatchGroup().notify(queue: DispatchQueue.main) {
                            self.movieViewController.collectionView.reloadData()
                        }
                        //self.viewController?.collectionView.reloadData()
                    } catch {
                        print("error")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
    func object(indexPath: IndexPath) -> String {
        //If we are filtering then return the objcet from the filtered objcet
        return movies[indexPath.item]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCell
        
        let url = URL(string:movies[indexPath.row])
        cell.movieImage.af_setImage(withURL: url!)
        
        return cell
    }
}
*/
