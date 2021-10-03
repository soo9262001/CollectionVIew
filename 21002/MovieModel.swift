//
//  MovieModel.swift
//  21002
//
//  Created by kms on 2021/10/02.
//

import Foundation

struct MovieModel: Codable {
    var id : Int
    var title : String?
    var img: String?
    var poster: String?
    var date : String?
    var average : Float?
    var overview : String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case img = "poster_path"
        case poster = "backdrop_path"
        case date = "release_date"
        case average = "vote_average"
        case overview
    }
    
    init(from decoder: Decoder) throws {
        let val = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try val.decode(Int.self, forKey: .id)
        title = try val.decodeIfPresent(String.self, forKey: .title)
        img = try val.decodeIfPresent(String.self, forKey: .img)
        poster = try val.decodeIfPresent(String.self, forKey: .poster)
        date = try val.decodeIfPresent(String.self, forKey: .date)
        average = try val.decodeIfPresent(Float.self, forKey: .average)
        overview = try val.decodeIfPresent(String.self, forKey: .overview)
    }
}

struct MovieDataStore: Codable {
    var results : [MovieModel]
}
