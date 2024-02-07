//
//  File.swift
//  
//
//  Created by Darren Hurst on 2023-10-30.
//

import Foundation
import SwiftUI

public class MoviePoster: Identifiable, Hashable {
    public static func == (lhs: MoviePoster, rhs: MoviePoster) -> Bool {
        lhs.id == rhs.id
    }
    
    public var id: Int
    var poster: String
    var rottenScore: String
    var score: CGFloat
    var name: String
    
    
    init(id: Int, poster: String, rottenScore: String, name: String, score: CGFloat){
        self.id = id
        self.poster = poster
        self.name = name
        self.score = score
        self.rottenScore = rottenScore
    }
    public func hash(into hasher: inout Hasher) {
           hasher.combine(id)
           hasher.combine(poster)
       }
}

public class SampleData: ObservableObject {
    @Published var segmentedControlView: any View = EmptyView()
    @Published var name: String = "Darren"
    @Published var loginID: String = ""
    @Published var showItem: Bool = false
    @Published var searchText: String = ""
    @Published var selectedMovie: MoviePoster?
    @Published var selectedMovieId: Int = 0
    @Published var moviePosters = [
        MoviePoster.init(id: 0, poster: "https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_UY268_CR0,0,182,268_AL_.jpg" , rottenScore: "80%", name:"Shawshank Redemption", score: 68.0),
        MoviePoster.init(id: 1, poster: "https://m.media-amazon.com/images/M/MV5BM2MyNjYxNmUtYTAwNi00MTYxLWJmNWYtYzZlODY3ZTk3OTFlXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UY268_CR1,0,182,268_AL_.jpg", rottenScore: "79%", name:"The Godfather", score: 76.5),
        MoviePoster.init(id: 2, poster: "https://m.media-amazon.com/images/M/MV5BMWMwMGQzZTItY2JlNC00OWZiLWIyMDctNDk2ZDQ2YjRjMWQ0XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UY268_CR0,0,182,268_AL_.jpg", rottenScore: "60%", name:"Godfather II", score: 66.5),
        MoviePoster.init(id: 3, poster: "https://m.media-amazon.com/images/M/MV5BNDE4OTMxMTctNmRhYy00NWE2LTg3YzItYTk3M2UwOTU5Njg4XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_UY268_CR0,0,182,268_AL_.jpg", rottenScore: "80%", name:"Schindeler's List", score: 88.5),
        MoviePoster.init(id: 4, poster: "https://m.media-amazon.com/images/M/MV5BNzA5ZDNlZWMtM2NhNS00NDJjLTk4NDItYTRmY2EwMWZlMTY3XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UY268_CR0,0,182,268_AL_.jpg", rottenScore: "50%", name:"Lord of the Rings", score: 96.5),
        MoviePoster.init(id: 5, poster: "https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_UY268_CR0,0,182,268_AL_.jpg", rottenScore: "78%", name:"Shawshank Redemption", score: 86.5),
        MoviePoster.init(id: 6, poster: "https://m.media-amazon.com/images/M/MV5BNGNhMDIzZTUtNTBlZi00MTRlLWFjM2ItYzViMjE3YzI5MjljXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UY268_CR0,0,182,268_AL_.jpg", rottenScore: "60%", name:"Pulp Fiction", score: 76.5),
        MoviePoster.init(id: 7, poster: "https://m.media-amazon.com/images/M/MV5BOTQ5NDI3MTI4MF5BMl5BanBnXkFtZTgwNDQ4ODE5MDE@._V1_UY268_CR0,0,182,268_AL_.jpg", rottenScore: "30%", name:"The Good, The Bad, The Ugly", score: 66.5),
        MoviePoster.init(id: 8, poster: "https://m.media-amazon.com/images/M/MV5BMmEzNTkxYjQtZTc0MC00YTVjLTg5ZTEtZWMwOWVlYzY0NWIwXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UY268_CR0,0,182,268_AL_.jpg", rottenScore: "50%", name:"Fight Club", score: 76.5)]
    
    @Published var shopItems: [Item] = [
        Item(name: "Gray Hoodie", description: "terry cloth fuzzy", size: "L", itemColor: "Gray", price: "30.00", image:"shot1", showItem: false),
        Item(name: "Black Rocker T Shirt", description: "100% cotton", size: "L", itemColor: "Black", price: "30.00", image:"shot2", showItem: false),
        Item(name: "Hoodie pull over", description: "terry cloth fuzzy", size: "M", itemColor: "Light Blue", price: "30.00", image:"shot3", showItem: false),
        Item(name: "Peace Up T Shirt", description: "woman tshirt", size: "M", itemColor: "Black", price: "30.00", image:"shot4", showItem: false),
    ]
    @Published var creatures: [Creature] = [
        Creature(image: "creature1"),
        Creature(image: "creature2"),
        Creature(image: "creature3"),
        Creature(image: "creature4"),
        Creature(image: "creature5"),
    ]
}

struct CardList: View {
    @StateObject var data = SampleData()
    var body: some View {
        VStack {
            ForEach(data.creatures) { creature in
                List{
                    Image(creature.image ?? "", bundle: Bundle.module)
                        .resizable()
                        .scaledToFill()
                        .frame(height:100)
                        .mask(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                  }
            }
        }
    }
}

                               
struct Creature : Identifiable {
    var id: UUID = UUID()
    var image: String?
}

struct Previews_SampleData_Previews: PreviewProvider {
    static var previews: some View {
      CardList()
    }
}
