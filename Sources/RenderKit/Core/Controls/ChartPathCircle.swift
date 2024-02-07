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
    var strokeColorBackground = Color.random
    var textColor = Color.white
    var fillPercent: CGFloat = 45.0
    var rotation: CGFloat = 360.0
    var speed: CGFloat = 3.0
    var autoreverse = false
    var radius = 5.0
    
    
    fileprivate func viewLoad() -> some View {
        return
            ZStack {
                Circle()
                    .stroke(
                        strokeColor.opacity(0.5),
                        lineWidth: 5
                    )
                    .zIndex(3.0)
                    .background(strokeColor.opacity(0.5)).mask(Circle())
                
                Circle()
                    .trim(from: 0, to: 0.45) // 1
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
            .frame(width: 75, height: 75).rotationEffect(Angle(degrees: 270))
            .shadow(radius: radius)
            .onAppear() {
                runAnimation.toggle()
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
        let chart = ChartPathCircle()
        VStack {
            Text("Circle Progress")
            // When
            // Default Chart
            chart
            // Color Set
            ChartPathCircle(strokeColor: .brown, strokeColorBackground: .red, fillPercent: 60.0, speed: 14.0)
           
            // Color Invert
            HStack {
                ChartPathCircle(strokeColor: .black, strokeColorBackground: .cyan, fillPercent: 80.0, speed: 4.0, radius: 4).colorInvert().padding(20)
                ChartPathCircle(strokeColor: .black, strokeColorBackground: .cyan, fillPercent: 80.0, speed: 4.0, radius: 4).padding(20)
            }.background(.black)
            
            // Autoreverses
            ChartPathCircle(fillPercent: 30.0, speed: 5.0, autoreverse: true)
        }
    }
}
