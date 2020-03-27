//
//  MovieTableViewCell.swift
//  Flicks Search -ObjC
//
//  Created by theevo on 3/27/20.
//  Copyright © 2020 Theo Vora. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var movie: TTVMovie? {
        didSet {
            guard let movie = movie else { return }
            
            let rating: String = movie.rating.stringValue
            
            movieTitleLabel.text = movie.title
            movieRatingLabel.text = "Rating: \(rating)"
            movieDescriptionLabel.text = movie.movieDescription
            posterImageView.image = nil
            
            TTVMovieController.fetchMoviePoster(for: movie) { (maybePoster) in
                
                if let posterImage = maybePoster{
                    DispatchQueue.main.async {
                        self.posterImageView.image = posterImage
                    }
                } else {
                    print("\(movie.title) had no poster.")
                }
            }
        }
    }
    
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    
    
    
}
