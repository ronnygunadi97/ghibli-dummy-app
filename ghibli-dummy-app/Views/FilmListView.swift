//
//  FilmListView.swift
//  ghibli-dummy-app
//
//  Created by Ronny Gunadi on 29/01/26.
//

import SwiftUI

struct FilmListView: View {
    
    var filmsViewModel = FilmsViewModel()
    
    var body: some View {
        NavigationStack {
            switch filmsViewModel.state {
            case .idle:
                Text("No film yet")
            case .loading:
                ProgressView {
                    Text("Loading...")
                }
            case .loaded(let films):
                List(films) { film in
                    NavigationLink(value: film) {
                        HStack {
                            FilmImageView(url: film.image)
                                .frame(width: 100, height: 150)
                            Text(film.title)
                        }
                        .padding(.bottom, 5)
                    }
                }
                .navigationDestination(for: Film.self) {
                    film in
                    FilmDetailScreen(film: film)
                }
            case .error(let error):
                Text(error)
                    .foregroundStyle(.pink)
            }
        }
        .task {
            await filmsViewModel.fetch()
        }
    }
}
