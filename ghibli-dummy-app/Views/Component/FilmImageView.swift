//
//  FilmImageView.swift
//  ghibli-dummy-app
//
//  Created by Ronny Gunadi on 29/01/26.
//
import SwiftUI

struct FilmImageView: View {
    
    let url: String
    
    init(url: String) {
        self.url = url
    }
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
                case .empty:
                    Color(white: 0.5)
                        .overlay {
                            ProgressView()
                                .controlSize(.large)
                        }
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .clipped()
                case .failure(_):
                    Text("Could not get image")
                @unknown default:
                    fatalError()
            }
        }
    }
}
