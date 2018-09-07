//
//  MovieTVCell.swift
//  Flix List
//
//  Created by Markus Varner on 9/7/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class MovieTVCell: UITableViewCell {
    
    
    //MARK: - Outlets
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var voteAvgLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var descriptionTextView: UITextView!
    
    //MARK: - Properties
    
    var movie: Movie? {
        didSet{
            updateViews()
        }
    }
    
    //MARK: - Update View
    
    func updateViews() {
        
            guard let movie = movie else {return}
            titleLabel.text = movie.title
            descriptionTextView.text = movie.overview
        voteAvgLabel.text = "\(movie.rating)"
            
        MovieController.shared.fetchImage(movie: movie) { (image) in
            DispatchQueue.main.async {
                self.posterImageView.image = image
            }
        }
        
        
        
    }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
