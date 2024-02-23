//
//  File.swift
//  
//
//  Created by Darren Hurst on 2024-02-16.
//

import Foundation
import SwiftUI

struct Synth : View {
    @State var animate = false
    var barHeight: CGFloat = 22
    var componentSpeed: CGFloat = 0.20
    var color: Color = Color.random
    var shape: any Shape = Circle()
  
    var body: some View {
        VStack {
            
            TimelineView(.periodic(from: Date.now, by: animate ? componentSpeed : 90)) { _ in
                HStack {
                    ForEach(1..<32) { num in
                        ZStack {
                            shape
                                .fill(color.opacity(animate ? 0.9 : 0.7))
                                .shadow(color: .white, radius: animate ? 1.0 : 2.0)
                                .frame(height: CGFloat.random(in: 1...barHeight))
                               // .scaleEffect(animate ? 1.0 : -1.0)
                                //.animation(.linear(duration: 1.0)
                               .animation(.interactiveSpring()
                                    .speed(4.5).delay(1.7).repeatForever(), value: animate)
                                .anyView
                        }
                    }
                }
            }
            .ignoresSafeArea()
            .padding(20)
        }
        
    }
}

struct SynthPreview : PreviewProvider {
   
    static var previews: some View {
        GeometryReader { r in
            VStack {
                LogoView()
            }
    
            .frame(width: r.size.width, height:r.size.height + 80)
            .background(.black)
            .ignoresSafeArea()
        }
      
    }
}


struct VoiceSynthPreview : PreviewProvider {
   
    static var previews: some View {
 
        //  ViewThatFits {
        ZStack {
            VStack{
                
                Synth(animate: true, barHeight: 44, componentSpeed: 0.93, color: .blue.opacity(0.8), shape: Rectangle())
                    .background(.black.opacity(1))
                    .scaleEffect(0.5)
            }.background(.black)
              
        }
            
          
    }
}


struct LogoView: View {
    @State var animate: Bool = false
    @State var animateLogo: Bool = true
    // TODO fix doesn't update internal state.
    var body: some View {
        let scale = 1.5
        let scalelow = 0.5
        let controlHeight = animate ? 100.0 : -60.0
        
        ZStack {
            VStack{
                Synth(animate: false, barHeight: 50, componentSpeed: 1.0, shape: Rectangle())
                    .frame(height:controlHeight)
                Synth(animate: false, barHeight: 20, componentSpeed: 0.8)
                    .frame(height:controlHeight)
                Synth(animate: false, barHeight: 15, componentSpeed: 0.13, color: .orange)
                    .frame(height:controlHeight)
                Synth(animate: true, barHeight: 65, componentSpeed: 0.23, color: .pink.opacity(0.8))
                    .frame(height:controlHeight)
                    .background(.gray.opacity(0.4))
                    .frame(width: 700)
                    .scaleEffect(0.6)
            }    .scaleEffect( animate ? scalelow : scale)
            VStack {
                Synth(animate: false, barHeight: 50, componentSpeed: 1.0)
                    .offset(y: -40 )
                    .frame(height:controlHeight)
                Synth(animate: false, barHeight: 20, componentSpeed: 0.7)
                    .offset(y: -40 )
                    .frame(height:controlHeight)
                Synth(animate: false, barHeight: 15, componentSpeed: 0.13, color: .orange, shape: Capsule())
                    .offset(y: -40 )
                    .frame(height:controlHeight)
                Synth(animate: true, barHeight: 65, componentSpeed: 0.63, color: .pink.opacity(0.8))
                    .background(.gray.opacity(0.4))
                    .frame(height:controlHeight)
                
                    .scaleEffect(0.6)
                    .offset(y: -40 )
                    .frame(minHeight:75)
                
            }    .scaleEffect( animate ? scalelow : scale)
            
            VStack {
                Text("ObjectFactory")
                    .foregroundColor(.white)
                    .font(.XLarge)
                    .rotationEffect(.degrees( -90.0 ))
                    .offset(y: -40 )
                    .opacity(0.7)
            }     .scaleEffect(animate ? scalelow * 1.25 : scale * 1.33)
            Circle()
                .fill(
                    RadialGradient(colors: [.white.opacity(0.2) , .white.opacity(0.9), .clear], center: .center, startRadius: 3, endRadius: 80))
                .opacity(animateLogo ? 0.5 : 0.7)
                .animation(.linear.speed(0.2).repeatForever(), value: animateLogo)
                .scaleEffect(animate ? scalelow : scale * 1.73)
            Circle()
                .fill(
                    RadialGradient(colors: [.pink.opacity(0.2) , .red.opacity(0.3), .clear], center: .center, startRadius: 3, endRadius: 80))
                .opacity(animateLogo ? 0.5 : 0.7)
                .animation(.linear.speed(0.2).repeatForever(), value: animateLogo)
                .scaleEffect(animate ? scalelow : scale * 1.73)
                .offset(x:0, y:2)
        }
        
        //.offset(x: -150, y:-250)
        
        .rotationEffect(.degrees(90))
        .offset(x:animate ?  0 : 0, y: animate ? 0 : 0)
        .animation(.linear.delay(0.5), value: animate)
        
        .onAppear() {
            animate.toggle()
            animateLogo.toggle()
            
        }
        .onTapGesture() {
            animateLogo.toggle()
        }
       // .mask(Circle().fill()).background(.black)
    }
}
