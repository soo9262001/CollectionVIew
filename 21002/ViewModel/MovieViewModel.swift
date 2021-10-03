//
//  MovieViewModel.swift
//  21002
//
//  Created by kms on 2021/10/02.
//

import Foundation

class MovieViewModel {
    fileprivate let service = MovieDataServie()
    var popularMovies = [MovieModel]()
    var nowMovies = [MovieModel]()
    var upMovies = [MovieModel]()
    var movieInfo : MovieModel?
    
    var message : String?
    
    func getMovies(completion: @escaping((MovieViewState) -> Void)) {
        
        service.requestMovie(source: .popular) { movieList, error in
            if let error = error {
                self.message = error.localizedDescription
                completion(.failure)
                return
            }
            self.popularMovies = movieList
            completion(.success)
        }
        
        service.requestMovie(source: .nowplaying) { (movieList, error) in

            if let error = error {
                self.message = error.localizedDescription
                completion(.failure)
                return
            }
            self.nowMovies = movieList
            completion(.success)
        }
        
        service.requestMovie(source: .upcoming) { (movieList, error) in

            if let error = error {
                self.message = error.localizedDescription
                completion(.failure)
                return
            }
            self.upMovies = movieList
            completion(.success)
        }
    }

    func getMovieInfo(id: Int, completion: @escaping((MovieViewState) -> Void)) {
        service.requestMovieInfo(id: id) {
            (movie, error) in
            if let error = error {
                self.message = error.localizedDescription
                completion(.failure)
                return
            }
            self.movieInfo = movie
            completion(.success)
        }
    }
}
