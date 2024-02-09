//
//  File.swift
//  
//
//  Created by Darren Hurst on 2024-02-07.
//

import Foundation
import SwiftUI

struct ChartPathCircleStyle {
    var lineWidth = 2.0
    var controlSize: CGSize = CGSize(width: 75, height: 75)
    let rotation: CGFloat = 360.0
    var speed: CGFloat = 3.0
    var radius = 5.0
    var autoreverse = false
    var strokeColor = Color.random
    var strokeColorBackground = Color.gray.opacity(0.4)
    var strokeColorOpacity = 1.0
    var textColor = Color.white
}

struct ChartPathCircle: View {
    @State var runAnimation = false
    var style: ChartPathCircleStyle = ChartPathCircleStyle()
    var fillPercent: CGFloat = 45.0
   
    // -() flip
    let flip = -1.0
    let plop = 1.0
   
    
    fileprivate func viewLoad() -> some View {
        return
            ZStack {
                Circle()
                    .stroke(
                        style.strokeColor.opacity(0.5),
                        lineWidth: 5
                    )
                    .zIndex(3.0)
                    .background(style.strokeColorBackground.opacity(1))
                    .mask(Circle())
                    .opacity(runAnimation ? 1.0 : 0.5)
                
                Circle()
                    .trim(from: 0, to: fillPercent / 100) // 1
                    .stroke(
                        style.strokeColorBackground,
                        lineWidth: style.lineWidth
                    ).zIndex(5.0)
                    .rotationEffect(runAnimation ? .degrees(style.rotation) : .degrees(0))
                    .animation(Animation.linear(duration: style.speed).repeatForever(autoreverses: style.autoreverse), value: runAnimation)
                 
                Text(String(describing: fillPercent))
                    .rotationEffect(Angle(degrees: 90))
                    .foregroundColor(style.textColor)
                    .zIndex(4.0)
            }
            .frame(width: style.controlSize.width, height: style.controlSize.height)
            .rotationEffect(Angle(degrees: 270))
            .shadow(radius: style.radius)
            .scaleEffect(x: runAnimation ? plop : 1, y: runAnimation ? 1 : 1.2, anchor: .topLeading)
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
            
            // Line Set
           let style = ChartPathCircleStyle(lineWidth: 4)
            
            ChartPathCircle(runAnimation: true, style:style)
                .padding(10)
            // Color Invert
            // Run Animation
            ChartPathCircle(runAnimation: true,
                            style: ChartPathCircleStyle(
                                        lineWidth: 10,
                                        speed: 5.0,
                                        radius: 4,
                                        autoreverse: false,
                                        strokeColor: .black,
                                        strokeColorBackground: .pink,
                                        strokeColorOpacity: 0.8,
                                        textColor: .pink))
            .colorInvert()
            .padding(10)
            // Color Set
            // No Animation
            ChartPathCircle(runAnimation: false,
                            style: ChartPathCircleStyle(
                                        lineWidth: 10,
                                        speed: 5.0,
                                        radius: 10,
                                        autoreverse: false,
                                        strokeColor: .black,
                                        strokeColorBackground: .blue,
                                        strokeColorOpacity: 0.8,
                                        textColor: .pink))
            .padding(10)
            // Run Animation
            // Color Set
            // Autoreverse
            ChartPathCircle(runAnimation: true,
                            style: ChartPathCircleStyle(
                                        lineWidth: 10,
                                        speed: 5.0,
                                        radius: 10,
                                        autoreverse: true,
                                        strokeColor: .green,
                                        strokeColorBackground: .orange,
                                        strokeColorOpacity: 0.8,
                                        textColor: .orange))
            .padding(10)
 
          }
    }
}
