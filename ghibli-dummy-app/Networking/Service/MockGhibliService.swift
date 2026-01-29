//
//  MockGhibliService.swift
//  ghibli-dummy-app
//
//  Created by Ronny Gunadi on 29/01/26.
//
import Foundation

struct MockGhibliServices: GhibliServices {
    private struct SampleData: Decodable {
        let film: [Film]
        let people: Person
    }
    
    private func loadSampleData() throws -> SampleData {
        guard let url = Bundle.main.url(forResource: "SampleData", withExtension: "json") else {
            throw APIError.invalidURL
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(SampleData.self, from: data)
        } catch let error as DecodingError {
            print(error)
            throw APIError.decoding(error)
        } catch {
            throw APIError.networkError(error)
        }
    }
    
    func fetchFilms() async throws -> [Film] {
        let data = try loadSampleData()
        return data.film
    }
    
    func fetchPeople(from URLString: String) async throws -> Person {
        let data = try loadSampleData()
        return data.people
    }
    
    //MARK: - preview/testing only
    
    func fetchFilm() -> Film {
        let data = try! loadSampleData()
        return data.film.first!
    }
}
