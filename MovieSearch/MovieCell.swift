//
//  MovieCell.swift
//  MovieSearch
//
//  Created by Simon Mc Neil on 2018-04-18.
//  Copyright © 2018 Simon Mc Neil. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleSetup()
    }
    
    
    func styleSetup() {
        movieImage.layer.borderWidth = 0.5
        movieImage.layer.borderColor = UIColor.lightGray.cgColor
    }
    /*
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImage.image = nil
    }*/
}


