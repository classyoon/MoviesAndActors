//
//  ActorListView.swift
//  MoviesAndActors
//
//  Created by Conner Yoon on 5/25/24.
//

import SwiftUI
import SwiftData
struct ActorListView: View {
    @Environment (\.modelContext) var modelContext
    @Query private var actors : [Actor]
    var body: some View {
        NavigationStack{
            List {
                ForEach(actors){ actor in
                    NavigationLink {
                        ActorEditView(actor: actor)
                    } label: {
                        Text(actor.name)
                    }
                    
                    
                }
            }
            .listStyle(.plain)
            .navigationTitle("Actors")
                .navigationTitle("Home view")
                .toolbarBackground(.yellow,
                                   for: .navigationBar)
                .toolbarBackground(.visible,
                                   for: .navigationBar)
        }
    }
}
struct ActorEditView : View {
    @Bindable var actor : Actor
    var body: some View {
        Form {
            TextField("", text: $actor.name)
        }
    }
}
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Actor.self, configurations: config)
    Actor.examples.forEach { actor in
        container.mainContext.insert(actor)
    }
    return NavigationStack{ActorListView()
        .modelContainer(container)}
}
