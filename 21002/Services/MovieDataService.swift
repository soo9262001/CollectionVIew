//
//  UserDataService.swift
//  21002
//
//  Created by kms on 2021/10/02.
//

import Foundation
import Moya

class MovieDataServie {
    fileprivate let provider = MoyaProvider<MovieService>()
    
    func requestMovie(source: MovieService, completion: @escaping ([MovieModel], Error?) -> Void) {
        provider.request(source) { result in
            
            switch result {
            case .success(let res):
                do {
                    let decoder = JSONDecoder()
                    let movie = try decoder.decode(MovieDataStore.self, from: res.data)

                    completion(movie.results, nil)

                } catch let error {
                    completion([], error)

                }
            case .failure(let error):
                completion([],error)
            }
        }
    }
    
    func requestMovieInfo(id: Int, completion: @escaping((MovieModel, Error?) -> Void)) {
        provider.request(.movieInfo(id: id)) { result in
            switch result {
            case .success(let res):
//                print("----------", res)
                do {
                    let decoder = JSONDecoder()
                    let movie = try decoder.decode(MovieModel.self, from: res.data)
                    completion(movie, nil)
                    
                } catch let error {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
