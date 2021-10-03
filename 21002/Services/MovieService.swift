//
//  UserService.swift
//  21002
//
//  Created by kms on 2021/10/02.
//

import Foundation
import Moya

enum MovieService {
    case popular
    case nowplaying
    case upcoming
    case movieInfo(id: Int)
}

extension MovieService : TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie") else {
            fatalError("URL Error")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .popular:
            return "/popular"
        case .nowplaying:
            return "/now_playing"
        case .upcoming:
            return "/upcoming"
        case .movieInfo(let id):
            return "\(id)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .popular, .nowplaying, .upcoming:
            return .requestParameters(parameters: ["api_key" : "0e9447a2d2567ef3bd00018aca6d17a2"], encoding: URLEncoding.queryString)
        case .movieInfo(let id):
            return .requestParameters(parameters: ["api_key" : "0e9447a2d2567ef3bd00018aca6d17a2", "movie_id" : "id"], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type" : "application/json"]
    }
    
    
}
