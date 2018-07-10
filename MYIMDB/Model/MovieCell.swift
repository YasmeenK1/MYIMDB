//
//  MovieCell.swift
//  MYIMDB
//
//  Created by yasmeenk on 21/10/1439 AH.
//  Copyright © 1439 IMDBAPP. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
    }
    
    func configureCell(movie: Movie) {
        textLabel?.text = " [ " + movie.MovieTitle+" ]  No is  [\(movie.MovieID)]"
        
        
}
}

