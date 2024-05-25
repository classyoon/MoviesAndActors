//
//  MovieList.swift
//  MoviesAndActors
//
//  Created by Conner Yoon on 5/25/24.
//

import SwiftUI
import SwiftData
struct MovieList: View {
    @Environment(\.modelContext) var modelContext
    @Query private var movies : [Movie]
    var body: some View {
        List {
            ForEach(movies){ movie in
                NavigationLink {
                    MovieEditView(movie: movie)
                } label: {
                    Text(movie.name)
                }

            }
        }
    }
}
struct MovieEditView : View {
    @Bindable var movie : Movie
    var body: some View {
        Form {
            TextField("", text: $movie.name)
            NavigationLink {
                ActorsPickerView(movie: movie)
            } label: {
                Text("Add Actors")
            }

        }
    }
}

extension Movie {
    static let examples : [Movie] = [Movie(name: "Avengers"), Movie(name: "Mission Impossible")]
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Movie.self, configurations: config)
    Movie.examples.forEach { movie in
        container.mainContext.insert(movie)
    }
    return NavigationStack{MovieList()
        .modelContainer(container)}
}
