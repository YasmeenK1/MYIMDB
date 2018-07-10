//
//  ViewController.swift
//  MYIMDB
//
//  Created by yasmeenk on 21/10/1439 AH.
//  Copyright © 1439 IMDBAPP. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

var GlobalMovies = [Movie]()
var myIndex = 0
var isFavoriate = false

class MainViewController: UIViewController {
    fileprivate let cellIdentifier = "MovieCell"
    fileprivate let cellHeight: CGFloat = 60.0
    var movies = [Movie]()
    @IBOutlet weak var QueryTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    lazy var refresher: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        return refresher
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.separatorInset = .zero
        tableView.contentInset = .zero
        
        tableView.addSubview(refresher)
        
        tableView.register(MovieCell.self, forCellReuseIdentifier: cellIdentifier)
     
    }
   
    
    @IBAction func SearchButton(_ sender: UIButton) {
        isFavoriate = false
        tableView.dataSource = self
        //  tableView.delegate = self
        handleRefresh()
         performSegue(withIdentifier: "segue", sender: self)
    }
    
    @IBAction func GetMyFavButton(_ sender: UIButton) {
        isFavoriate = true
        tableView.dataSource = self
        //  tableView.delegate = self
        handleRefresh()
        
    }
    var isLoading: Bool = false
    var current_page = 1
    var last_page = 1
    
    @objc fileprivate func handleRefresh() {
        self.refresher.endRefreshing()
        guard !isLoading else { return }
        
        isLoading = true
        if(!isFavoriate){
        API.SearchMovie(query: QueryTextField.text!)    { (error: Error?, movies: [Movie]?, last_page: Int) in
        
            
            self.isLoading = false
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
                
                self.current_page = 1
                self.last_page = last_page
            }
        }}
        else{
        API.GetFavoriteMovie { (error: Error?, movies: [Movie]?, last_page: Int) in
            
            
            self.isLoading = false
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
                
                self.current_page = 1
                self.last_page = last_page
            }
        }
        }
        
    }
    
    fileprivate func loadMore() {
        guard !isLoading else { return }
        guard current_page < last_page else { return }
        
        isLoading = true
        API.SearchMovie(query: QueryTextField.text!) { (error: Error?, movies: [Movie]?, last_page: Int) in
            self.isLoading = false
            if let movies = movies {
                self.movies.append(contentsOf: movies)
                self.tableView.reloadData()
                
                self.current_page += 1
                self.last_page = last_page
            }
        }
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)as? MovieCell else {
            return UITableViewCell()
        }
        
        
        let movie = movies[indexPath.row]
        cell.configureCell(movie: movie)
        // cell.textLabel?.text = "Mycell\(indexPath)"
        
        return cell
    }
    
}

