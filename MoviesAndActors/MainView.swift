//
//  MainView.swift
//  MoviesAndActors
//
//  Created by Conner Yoon on 5/26/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    var body: some View {
        TabView {
            Group {
                ActorListView().tabItem { Label("Actors", systemImage: "person") }
                
                MovieListView().tabItem { Label("Movies", systemImage: "movieclapper") }
            }.toolbarBackground(.indigo, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
}

#Preview {
   
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Actor.self, configurations: config)
    Actor.examples.forEach { actor in
        container.mainContext.insert(actor)
    }
    Movie.examples.forEach {
        container.mainContext.insert($0)
    }
    return MainView()
        .modelContainer(container)
}
