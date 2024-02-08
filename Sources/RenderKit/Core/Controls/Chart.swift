//
//  File.swift
//  
//
//  Created by Darren Hurst on 2024-02-04.
//

import Foundation
import SwiftUI

struct ProgressCircle: View {
    @State var runAnimation: Bool = false
    fileprivate func dials() -> some View{
        VStack{
            ZStack {
                Circle()
                    .stroke(
                        Color.random.opacity(0.5),
                        lineWidth: 30
                    )
                Circle()
                    .trim(from: 0, to: 0.45) // 1
                    .stroke(
                        Color.random,
                        lineWidth: 30
                    )
                    .rotationEffect(runAnimation ? .degrees(360.0) : .degrees(0))
                    .animation(Animation.linear(duration: 5).repeatForever(autoreverses: true), value: runAnimation)
            }.frame(width: 25).padding(20)
            
            ZStack {
                Circle()
                    .stroke(
                        Color.random.opacity(0.2),
                        lineWidth: 5
                    ).zIndex(3.0)
                Circle()
                    .trim(from: 0, to: 0.45) // 1
                    .stroke(
                        Color.random,
                        lineWidth: 5
                    ).zIndex(2.0)
                    .rotationEffect(runAnimation ? .degrees(360.0) : .degrees(0))
                    .animation(Animation.linear(duration: 15).repeatForever(autoreverses: true), value: runAnimation)
                Text("45").rotationEffect(Angle(degrees: 90))
            }.frame(width: 75, height: 75).rotationEffect(Angle(degrees: 270)).padding(.bottom, 10)
           
            ZStack {
                Circle()
                    .stroke(
                        Color.random.opacity(0.2),
                        lineWidth: 15
                    ).zIndex(3.0)
                Circle()
                    .trim(from: 0, to: 0.45) // 1
                    .stroke(
                        Color.random,
                        lineWidth: 5
                    ).zIndex(2.0)
                    .onAppear(){
                        runAnimation = true
                    }
                    .rotationEffect(runAnimation ? .degrees(360.0) : .degrees(0))
                    .animation(Animation.linear(duration: 15).repeatForever(autoreverses: true), value: runAnimation)
                  
                Text("45").rotationEffect(Angle(degrees: 90))
            }.frame(width: 75, height: 75).rotationEffect(Angle(degrees: 270)).padding(.leading, 10)
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                dials().foregroundColor(.random)
                dials().foregroundColor(.random)
                dials().foregroundColor(.random)
            }
        }
    }
}

extension ProgressCircle {
    class viewModel : ObservableObject {
        
        init(){}
    }
}

struct ProgressCirclePreview: PreviewProvider {
    static var previews: some View {
        ProgressCircle()
    }
}
