//
//  MovieRowView.swift
//  MoviesAndActors
//
//  Created by Conner Yoon on 5/26/24.
//

import SwiftUI
import SwiftData

struct MovieRowView: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(movie.name)")
                .font(.title2)
                .bold()
            HStack {
                ForEach(movie.cast) { actor in
                    Text(actor.name)
                        .font(.subheadline)
                        .padding(4)
                        .background {
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundStyle(.secondary.opacity(0.1))
                        }
                }
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Movie.self, configurations: config)
    let movie = Movie.examples[0]
    let actor = Actor.examples[0]
    container.mainContext.insert(movie)
    container.mainContext.insert(actor)
    movie.cast.append(Actor.examples[0])
    return MovieRowView(movie: movie)
}
