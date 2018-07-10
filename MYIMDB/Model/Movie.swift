//
//  Movie.swift
//  MYIMDB
//
//  Created by yasmeenk on 21/10/1439 AH.
//  Copyright © 1439 IMDBAPP. All rights reserved.
//

import UIKit
import SwiftyJSON


class Movie: NSObject {
    // MARK: Properties
    
    var MovieTitle: String
    var MovieID: Int
    var MovieDescription: String
    var PosterPath: String
    
    
    
    init(MovieID: Int = 0, MovieTitle: String, MovieDescription: String, PosterPath: String) {
        self.MovieTitle = MovieTitle
        self.MovieID = MovieID
        self.MovieDescription=MovieDescription
        self.PosterPath = PosterPath
    }
    
  
    
    init?(dict: [String: JSON]) {
        guard let id = dict["id"]?.int, let name = dict["title"]?.string else { return nil }
        
        self.MovieID = id
        self.MovieTitle = name
        
        self.MovieDescription = dict["overview"]?.string ?? ""
        
        self.PosterPath = dict["poster_path"]?.string ?? ""
    }

    
    
    
    
}




