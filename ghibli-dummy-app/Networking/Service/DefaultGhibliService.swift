//
//  DefaultGhibliService.swift
//  ghibli-dummy-app
//
//  Created by Ronny Gunadi on 29/01/26.
//
import Foundation

struct DefaultGhibliServices: GhibliServices {
    
    func fetch<T: Decodable>(from URLString: String, type: T.Type) async throws -> T {
        guard let url = URL(string: URLString) else {
            throw APIError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...209).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            
            return try JSONDecoder().decode(type, from: data)
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
    }
    
    func fetchFilms() async throws -> [Film] {
        let url = "https://ghibliapi.vercel.app/films"
        return try await fetch(from: url, type: [Film].self)
    }
    
    func fetchPeople(from URLString: String) async throws -> Person {
        return try await fetch(from: URLString, type: Person.self)
    }
}
