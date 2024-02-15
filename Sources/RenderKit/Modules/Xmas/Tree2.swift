import Foundation
import SwiftUI

@available(iOS 16.0, *)
struct Tree2: View {
    @State var startAnimation: Bool = false
    @State private var particleSystem = ParticleView()
    var body: some View {
        VStack {
            buildTree().anyView
        }.frame(idealWidth:200)
            
    }
    
    func buildTree() -> any View {
        VStack {
            GeometryReader { r in
                Text("#SWIFTUITREE").foregroundColor(Color.white)
                    .offset(x:40, y:20)
                Text("LED TREE").foregroundColor(Color.white)
                    .offset(x:40, y:40)
                ZStack {
                    Image(systemName: "star.fill").font(.XLarge)
                        .offset(x:-3, y:startAnimation ?  -30 : 0 )
                        .opacity(startAnimation ? 0.2 : 0.5)
                    
                        .foregroundColor(
                            Color.yellow.opacity(0.7)
                        )  .animation(Animation.easeIn(duration: 0.9)  , value: startAnimation)
                        .rotation3DEffect(startAnimation ? .degrees(0) : .degrees(360), axis: (0,1,0))
                        .animation(Animation.easeIn(duration: 0.9)   , value: startAnimation)
                    Image(systemName: "star").font(.XLarge)
                        .offset(x:-3, y:startAnimation ?  -30 : 0 )
                        .opacity(startAnimation ? 0.7 : 0.5)
                    
                        .foregroundColor(
                            Color.white.opacity(0.7)
                        )  .animation(Animation.easeIn(duration: 0.9)  , value: startAnimation)
                        .rotation3DEffect(startAnimation ? .degrees(0) : .degrees(360), axis: (0,1,0))
                        .animation(Animation.easeIn(duration: 0.9)   , value: startAnimation)
                     
                    ForEach(1...85, id: \.self) { index in
                        Circle()
                           .stroke(startAnimation ? LinearGradient(colors: [.white, .green, .green, .white], startPoint: .leading, endPoint: .trailing) : LinearGradient(colors: [.white, .white, .green, .green], startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: startAnimation ? 16 : -25))
                          //  .animation(Animation.spring() .repeatForever(), value: startAnimation)
                            .opacity(0.5)
                            //.transformEffect(.init(scaleX: 1, y: 5.1))
                            .frame( height: CGFloat(index * 5) )
                          //  .rotationEffect(.degrees(90))
                            .offset(y: startAnimation ? CGFloat(index * 7) :  CGFloat(index * 3))
                           // .rotation3DEffect(startAnimation ? .degrees(10) : .degrees(360), axis: (1, 0, 0))
                            .animation(Animation.linear(duration: 2.0), value: startAnimation)
                            .opacity(0.1)
                        
                    }
                    //getOrnament(size: 40, offsetX: -50, offsetY: 380)
                  //  getOrnament(size: 40, offsetX: -20, offsetY: 130)
                  //  getOrnament(size: 20, offsetX: -40, offsetY: 190)
                  //  getOrnament(size: 50, offsetX: 0, offsetY: 300)
                  //  getOrnament(size: 90, offsetX: 10, offsetY: 600)
                
                  
                }
             
                .offset(x: 0, y:  -20)
            }.onAppear() {
                startAnimation = true
            }
            .background(Color.black.opacity(0.3))
            .background(Color.blue)
        }
        
    }
    
    func getOrnament(size: CGFloat, offsetX: CGFloat, offsetY: CGFloat) -> some View {
        Circle()
            .fill(startAnimation ?
                  RadialGradient(colors: [.gray.opacity(0.1),.white,.clear, .white], center: UnitPoint(x: 0, y:0), startRadius: 5.0, endRadius: 200.0) :
                    RadialGradient(colors: [.clear,.white,.clear, .gray.opacity(0.1)], center: UnitPoint(x: 0, y:0), startRadius: 5.0, endRadius: 100.0))
            .frame(height:size)
            .offset(x: offsetX, y:offsetY)
    }
}



@available(iOS 16.0, *)
struct Tree2Preview: PreviewProvider {
    static var previews: some View {
        Tree2()
    }
}
