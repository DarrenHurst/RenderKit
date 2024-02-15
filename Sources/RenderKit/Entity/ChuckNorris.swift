//
//  File.swift
//  
//
//  Created by Darren Hurst on 2023-11-21.
//

import Foundation
import SwiftUI

struct ChuckNorrisJoke: Codable {
    let value: String
}

enum ChuckNorrisError: StringLiteralType, Error {
    case nojoke = "I'm sorry no joke"
}

@available(iOS 16.0, *)
struct Jokes: View {
    @State private var joke: ChuckNorrisJoke? = nil
    @State var showAlert: Bool = false
   
    var body: some View {
        
        GeometryReader { r in
            VStack {
                Text(joke?.value ?? "")
                    .padding(10)
                    .font(.title3)
                    .frame(width:r.size.width,height:r.size.height)
                    .opacity(showAlert ? 0.0 : 1.0)
                   
                RenderButton(text: "Next Joke", shape: Capsule()){
                    showAlert = true
                    Task {
                        do {
                            guard let chuckNorrisJoke: ChuckNorrisJoke = try await Network().fetch(from: ModuleWorkFlow.endpoints.chuckNorris.rawValue) else {
                                throw ChuckNorrisError.nojoke
                                }
                            joke = chuckNorrisJoke
                            
                        } catch {
                            print(error)
                        }
                    }
                }
                .offset(y:-80)
               // .buttonStyle(.borderedProminent)
            }
            .frame(width:r.size.width,height:r.size.height)
            .navigationTitle("Chuck Norris Jokes")
            .overlay(
                VStack{
                    Alert("Getting a new Chuck Norris joke", okBtn: {
                        showAlert = false
                    })
                }
                .frame(width:r.size.width, height: r.size.height)
                .opacity(showAlert ? 1.0 : 0.0))
            .animation(Animation.linear(duration: 0.07), value: showAlert)
           
        }
    }
      
    
         
}

@available(iOS 16.0, *)
struct joke: PreviewProvider {
    static var previews: some View {
      Jokes()
    }
}

