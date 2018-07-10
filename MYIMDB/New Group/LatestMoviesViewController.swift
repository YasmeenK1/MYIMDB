//
//  LatestMoviesViewController.swift
//  MYIMDB
//
//  Created by yasmeenk on 21/10/1439 AH.
//  Copyright © 1439 IMDBAPP. All rights reserved.
//

import UIKit

class LatestMoviesViewController: UIViewController {
    fileprivate let cellIdentifier = "MovieCell"
    fileprivate let cellHeight: CGFloat = 60.0
    
    @IBOutlet weak var tableView: UITableView!
    var movies = [Movie]()
    
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
        API.LatestMovie{ (error: Error?, movies: [Movie]?, last_page: Int) in
            self.isLoading = false
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
                
                self.current_page = 1
                self.last_page = last_page
            }
        }
        
    }
    
    fileprivate func loadMore() {
        guard !isLoading else { return }
        guard current_page < last_page else { return }
        
        isLoading = true
        API.LatestMovie(page: current_page+1) { (error: Error?, movies: [Movie]?, last_page: Int) in
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
   
    extension LatestMoviesViewController: UITableViewDataSource {
        
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
    
    




