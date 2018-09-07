//
//  ViewController.swift
//  Flix List
//
//  Created by Markus Varner on 9/7/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class MovieListVC: UIViewController, UISearchBarDelegate {
    
    //MARK: - Outlets
    
    @IBOutlet var movieTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    
    
    //MARK: - Properties
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        
        loadMovies()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        loadMovies()
       
    }
    
    func loadMovies() {
        guard let searchTerm = searchBar.text else {return}
        MovieController.shared.fetchMovies(by: searchTerm) { (movie) in
            
            DispatchQueue.main.async {
                self.movieTableView.reloadData()
            }
        }
        
    
    }
}
    extension MovieListVC: UITableViewDataSource, UITableViewDelegate {
        
        //MARK: - TableView Data Source Methods
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return MovieController.shared.movies.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTVCell
            let movie = MovieController.shared.movies[indexPath.row]
            cell?.movie = movie
            
            
            return cell ?? UITableViewCell()
        }
    }

