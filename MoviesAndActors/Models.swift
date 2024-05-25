//
//  Models.swift
//  MoviesAndActors
//
//  Created by Conner Yoon on 5/25/24.
//

import Foundation
import SwiftData
@Model
class Movie {
    var name : String = ""
    @Relationship(inverse: \Actor.movies) var cast: [Actor]
    init(name: String = "", cast: [Actor] = []) {
        self.name = name
        self.cast = cast
    }
}


@Model
class Actor : Hashable {
    var name : String = ""
    var movies : [Movie]
    init(name: String = "", movies : [Movie] = []) {
        self.name = name
        self.movies = movies
    }
}
extension Actor {
    static let examples : [Actor] = [Actor(name: "Tom Cruise", movies: []), Actor(name: "Scarlet", movies: [])]
}
