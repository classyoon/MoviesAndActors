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
    @State private var isShowingSheet : Bool = false
    @State private var newActor : Actor?
    var body: some View {
        NavigationStack{
            List {
                ForEach(actors){ actor in
                    NavigationLink {
                        ActorEditView(actor: actor, save: {actor in
                            try? modelContext.save()
                        }, delete: {actor in
                            modelContext.delete(actor)
                        })
                    } label: {
                        Text(actor.name)
                    }
                    
                    
                }
            }
            .listStyle(.plain)
            .navigationTitle("Actors")
            .toolbar{
                Button(action: {
                    newActor = Actor()
                    modelContext.insert(newActor!)
                }, label: {
                    Text("Show Sheet")
                })
            }
            .sheet(item: $newActor, content: { actor in
                NavigationStack{
                    ZStack{
                        Color.red
                        ActorEditView(actor: actor, save: {_ in}, delete: {actor in
                            modelContext.delete(actor)
                            
                        }).navigationTitle("Add Actor").padding()
                    }
                }
            })
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
    var save : (Actor)->()
    var delete : (Actor)->()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Form {
            
            TextField("Type Actor Name", text: $actor.name)
            
                Button(action: {
                    save(actor)
                    dismiss()
                }, label: {
                    Text("Save")
                })
                Button(action: {
                    delete(actor)
                    dismiss()
                }, label: {
                    Text("Delete")
                })
            
            
        }.background(Color.yellow).scrollContentBackground(.hidden)
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
