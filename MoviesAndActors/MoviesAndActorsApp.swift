//
//  MoviesAndActorsApp.swift
//  MoviesAndActors
//
//  Created by Conner Yoon on 5/25/24.
//

import SwiftUI
import SwiftData

@main
struct MoviesAndActorsApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Movie.self, Actor.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
           MainView()
        }
        .modelContainer(sharedModelContainer)
    }
}
