//
//  MovieListTableViewController.swift
//  Flicks Search -ObjC
//
//  Created by theevo on 3/27/20.
//  Copyright © 2020 Theo Vora. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var movies: [TTVMovie] = []
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        
        let movie = movies[indexPath.row]
        
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = movie.movieDescription
        
        return cell
    }
    
} // end class ViewController

extension MovieListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text,
            !searchText.isEmpty else { return }
        
        TTVMovieController.fetchMovies(with: searchText) { (maybeMovies) in
            
            if let movieArray = maybeMovies {
                DispatchQueue.main.async {
                    self.movies = movieArray
                    self.tableView.reloadData()
                }
            } else {
                print("Error: no movies were returned from API call.")
            }
        }
    }
} // end extension
