//
//  MovieViewController.swift
//  MovieSearch
//
//  Created by Simon Mc Neil on 2018-04-18.
//  Copyright © 2018 Simon Mc Neil. All rights reserved.
//

import UIKit
import Alamofire

class MovieViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var movies = [Movies]()
    private var isFiltering: Bool = false
    
    private var filteredObjects = [Movies]()


    var MULTI_SEARCH_API = "https://api.themoviedb.org/3/search/multi?api_key=27559d05aaa4d70e0a93c61b3ebe0b1e&language=en-US&query=MovieName&page=1&include_adult=false"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let jsonUrlString = URL(string: API_URL) else {
            return
        }
        
        URLSession.shared.dataTask(with: jsonUrlString) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse  else {
                return
            }
            
            print("statusCode: \(httpResponse.statusCode)")
            switch(httpResponse.statusCode) {
            case 200:
                guard let data = data else {
                    return
                }
                do {
                    self.movies = try [JSONDecoder().decode(Movies.self, from: data)]
                    print(self.movies)
                } catch let error{
                    print("Error description", error)
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            default:
                print(error!.localizedDescription)
            }
        }.resume()
        
        searchBar.placeholder = "Search Movie"
        title = "Movies"
        
    }
    
    
    func filterMovies(searchTerm: String) {
        if searchTerm.isEmpty {
            isFiltering = false
            filteredObjects.removeAll()
        } else {
            isFiltering = true
            
            //filteredObjects = objects.filter({
            //    return $0.original_Title.localizedCaseInsensitiveContains(searchTerm)
            //})
            //print("\(searchTerm)\n")
            
            let movieValue = MULTI_SEARCH_API.replacingOccurrences(of: "MovieName", with: searchTerm)

            guard let jsonUrlString = URL(string: movieValue) else {
                return
            }
            
            URLSession.shared.dataTask(with: jsonUrlString) { (data, response, error) in
                
                guard let httpResponse = response as? HTTPURLResponse  else {
                    return
                }
                
                switch(httpResponse.statusCode) {
                    case 200:
                        guard let data = data else {
                            return
                        }
                        do {
                            self.filteredObjects = try [JSONDecoder().decode(Movies.self, from: data)]
                        } catch let error{
                            print("Error description", error)
                        }
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    default:
                        print(error!.localizedDescription)
                    }
                }.resume()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if isFiltering {
            return filteredObjects[0].results.count
        } else {
            return arrayDefaultSize()
        }
    }
    
    /* Sets the spacing between cells, note you need to import UICollectionViewDelegateFlowLayout in
       order for this to work */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCell
        cell.movieImage.downloadedImage(link: IMAGE_URL + movies[0].results[indexPath.row].poster_path!)
        switch isFiltering {
            case false:
                if self.movies[0].results[indexPath.row].poster_path == nil {
                
                }
                cell.movieImage.downloadedImage(link: IMAGE_URL + movies[0].results[indexPath.row].poster_path!)
            case true:
                if self.filteredObjects[0].results[indexPath.row].poster_path == nil {
                
                } else {
                    cell.movieImage.downloadedImage(link: IMAGE_URL + filteredObjects[0].results[indexPath.row].poster_path!)
                }
        }
        
        //creates rounded corners for the images
        cell.movieImage.layer.cornerRadius = 4.0
        
        // Line 60-69 are simply shadow styling techniques
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    
    // MARK: - UISearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterMovies(searchTerm: searchText)
        //collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        filterMovies(searchTerm: "")
        //collectionView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func arrayDefaultSize() -> Int {
        if movies.isEmpty {
            return 0
        } else {
            return movies[0].results.count
        }
    }
}



















