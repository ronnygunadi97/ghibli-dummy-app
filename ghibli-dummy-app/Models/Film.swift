//
//  Film.swift
//  ghibli-dummy-app
//
//  Created by Ronny Gunadi on 29/01/26.
//
struct Film: Codable, Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let image: String
    let director: String
    let description: String
    let producer: String
    let bannerImage: String
    let releaseYear: String
    let score: String
    let duration: String
    let people: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, title, image, director, description, producer, people
        case bannerImage = "movie_banner"
        case releaseYear = "release_date"
        case duration = "running_time"
        case score = "rt_score"
    }
    
    static var example: Film {
        MockGhibliServices().fetchFilm()
    }
}
