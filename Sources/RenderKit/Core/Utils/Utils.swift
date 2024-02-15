//
//  File.swift
//  
//
//  Created by Darren Hurst on 2024-02-12.
//

import Foundation
import SwiftUI


//Replacement for RenderTable Generic Table View
protocol FlowContext {
    associatedtype T
    var component: T? { get set}
    func view(for component: T?, data: SampleData) -> any View
}

extension View {
   var anyView: AnyView {
       AnyView(self)
   }
}

