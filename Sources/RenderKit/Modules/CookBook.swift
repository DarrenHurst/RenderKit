//
//  File.swift
//  
//
//  Created by Darren Hurst on 2024-02-15.
//

import Foundation
import SwiftUI

class Recipe : Identifiable, Hashable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.id == rhs.id
    }
    
    var id:UUID = UUID()
    @Published var name: String?
    @Published var description: String?
    @Published var ingredients: [Ingredients]?
    @Published var steps: [String]?
    var instagramTag: String?
    var videoUrl: String?

    init(name: String? = nil, description: String? = nil, ingredients: [Ingredients]? = nil, steps: [String]? = nil, instagramTag: String? = nil, videoUrl: String? = nil) {
        self.name = name
        self.description = description
        self.ingredients = ingredients
        self.steps = steps
        self.instagramTag = instagramTag
        self.videoUrl = videoUrl
    }
    
    public func hash(into hasher: inout Hasher) {
           hasher.combine(id)
           hasher.combine(name)
       }
    
}

 

enum MeasureType: StringLiteralType {
    case cup = "Cup"
    case spoon = "Tbsp"
    case tea = "Tsp"
}

class Ingredients {
    var name: String?
    var measurement: MeasureType?
    var amount: Double?
    
    init(name: String? = nil, measurement: MeasureType? = nil, amount: Double? = nil) {
        self.name = name
        self.measurement = measurement
        self.amount = amount
    }
}

extension Recipe {
    func testRecipes() -> [Recipe] {
        return [
        Recipe(
        name: "Pub Style Fish",
        description: "Beer Battered Fisn n Chips",
        ingredients: [
            Ingredients(name: "Haddock or Sole", measurement: .cup, amount: 0.5)
        ],
        steps: [
        "Flour and Baking Powder, Old Bay, Garlic Powder, Salt in bowl",
        "Add 1 Beer slowly",
        "Looking for runny but not giggly",
        "Top setting on the fryer",
        "Dip and Fry",
        "Fry until golden brown"
        ],
        instagramTag: "darrenhurst_",
        videoUrl: "")
        ]
    }
    
    
}

struct RecipeCard: View {
    @State var recipes: [Recipe]?
    
    var body: some View {
   
        VStack(alignment: .leading, content: {
            List {
                ForEach($recipes.wrappedValue ?? []) { recipe in
                    Text(recipe.name ?? "Empty").font(.title).fontWeight(.bold)
                       VStack {
                           Text("Instagram Darrenhurst_").font(.Small).foregroundColor(.gray)
                               .offset(y:-30)
                           Text("Budget Rating").font(.subheadline)
                         ZStack {
                            Rating( value: 3.5, numberOf: 5, image: Image(systemName: "dollarsign.circle.fill"), image2: Image(systemName: "dollarsign.circle.fill"), color: .gray, fillColor: .yellow.opacity(0.9), width: 100)
                        }
                        Text("Yummy Rating").font(.subheadline)
                        
                        ZStack {
                            Rating( value: 4.0, numberOf: 5, image: Image(systemName: "heart.circle.fill"), image2: Image(systemName: "heart.circle"), color: .yellow.opacity(0.6), fillColor: .red.opacity(0.9), width: 100)
                            Rating( value: 4.0, numberOf: 5, image: Image(systemName: "heart.circle.fill"), image2: Image(systemName: "heart.circle.fill"), color: .clear.opacity(0.4), fillColor: .blue.opacity(0.4), width: 100)
                        }
                    }
                    .padding(7)
                    .padding(.bottom,14)
                    .background(.clear.opacity(0.2))
                    .background(Capsule().fill(.green.opacity(0.29)).padding(-5))
                    .scaleEffect(0.9)
                   
                      
                    HStack(alignment: .top) {
                       
                            VStack(alignment: .leading) {
                                let steps: [String] = recipe.steps ?? ["no steps available"]
                                ForEach(0..<steps.count) { step in
                                    Text("\(step+1).  \(steps[step])")
                                        .font(.Medium).foregroundColor(.black.opacity(0.7)).padding(2)
                                }
                            }
                        
                        VideoView(urlString: recipe.videoUrl ?? "")
                            .frame(width: 200, height: 350)
                        
                            .mask(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                    }.offset(y:-20)
        
                }
                //.background(.blue.opacity(0.06))
                    .padding(15)
            }
            .listStyle(.plain)
            .background(.green.opacity(0.32))
              
        })
        .background(.blue.opacity(0.5))
        .onAppear() {
            recipes = Recipe().testRecipes()
        }
    }
}

struct PreviewRecipeCard: PreviewProvider {
    static var previews: some View {
        RecipeCard()
    }
}

