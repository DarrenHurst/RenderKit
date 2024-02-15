//
//  File.swift
//  
//
//  Created by Hurst, Darren on 2023-09-13.
//

import Foundation
import SwiftUI

@available(iOS 16.0, *)
struct RenderNavigationLink <T> : View {
    var flow : T
    @ObservedObject var data: SampleData
    
    init(_ flow: T, data: SampleData) {
        self.flow = flow
        self.data = data
    }
    
    var body: some View {
        if let flow = flow as? Workflow {
            NavigationLink(destination: flow.componentLanding(view: flow.component, data: data)) {
                Text(flow.component.rawValue)
            }
        }
        
    }
}



