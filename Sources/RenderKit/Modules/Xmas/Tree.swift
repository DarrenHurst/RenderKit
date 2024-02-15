//
//  File.swift
//  
//
//  Created by Darren Hurst on 2023-12-03.
//

import Foundation
import SwiftUI
import SpriteKit

class OrnamentSelection: ObservableObject {
    @Published var ornamentIndex: Int?
    @Published var gif: (any View)?
}

@available(iOS 16.0, *)
struct Tree: View {
    @State var startAnimation: Bool = false
   // @State private var particleSystem = ParticleView()
    @ObservedObject var model: OrnamentSelection
    
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
        VStack {
            ZStack {
                buildTree().anyView
                SpriteView(scene: snowScene, options: [.allowsTransparency])
                    .ignoresSafeArea()
                    .frame(minWidth: 400, maxWidth: .infinity, minHeight: 600, maxHeight: .infinity).allowsHitTesting(false)
            }
           
        }.frame(idealWidth:300)
        
    }
    var  snowScene: SKScene {
         let scene = SnowScene()
         scene.scaleMode = .resizeFill
         scene.backgroundColor = .clear
         return scene
     }
    func buildTree() -> any View {
        VStack {
            GeometryReader { r in
                
                HStack {
                    Button {
                        model.ornamentIndex = 0
                        let image =  gifImage(images[model.ornamentIndex ?? 0 ])
                       // image.updateUIView(self, context: <#T##Context#>)
                        model.gif = gifImage(images[model.ornamentIndex ?? 0 ])
                        
                              } label: {
                            ZStack {
                                Image(systemName: "chevron.left.circle.fill").resizable().frame(width:50, height:50).padding(.leading, 16).foregroundColor(Color.white.opacity(0.7))
                                Image(systemName: "chevron.left.circle").resizable().frame(width:50, height:50).padding(.leading, 16).foregroundColor(Color.white.opacity(0.3))
                            }
                        }

        
                    model.gif?.anyView
                        .frame(width:200, height:200)
                    //gifImage(images[model.ornamentIndex ?? 0 ])
                   
                        
                    Button {
                        model.ornamentIndex = 1
                        model.gif = gifImage(images[model.ornamentIndex ?? 1 ])
                    } label: {
                        ZStack {
                            Image(systemName: "chevron.right.circle.fill").resizable().frame(width:50, height:50).foregroundColor(Color.white.opacity(0.7))
                            Image(systemName: "chevron.right.circle").resizable().frame(width:50, height:50).foregroundColor(Color.white.opacity(0.3))
                            
                        }
                    }
                     
                }.padding(20)
                
                ZStack {
                   
                    Image(systemName: "star.fill").font(.XLarge).offset(y:-10)
                        .foregroundColor(Color.yellow.opacity(startAnimation ? 0.9 : 0.6))  .animation(Animation.easeIn(duration: 0.9) .repeatForever(), value: startAnimation)
                    Image(systemName: "star").font(.XLarge).offset(y:-10)
                        
                        .foregroundColor(Color.black.opacity(startAnimation ? 0.4 : 0.1))  .animation(Animation.easeIn(duration: 0.9) .repeatForever(), value: startAnimation)
                  
                    ForEach(1...85, id: \.self) { index in
                        Circle()
                            .stroke(startAnimation ? LinearGradient(colors: [.clear, .clear, .white.opacity(0.4), .green], startPoint: .leading, endPoint: .trailing) : LinearGradient(colors: [.clear, .clear, .clear, .white], startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: startAnimation ? 9 : 5))
                            .animation(Animation.easeIn(duration: 1.9) .repeatForever(), value: startAnimation)
                            .opacity(0.3)
                            .transformEffect(.init(scaleX: 6, y: 2))
                            .frame( height: CGFloat(index * 2) )
                            .rotationEffect(.degrees(90))
                            .offset(y: CGFloat(index * 3))
                        
                        
                    }
                    
                    ZStack {
                        getOrnament(size: 40, offsetX: -50, offsetY: 380  )
                            .opacity(0.7).anyView
                        getOrnament(size: 40, offsetX: -20, offsetY: 130 )
                            .opacity(0.9).anyView
                        getOrnament(size: 30, offsetX: -40, offsetY: 190  )
                            .opacity(0.7).anyView
                        getOrnament(size: 50, offsetX: 0, offsetY: 300  )
                            .opacity(0.9).anyView
                        //Globe().frame(width:90)
                        getOrnament(size: 90, offsetX: 10, offsetY: 600 )
                            .opacity(0.7).anyView
                    }
                    
                    ZStack {
                       // particleSystem.offset(x:-20,y:-200)
                        SpriteView(scene: scene, options: [.allowsTransparency])
                                        .ignoresSafeArea()
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).allowsHitTesting(false)
                    }.offset(y:100)
                    
                }.offset(y:-100).opacity(0.9).anyView
               
            }.onAppear() {
                startAnimation = true
               
            }
            .background(Color.black.opacity(0.3))
            .background(Color.blue)
        }
        
    }
    
    func getOrnament(size: CGFloat, offsetX: CGFloat, offsetY: CGFloat) -> any View {

        Circle()
            .fill(startAnimation ?
                  RadialGradient(colors: [.gray.opacity(0.1),.white,.clear, .white], center: UnitPoint(x: 0, y:0), startRadius: 5.0, endRadius: 200.0) :
                    RadialGradient(colors: [.clear,.white,.clear, .gray.opacity(0.1)], center: UnitPoint(x: 0, y:0), startRadius: 5.0, endRadius: 100.0)
            )
            .background(model.gif?.anyView)
            .frame(height:size)
            .offset(x: offsetX, y:offsetY)
             
    }

}

extension SKNode {
    convenience init?(_ name: String, bundle: Bundle) {
        guard let path = bundle.path(forResource: name, ofType: nil) else { return nil }
       
        if let data = FileManager.default.contents(atPath: path) {
            guard let archive = try? NSKeyedUnarchiver(forReadingFrom: data) else { return nil }
            
            self.init(coder: archive)
        }
       return nil
    }
  
}

class SnowScene: SKScene {
  
    let snowEmitterNode = SKEmitterNode("snow", bundle: Bundle.main)

    override func didMove(to view: SKView) {
        guard let snowEmitterNode = snowEmitterNode else { return }
        snowEmitterNode.particleSize = CGSize(width: 50, height: 50)
        snowEmitterNode.particleLifetime = 2
        snowEmitterNode.particleLifetimeRange = 6
        addChild(snowEmitterNode)
    }

    override func didChangeSize(_ oldSize: CGSize) {
        guard let snowEmitterNode = snowEmitterNode else { return }
        snowEmitterNode.particlePosition = CGPoint(x: size.width/2, y: size.height)
        snowEmitterNode.particlePositionRange = CGVector(dx: size.width, dy: size.height)
    }
    

}


import WebKit
struct gifImage: UIViewRepresentable {
    let name: String
    init(_ name: String){
        self.name = name
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = URL(string: name)!
        let data = try! Data(contentsOf: url)
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url.deletingLastPathComponent()
        )
        webView.isOpaque = false
            return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
}


@available(iOS 16.0, *)
struct TreePreview: PreviewProvider {
    static var previews: some View {
        Tree(model: OrnamentSelection())
    }
}
