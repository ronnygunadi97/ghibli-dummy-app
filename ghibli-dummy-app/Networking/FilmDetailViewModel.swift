//
//  FilmDetailViewModel.swift
//  ghibli-dummy-app
//
//  Created by Ronny Gunadi on 29/01/26.
//

import Foundation
import Observation

@Observable
class FilmDetailViewModel {
    
    enum State: Equatable {
        case idle
        case loading
        case loaded([Person])
        case error(String)
    }
    
    var state: State = .idle
    
    var people: [Person] = []
    
    private let service: GhibliServices
    
    init(service: GhibliServices = DefaultGhibliServices()) {
        self.service = service
    }
    
    func fetch(for film: Film) async {
        
        guard state != .loading else { return }
        
        state = .loading
        
        var loadedPeople: [Person] = []
        
        
        
        do {
            try await withThrowingTaskGroup(of: Person.self) { group in
                for personInfoURL in film.people {
                    group.addTask {
                        print("test \(film.people)")
                        return try await self.service.fetchPeople(from: personInfoURL)
                    }
                }
                for try await person in group {
                    loadedPeople.append(person)
                }
            }
            state = .loaded(loadedPeople)
        } catch let error as APIError {
            self.state = .error(error.localizedDescription)
        } catch {
            self.state = .error(error.localizedDescription)
        }
        
    }
}
