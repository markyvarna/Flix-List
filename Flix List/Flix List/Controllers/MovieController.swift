//
//  MovieController.swift
//  Flix List
//
//  Created by Markus Varner on 9/7/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

//https://api.themoviedb.org/3

class MovieController {
    
    static let shared = MovieController()
    private init() {}
    let baseURL = URL(string: "https://api.themoviedb.org/3")
    var movies: [Movie] = []
    
    
    func fetchMovies(by searchTerm: String, completion: @escaping ([Movie?]) -> Void) {
        
        guard let url = baseURL else {
            fatalError("BAD URL")
        }
        
        let newURL = url.appendingPathComponent("search").appendingPathComponent("movie")
        var components = URLComponents(url: newURL, resolvingAgainstBaseURL: true)
        let queryItem = URLQueryItem(name: "api_key", value: "4c5ab512bcf7e4578d8704902773141d")
        let queryItem2 = URLQueryItem(name: "query", value: "\(searchTerm)")
        components?.queryItems = [queryItem, queryItem2]
        
        guard let builtURL = components?.url else { print("bad built url"); completion([]); return}
        
        URLSession.shared.dataTask(with: builtURL) { (data, _, error) in
            
            if let error = error {
                print("Error with dataTask Network error:  \(error) \(#function)")
                completion([]); return
            }
            
            
            guard let data = data else {completion([]); return}
            do{
                let movies = try JSONDecoder().decode(Results.self, from: data).results
                self.movies = movies
                completion(movies)
                
            } catch let error {
                print("🤬There was an error with JSONDecoder \(error)")
                completion([]); return
            }
            
            }.resume()
    }
    
    func fetchImage(movie: Movie, completion: @escaping (UIImage?) -> Void) {
        
        guard let poster = movie.imagePath else {completion(nil); return}
        guard let newUrl = URL(string: "https://image.tmdb.org/t/p/w500/")?.appendingPathComponent("\(poster)") else {completion(nil); return}
        
        
        
        URLSession.shared.dataTask(with: newUrl) { (data, _, error) in
            
            if let error = error {
                print("dataTask Network Error \(error)")
            }
            
            guard let data = data else {completion(nil); return}
            
            let image = UIImage(data: data)
            completion(image)
            
            
            
            
            }.resume()
        
        
    }
}
