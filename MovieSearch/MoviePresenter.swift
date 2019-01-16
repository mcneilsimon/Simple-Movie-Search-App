//
//  MoviePresenter.swift
//  
//
//  Created by Simon Mc Neil on 2018-04-18.
//

import UIKit

class MoviePresenter: NSObject, UICollectionViewDelegate {

    weak var viewController: MovieViewController?
    
    let dataSource: MovieDataSource = MovieDataSource()
    
    init(viewController: MovieViewController?) {
        super.init()
        self.viewController = viewController
    }
}
