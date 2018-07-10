//
//  API.swift
//  MYIMDB
//
//  Created by yasmeenk on 21/10/1439 AH.
//  Copyright © 1439 IMDBAPP. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class API: NSObject {

    class func MarkFavoriate(media_id: Int, favorite: Bool,  completion: @escaping (_ error: Error?, _ success: Bool)->Void) {
        let url = URLs.GET_MarkAsFavorite
        let headers: [String : String] = ["content-type": "application/json;charset=utf-8"]
        
        let parameters : [String: Any] = [
       
            "media_type": "movie",
            "media_id": media_id,
            "favorite": favorite
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    completion(error, false)
                    print(error)
                    print(url)
                    print(parameters)
                    
                case .success(let value):
                    let json = JSON(value)
                    
                    if let api_token = json["status_message"].string {
                        print("api_token: \(api_token)")
                        
                        // save api token to UserDefaults
                       // helper.saveApiToken(token: api_token)
                        
                        completion(nil, true)
                    }
                }
                
        }
    }
    class func LatestMovie(page: Int = 1, completion: @escaping (_ error: Error?, _ movies: [Movie]?, _ last_page: Int)->Void) {
        let url = URLs.GET_movie_latest
        let parameters: [String: Any] = [
            "api_key": URLs.api_key]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseJSON {  response in
                print(url)
                switch response.result
                {
                case .failure(let error):
                    completion(error, nil, page)
                    print(error)
                    
                case .success(let value):
                    
                    let json = JSON(value)
                    print(json)
                    
                    guard let dataArr = json["results"].array else {
                        completion(nil, nil, page)
                        return
                    }
                    
                    var tasks = [Movie]()
                    for data in dataArr {
                        if let data = data.dictionary, let task = Movie.init(dict: data) {
                            tasks.append(task)
                            
                        }
                       
                    }
                    
                    let last_page = json["last_page"].int ?? page
                    completion(nil, tasks, last_page)
                }
                
                
                
                completion(nil, nil, 0)
                }
        
    }
    
    class func SearchMovie(query:String, page: Int = 1, completion: @escaping (_ error: Error?, _ movies: [Movie]?, _ last_page: Int)->Void) {
        let url = URLs.GET_Search_Movies
        let parameters: [String: Any] = [
            "api_key": URLs.api_key,
            "query":query]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                print(url)
                switch response.result
                {
                case .failure(let error):
                    completion(error, nil, page)
                    print(error)
                    
                case .success(let value):
               
                    let json = JSON(value)
                    print(json)
                    
                    guard let dataArr = json["results"].array else {
                        completion(nil, nil, page)
                        return
                    }
                    
                    var tasks = [Movie]()
                    for data in dataArr {
                        if let data = data.dictionary, let task = Movie.init(dict: data) {
                            tasks.append(task)
                            GlobalMovies = tasks
                        }
                    }
                    
                    let last_page = json["last_page"].int ?? page
                    GlobalMovies = tasks
                    completion(nil, tasks, last_page)
                }

                    
                    
                    completion(nil, nil, 0)
                }
                
        }
    class func GetFavoriteMovie( page: Int = 1, completion: @escaping (_ error: Error?, _ movies: [Movie]?, _ last_page: Int)->Void) {
        let url = URLs.Get_favorite_movies
        let parameters = [
            "api_key": URLs.api_key,
            "session_id":URLs.session_id]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                print(url)
                switch response.result
                {
                case .failure(let error):
                    completion(error, nil, page)
                    print(error)
                    
                case .success(let value):
                    
                    let json = JSON(value)
                    print(json)
                    
                    guard let dataArr = json["results"].array else {
                        completion(nil, nil, page)
                        return
                    }
                    
                    var tasks = [Movie]()
                    for data in dataArr {
                        if let data = data.dictionary, let task = Movie.init(dict: data) {
                            tasks.append(task)
                            GlobalMovies = tasks
                        }
                    }
                    
                    let last_page = json["last_page"].int ?? page
                    GlobalMovies = tasks
                    completion(nil, tasks, last_page)
                }
                
                
                
                completion(nil, nil, 0)
        }
        
    }
    
}


