//
//  Config.swift
//  MYIMDB
//
//  Created by yasmeenk on 21/10/1439 AH.
//  Copyright © 1439 IMDBAPP. All rights reserved.
//

import Foundation

struct URLs {
    
    //static let main = "https://developers.themoviedb.org/3/"
    static let URL_main = "https://api.themoviedb.org/3/"
    // Path of poster
    static let file_root = "https://image.tmdb.org/t/p/w500"
    // API_KEY of IMDB Registeration
    static let api_key="4e23fdb57dee5bccd4f8f42c89f5ee01"
    // Session ID From Auth UserName & Password
    static let session_id="442d4333181d8526df909f4603cb99be1373de98"
    // Get GET movie/latest
    static let GET_movie_latest = URL_main+"movie/now_playing"
    // Get GET movie/SeRCH
    static let GET_Search_Movies = URL_main+"search/movie"
    // Get GET movie/MarK Fav
    static let GET_MarkAsFavorite = URL_main+"account/favorite?api_key=4e23fdb57dee5bccd4f8f42c89f5ee01&session_id=442d4333181d8526df909f4603cb99be1373de98"
    static let Get_favorite_movies = URL_main+"account/favorite/movies"
    
}


