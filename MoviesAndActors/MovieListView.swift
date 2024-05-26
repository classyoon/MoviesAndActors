//
//  MovieList.swift
//  MoviesAndActors
//
//  Created by Conner Yoon on 5/25/24.
//

import SwiftUI
import SwiftData
struct MovieListView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var movies : [Movie]
    var body: some View {
        NavigationStack{
            List {
                ForEach(movies){ movie in
                    NavigationLink {
                        MovieEditView(movie: movie)
                    } label: {
                        MovieRowView(movie: movie)
                    }
                    
                }
            }
            .listStyle(.plain)
            .navigationTitle("Movies")
                .navigationTitle("Home view")
                                        .toolbarBackground(.teal,
                                                           for: .navigationBar)
                                        .toolbarBackground(.visible,
                                                           for: .navigationBar)
        }
    }
}
struct MovieEditView : View {
    @Bindable var movie : Movie
    var body: some View {
        Form {
            TextField("", text: $movie.name)
                .textFieldStyle(.roundedBorder)
            VStack {
                ForEach(movie.cast){ actor in
                    Text(actor.name)
                        .font(.subheadline)
                        .padding(4)
                        .background {
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundStyle(.secondary.opacity(0.1))
                        }
                }
            }
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
    return NavigationStack{MovieListView()
        .modelContainer(container)}
}
