//
//  File.swift
//  
//
//  Created by Darren Hurst on 2024-01-03.
//

import Foundation
import SwiftUI

protocol ThemeProtocol {
    var background: LinearGradient { get set }
    var backgroundColor: Color { get set }
    var backgroundBorder: Color { get set }
    var backgroundOpacity: Double { get set }
    var borderWidth: Double { get set }
    var borderCornerRadius: Double { get set }
    var borderControlWidth: Double { get set }
    var padding: Double { get set }
    var textColor: Color { get set }
    var textColorOff: Color { get set }
    var buttonShape: any Shape { get set }
    var toolbarShape: any Shape { get set }
    var toolbarButtonShape: any Shape { get set }
    var toolbarButtonSelectColor: Color { get set }
    var toolbarBackground: Color { get set }
}
 
struct Config: ThemeProtocol {
    var background: LinearGradient = //Color.clear
     LinearGradient(colors: [.blue.opacity(0.7),.blue.opacity(0.9)], startPoint: UnitPoint.top, endPoint: .bottom)
    var backgroundColor = Color.gray
    var backgroundBorder = Color.black
    var backgroundOpacity = 0.9
   
    var borderWidth = 2.0
    var borderCornerRadius: Double = 10.0
    var borderControlWidth: Double = 3.0
    var padding: Double = 15.0
    var textColor: Color = Color.black
    var textColorOff: Color =  Color.white
    var buttonShape: any Shape = Rectangle()
    var toolbarShape: any Shape = Rectangle()
    var toolbarButtonShape: any Shape = Rectangle()
    var toolbarButtonSelectColor: Color = Color.yellow
    var toolbarBackground: Color = Color.black
    
    
    var currentTheme: ThemeProtocol = Basic()
    init() {
        
    }
    
    init(_ config: ThemeProtocol){
        self.background = config.background
        self.backgroundColor = config.backgroundColor
        self.backgroundBorder = config.backgroundBorder
        self.backgroundOpacity = config.backgroundOpacity
        self.borderWidth = config.borderWidth
        self.borderControlWidth = config.borderControlWidth
        self.borderCornerRadius = config.borderCornerRadius
        self.padding = config.padding
        self.textColor = config.textColor
        self.textColorOff = config.textColorOff
        self.buttonShape = config.buttonShape
        self.toolbarShape = config.toolbarShape
        self.toolbarButtonShape = config.toolbarButtonShape
        self.toolbarButtonSelectColor = config.toolbarButtonSelectColor
        self.toolbarBackground = config.toolbarBackground
    }
    //Rectangle()
    //Circle() //Todo fix segementControl
    //Capsule()
    //RoundedRectangle(cornerRadius: 10.0)
    
}

struct Basic: ThemeProtocol {
    var background = //Color.gray.opacity(0.2)
    LinearGradient(colors: [.green.opacity(0.2),.white.opacity(0.4)], startPoint: UnitPoint.top, endPoint: .bottom)
    var backgroundColor = Color.gray
    var backgroundBorder = Color.black
    var backgroundOpacity = 0.9
   
    var borderWidth = 2.0
    var borderCornerRadius: Double = 10.0
    var borderControlWidth: Double = 3.0
    var padding: Double = 15.0
    var textColor: Color = Color.black
    var textColorOff: Color =  Color.white
    var buttonShape: any Shape = Rectangle()
    var toolbarShape: any Shape = Capsule()
    var toolbarButtonShape: any Shape = Circle()
    var toolbarButtonSelectColor: Color = .white
    var toolbarBackground: Color = Color.white
    
}

struct Unicorn: ThemeProtocol {
    var background: LinearGradient =
    LinearGradient(colors: [.random.opacity(0.7),.white.opacity(0.4)], startPoint: UnitPoint.top, endPoint: .bottom)
    var backgroundColor = Color.random
    var backgroundBorder = Color.black
    var backgroundOpacity = 0.9
   
    var borderWidth = 2.0
    var borderCornerRadius: Double = 10.0
    var borderControlWidth: Double = 3.0
    var padding: Double = 15.0
    var textColor: Color = Color.black
    var textColorOff: Color =  Color.white
    var buttonShape: any Shape = RoundedRectangle(cornerRadius: 10.0)

 
   // var toolbarShape: any Shape = RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
    //var toolbarShape: any Shape = Rectangle()
    var toolbarShape: any Shape = Capsule()
    var toolbarButtonShape: any Shape = Circle()
    //var toolbarButtonShape: any Shape = RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
    var toolbarButtonSelectColor: Color = .blue
    var toolbarBackground:  Color = Color.black
    

}

