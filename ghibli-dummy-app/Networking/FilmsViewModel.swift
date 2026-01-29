//
//  FilmsViewModel.swift
//  ghibli-dummy-app
//
//  Created by Ronny Gunadi on 29/01/26.
//
import Foundation
import Observation

@Observable
class FilmsViewModel {
    
    enum State: Equatable {
        case idle
        case loading
        case loaded([Film])
        case error(String)
    }
    
    var state: State = .idle
    var films: [Film] = []
    
    private let service: GhibliServices
    
    init(service: GhibliServices = DefaultGhibliServices()) {
        self.service = service
    }
    
    func fetch() async {
        guard state == .idle else { return }
        
        state = .loading
        
        do {
            let films = try await service.fetchFilms()
            self.state = .loaded(films)
        } catch let error as APIError {
            self.state = .error(error.localizedDescription)
        } catch {
            self.state = .error(error.localizedDescription)
        }
    }
}
