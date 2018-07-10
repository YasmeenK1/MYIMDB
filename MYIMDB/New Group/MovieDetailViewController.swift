//
//  MovieDetailViewController.swift
//  MYIMDB
//
//  Created by yasmeenk on 21/10/1439 AH.
//  Copyright © 1439 IMDBAPP. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var GenreOfTheMovies: UILabel!
    @IBOutlet weak var OverViewOFMovie: UILabel!
    @IBOutlet weak var TitleOFMovie: UILabel!
    @IBOutlet weak var PosterMovie: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

       OverViewOFMovie.text = GlobalMovies[myIndex].MovieDescription
         TitleOFMovie.text = GlobalMovies[myIndex].MovieTitle
         PosterMovie.image = UIImage(named: URLs.file_root + GlobalMovies[myIndex].PosterPath)
       
        print(URLs.file_root + GlobalMovies[myIndex].PosterPath)
       get_image(URLs.file_root + GlobalMovies[myIndex].PosterPath, PosterMovie)
       
    }
  
    @IBAction func MarkAsFavBtn(_ sender: UIButton) {

        API.MarkFavoriate(media_id: GlobalMovies[myIndex].MovieID, favorite: true) { (error: Error?, success: Bool) in
            if success {
                print("Favorite succeed !! welcome  :)")
            }
        }
    }
    @IBAction func MarkAsUnFavBtn(_ sender: UIButton) {
        API.MarkFavoriate(media_id: GlobalMovies[myIndex].MovieID, favorite: false) { (error: Error?, success: Bool) in
            if success {
                print("Favorite succeed !! welcome  :)")
            }
        }
        
    }
    
    func get_image(_ url_str:String, _ imageView:UIImageView)
    {
        
        let url:URL = URL(string: url_str)!
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: {
            (
            data, response, error) in
            
            
            if data != nil
            {
                let image = UIImage(data: data!)
                
                if(image != nil)
                {
                    
                    DispatchQueue.main.async(execute: {
                        
                        imageView.image = image
                        imageView.alpha = 0
                        
                        UIView.animate(withDuration: 2.5, animations: {
                            imageView.alpha = 1.0
                        })
                        
                    })
                    
                }
                
            }
            
            
        })
        
        task.resume()
    }



}
