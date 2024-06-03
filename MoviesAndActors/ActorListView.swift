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
                        HStack{
                            if let data = actor.imageData, let uiImage = UIImage(data: data) {
                                  Image(uiImage: uiImage)
                                      .resizable()
                                      .scaledToFill()
                                      .frame(width: 50, height: 50)
                                      .clipShape(Circle())
                              
                              }else{
                                  Image(systemName: "person")
                                      .resizable()
                                      .scaledToFill()
                                      .frame(width: 50, height: 50)
                                      .clipShape(Circle())
                              }
                            Text(actor.name)
                          
                        }
                        
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
import PhotosUI
struct ActorEditView : View {
    @Bindable var actor : Actor
    @State private var photosPickerItem : PhotosPickerItem?
    @State private var profileImage : Image?
    var save : (Actor)->()
    var delete : (Actor)->()
    @Environment(\.dismiss) var dismiss
    @State private var sourceType : SourceType?
    
    var body: some View {
        Form {
            VStack {
                PhotosPicker("Select avatar", selection: $photosPickerItem, matching: .images)
                if let data = actor.imageData, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                
                }else{
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                }
                Button {
                    sourceType = .camera
                } label: {
                    Image(systemName: "camera.circle")
                }

            }
            .onChange(of: photosPickerItem) {
                Task {
                    if let data = try? await photosPickerItem?.loadTransferable(type: Data.self) {
                        if let uiImage = UIImage(data: data) {
                            profileImage = Image(uiImage: uiImage)
                            actor.imageData = data
                        }
                    } else {
                        print("Failed")
                    }
                }
            }
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
            
            
        }
        
        .background(Color.yellow).scrollContentBackground(.hidden)
        .sheet(item: $sourceType) { sourceType in
            CameraView(sourceType: sourceType, imageData: $actor.imageData)
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
