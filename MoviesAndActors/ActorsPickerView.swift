//
//  ActorsPickerView.swift
//  MoviesAndActors
//
//  Created by Conner Yoon on 5/25/24.
//

import SwiftUI
import SwiftData

struct ActorsPickerView : View {
    @Bindable var movie : Movie
    @Environment(\.modelContext) var modelContext
    @Query var actors : [Actor]
    var body: some View {
        
        List {
            ForEach(actors){ actor in
                Button(action: {
                    guard let index = movie.cast.firstIndex(where: {
                        $0 == actor
                    }) else {
                        movie.cast.append(actor)
                        
                        return }
                    movie.cast.remove(at: index)
                    
                }, label: {
                    HStack {
                        Text("\(actor.name)")
                        Spacer()
                        let text = movie.cast.contains(actor) ?  "checkmark.circle" : "circle"
                        Image(systemName: text)
                    }
                })
            }
        }
        .navigationTitle("Picker")
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Actor.self, configurations: config)
    Actor.examples.forEach { actor in
        container.mainContext.insert(actor)
    }
    return NavigationStack{ActorsPickerView(movie: Movie.examples[0]).modelContainer(container)}
}
