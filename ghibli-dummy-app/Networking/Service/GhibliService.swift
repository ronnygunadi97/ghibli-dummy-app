//
//  GhibliService.swift
//  ghibli-dummy-app
//
//  Created by Ronny Gunadi on 29/01/26.
//
import Foundation

protocol GhibliServices: Sendable {
    func fetchFilms() async throws -> [Film]
    func fetchPeople(from URLString: String) async throws -> Person
}
