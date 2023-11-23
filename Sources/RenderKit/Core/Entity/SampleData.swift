//
//  File.swift
//  
//
//  Created by Darren Hurst on 2023-10-30.
//

import Foundation

public class MoviePoster: Identifiable, Hashable {
    public static func == (lhs: MoviePoster, rhs: MoviePoster) -> Bool {
        lhs.id == rhs.id
    }
    
    public var id: Int
    var poster: String
    init(id: Int, poster: String){
        self.id = id
        self.poster = poster
    }
    public func hash(into hasher: inout Hasher) {
           hasher.combine(id)
           hasher.combine(poster)
       }
}

public class SampleData: ObservableObject {
    @Published var name: String = "Darren"
    @Published var loginID: String = ""
    
    @Published var selectedMovie: MoviePoster?
    @Published var moviePosters = [
        MoviePoster.init(id: 0, poster: "https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_UY268_CR0,0,182,268_AL_.jpg"),
        MoviePoster.init(id: 1, poster: "https://m.media-amazon.com/images/M/MV5BM2MyNjYxNmUtYTAwNi00MTYxLWJmNWYtYzZlODY3ZTk3OTFlXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UY268_CR1,0,182,268_AL_.jpg"),
        MoviePoster.init(id: 3, poster: "https://m.media-amazon.com/images/M/MV5BMWMwMGQzZTItY2JlNC00OWZiLWIyMDctNDk2ZDQ2YjRjMWQ0XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UY268_CR0,0,182,268_AL_.jpg"),
        MoviePoster.init(id: 4, poster: "https://m.media-amazon.com/images/M/MV5BNDE4OTMxMTctNmRhYy00NWE2LTg3YzItYTk3M2UwOTU5Njg4XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_UY268_CR0,0,182,268_AL_.jpg"),
        MoviePoster.init(id: 5, poster: "https://m.media-amazon.com/images/M/MV5BNzA5ZDNlZWMtM2NhNS00NDJjLTk4NDItYTRmY2EwMWZlMTY3XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UY268_CR0,0,182,268_AL_.jpg"),
        MoviePoster.init(id: 6, poster: "https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_UY268_CR0,0,182,268_AL_.jpg"),
        MoviePoster.init(id: 7, poster: "https://m.media-amazon.com/images/M/MV5BNGNhMDIzZTUtNTBlZi00MTRlLWFjM2ItYzViMjE3YzI5MjljXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UY268_CR0,0,182,268_AL_.jpg"),
        MoviePoster.init(id: 8, poster: "https://m.media-amazon.com/images/M/MV5BOTQ5NDI3MTI4MF5BMl5BanBnXkFtZTgwNDQ4ODE5MDE@._V1_UY268_CR0,0,182,268_AL_.jpg"),
        MoviePoster.init(id: 10, poster: "https://m.media-amazon.com/images/M/MV5BMmEzNTkxYjQtZTc0MC00YTVjLTg5ZTEtZWMwOWVlYzY0NWIwXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UY268_CR0,0,182,268_AL_.jpg")]
        }
