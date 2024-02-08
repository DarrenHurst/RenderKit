//
//  File.swift
//  
//
//  Created by Darren Hurst on 2024-02-07.
//

import Foundation
import SwiftUI


struct ChartPathCircle: View {
    @State var runAnimation = false
    var strokeColor = Color.random
    var strokeColorBackground = Color.gray.opacity(0.4)
    var strokeColorOpacity = 1.0
    var textColor = Color.white
    var fillPercent: CGFloat = 45.0
    var rotation: CGFloat = 360.0
    var speed: CGFloat = 3.0
    var autoreverse = false
    var radius = 5.0
   
     let controlSize: CGSize = CGSize(width: 75, height: 75)
    
    
    fileprivate func viewLoad() -> some View {
        return
            ZStack {
                Circle()
                    .stroke(
                        strokeColor.opacity(0.5),
                        lineWidth: 5
                    )
                    .zIndex(3.0)
                    .background(strokeColorBackground.opacity(1)).mask(Circle())
                    .opacity(runAnimation ? 1.0 : 0.5)
                
                Circle()
                    .trim(from: 0, to: fillPercent / 100) // 1
                    .stroke(
                       strokeColorBackground,
                        lineWidth: 15
                    ).zIndex(2.0)
                    .rotationEffect(runAnimation ? .degrees(rotation) : .degrees(0))
                    .animation(Animation.linear(duration: speed).repeatForever(autoreverses: autoreverse), value: runAnimation)
                
                Text(String(describing: fillPercent))
                    .rotationEffect(Angle(degrees: 90))
                    .foregroundColor(textColor)
                    .zIndex(4.0)
            }
            .frame(width: controlSize.width, height: controlSize.height)
            .rotationEffect(Angle(degrees: 270))
            .shadow(radius: radius)
            .scaleEffect(x: runAnimation ? -0.4 : 1, y: runAnimation ? 1 : 1.2, anchor: .topLeading)
            .animation(.interpolatingSpring(stiffness: 1, damping: 1).speed(2.85), value: runAnimation)
            
            .onAppear() {
                if runAnimation {
                    runAnimation.toggle()
                }
            }
            .padding(5)
    }
    
    var body: some View {
        viewLoad()
    }
}

struct ChartPathCirclePreview: PreviewProvider {
    static var previews: some View {
        // Given
        let chart = ChartPathCircle(fillPercent: 0)
        VStack {
            Text("Circle Progress")
            // When
            // Default Chart
            chart
                .padding(20)
            // Color Set
            ChartPathCircle(strokeColor: .brown, strokeColorBackground: .pink.opacity(0.1), strokeColorOpacity: 0.5, textColor: .blue, fillPercent: 50.0, speed: 14.0)
           
            // Color Invert
            HStack {
                ChartPathCircle(strokeColor: .black, strokeColorBackground: .brown, fillPercent: 80.0, speed: 4.0, radius: 4).colorInvert().padding(20)
                
                ChartPathCircle(runAnimation: true, strokeColor: .black, strokeColorBackground: .cyan, fillPercent: 80.0, speed: 4.0, radius: 4).padding(20)
            }
            
            // Autoreverses
            ChartPathCircle(runAnimation: true, strokeColor: .green.opacity(0.9),
                            strokeColorBackground: .green.opacity(0.2),
                            strokeColorOpacity: 0.1,
                            fillPercent: 90.0,
                            speed: 5.0)
          }
    }
}
