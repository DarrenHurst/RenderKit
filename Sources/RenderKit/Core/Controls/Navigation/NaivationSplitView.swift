//
//  File.swift
//  
//
//  Created by Darren Hurst on 2024-02-14.
//

import Foundation
import SwiftUI

struct iPadView : View {
    @State private var columnVisibility =
    NavigationSplitViewVisibility.automatic
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility, sidebar: {
            List {
                Text("TODO MENU")
                Text("Link Options")
                Text("Link Options")
                Text("Link Options")
            }
        }, detail: {
            // Call route with no attached toolbar
            NavigationStack {
                let route = Routes.home
                AppRootContext(selectedRoute: route).view(for: route)
                .offset(y:20)
                .padding(60)
                .ignoresSafeArea()
            }
        })
        .navigationSplitViewStyle(.balanced)
        .navigationTitle("What Ever")
        
    }
}

struct iPad_Preview: PreviewProvider {
    static var previews: some View {
        iPadView()
            .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
            .previewDisplayName("iPad")
    }
}
