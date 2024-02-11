//
//  CircleText.swift
//  TicTacToe
//
//  Created by Darren Hurst on 2023-05-26.
//

import Foundation
import SwiftUI

struct CircleText: View {
    @State var controlAnimation: Bool = false
    let title: String = "Package Workflow Composable"
   
    var body: some View {
        ZStack{
            let characters = Array(title)
            let spacer = 360 / characters.count
            let angle = 45
            ForEach(0..<characters.count) { num in
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 1.0, lineCap: .round, lineJoin: .miter, miterLimit: .infinity))
                    .fill(.clear)
                    .background(content: {
                        Text(String(characters[num]))
                            .rotationEffect(Angle(degrees: Double(angle)) , anchor: .center)
                            .font(.callout).foregroundColor(.brown.opacity(0.7))
                    })
                    .rotationEffect(controlAnimation ? Angle(degrees: Double(-(spacer) * num)) : Angle(degrees: Double(-(spacer) * num)) , anchor: .topTrailing)
                    .rotationEffect( Angle(degrees: Double(18)) , anchor: .topTrailing)
                    .frame(width: 115)
                    .offset(x: -48, y:14.0)
            }
        }
         
        .rotationEffect(controlAnimation ? Angle(degrees: 60) : Angle(degrees: Double(-10)) , anchor: .top)
         .animation(.easeInOut.speed(0.2).repeatForever(autoreverses: true), value: controlAnimation)
            .onAppear(){
                controlAnimation = true
            }
            .background(content: {
                Image("logo", bundle: Bundle.main).resizable().frame(width: 140, height: 155).offset(x: controlAnimation ? -8 : 19,y:-18).opacity(0.8)
                    .offset(x:-4,y:-25)
            })  .animation(.easeInOut.speed(0.2).repeatForever(autoreverses: true), value: controlAnimation)
        
    }
}

struct CircleTextPreview: PreviewProvider {
    static var previews: some View {
        CircleText()
    }
}
