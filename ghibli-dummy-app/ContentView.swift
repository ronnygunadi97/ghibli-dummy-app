//
//  ContentView.swift
//  ghibli-dummy-app
//
//  Created by Ronny Gunadi on 29/01/26.
//

import SwiftUI
import CoreData

import SwiftUI
//import CoreData

struct ContentView: View {
    @State private var filmsViewModel = FilmsViewModel()
    
    var body: some View {
        FilmListView()
    }
}

#Preview {
    ContentView()
}
