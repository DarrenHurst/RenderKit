//
//  File.swift
//  
//
//  Created by Darren Hurst on 2023-12-15.
//

import Foundation
import SwiftUI
import SpriteKit

struct Globe: View {
    @State private var particleSystem = ParticleView()
    @State private var startAnimation: Bool = false
    
    var scene: SKScene {
         let scene = SnowScene()
         scene.scaleMode = .resizeFill
         scene.backgroundColor = .clear
         return scene
     }
    
    
    var images: [String] = [
        "https://media.tenor.com/gF7eMTWxupAAAAAi/christmas-holiday.gif",
        "https://media.tenor.com/397DwhVvgK0AAAAi/happy-dance.gif"
    ]
    var body: some View {
        ZStack {
           Text("SWIFTUITREE")
                .font(.XLarge)
                .foregroundColor(Color.white.opacity(0.3))
            ZStack {
                Circle()
                    .stroke(.blue.opacity(0.5), lineWidth:4)
                    .frame(width:330)
                    .offset(y:-185)
                    .offset(x:-5)
                Rectangle()
                    .frame(width:350, height:350)
                    .offset(y:-185)
                    .opacity(0)
              
                particleSystem
                    .mask(Rectangle().frame(width:250, height:200))
                    .offset(x:-20, y:-185)
                    .opacity(startAnimation ? 1: 0)
                Circle()
                    .fill(Color.black.opacity(0.1))
                    .frame(width:310)
                    .offset(y:-180)
                
                ZStack {
                    Circle()
                        .fill(Color.black)
                        .transformEffect(CGAffineTransform(2, 1, 1, 1, 40, -100))
                        .rotationEffect(.degrees(-30))
                        .frame(width:99)
                        .offset(x:-100,y: -10)
                        .shadow(color: .white, radius: 5.0, x: 0, y: 30)
                    
                    Circle()
                        .fill(Color.black)
                        .transformEffect(CGAffineTransform(2, 1, 1, 1, 40, -100))
                        .rotationEffect(.degrees(-30))
                        .frame(width:110)
                        .offset(x:-110,y: 10)
                        .shadow(color: .black, radius: 25.0, x: 0, y: 0)
                    
                    
                    Circle()
                        .stroke(.blue.opacity(0.4), lineWidth: 38)
                        .transformEffect(CGAffineTransform(2, 1, 1, 1, 40, -100))
                        .rotationEffect(.degrees(-30))
                        .frame(width:50)
                        .offset(x:-45,y: -10)
                        .shadow(color: .white, radius: 15.0, x: 0, y: 30)
                    
                }.offset(y:60)
                SpriteView(scene: scene, options: [.allowsTransparency])
                                .ignoresSafeArea()
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).allowsHitTesting(false)
                if (startAnimation) {
                    gifImage("https://media.tenor.com/397DwhVvgK0AAAAi/happy-dance.gif")
                        .frame(width:250)
                        .offset(y:80)
                        .opacity(0.8)
                        .offset(y: startAnimation ? 0 : -4)
                        .animation(.easeIn(duration: 0.5).repeatForever())
                } else {
                    
                    let url = URL(string: "https://media.tenor.com/397DwhVvgK0AAAAi/happy-dance.gif")
                    AsyncImage(url: url, scale: 1.0) {  phase in
                        if let image = phase.image {
                            image.resizable().scaledToFit().frame(width:250).offset(y:-180).onTapGesture() {
                                startAnimation = true
                            } // Displays the loaded image.
                        } else if phase.error != nil {
                            Text("Error in loading url")
                        } else {
                            Color.blue // Acts as a placeholder.
                        }
                    }
                }
            }.offset(x:3,y:200)
              
              
       
         
        }
        .background(Color.blue.opacity(0.9))
    }
}

 


struct GlobePreview: PreviewProvider {
    static var previews: some View {
        Globe()
    }
}
